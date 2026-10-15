//objectcomments Fondo de la Aplicación
forward
global type w_na_fondo from window
end type
type st_empresa from statictext within w_na_fondo
end type
end forward

global type w_na_fondo from window
integer x = 832
integer y = 360
integer width = 3739
integer height = 2540
boolean enabled = false
windowtype windowtype = child!
event ue_post_open ( )
event ue_pic ( )
st_empresa st_empresa
end type
global w_na_fondo w_na_fondo

type variables

window w_login

String	is_tipo_inve
date		idt_fecha_contabilidad
end variables

forward prototypes
public subroutine wf_change_fondo (string as_fondo)
end prototypes

event ue_post_open();String  ls_fondo, ls_nombre, ls_empresa
integer li_ventas_diarias, li_g_financiero, li_empresa, li_formato_decimal_costo, li_mes, li_ann

SQLCA.AutoCommit = True

str.nombre_empresa = gf_dg_nombre_empresa()	//Nombre de la empresa

//---------------------------------
st_empresa.text = str.nombre_empresa

st_empresa.y = w_na_fondo.Height   - 100
st_empresa.x = 10
st_empresa.width = len(str.nombre_empresa) * 37
st_empresa.visible = true

//Recupera el mes y annio de contabilidad, para que no puedan introducir transacciones menores al cierre
  SELECT comparam.para_an_fiscal_actual,   
         comparam.para_mes_fiscal_actual  
    INTO :li_ann,   
         :li_mes  
    FROM comparam  
   WHERE ( comparam.para_g_financiero = :str.g_financiero ) AND  
         ( comparam.para_empresa = :str.empresa )  ;
			if sqlca.sqlcode = -1 then
				mensaje('Aviso','Error al Seleccionar Mes y Año de Contabilidad',sqlca.sqlerrtext)
			end if

idt_fecha_contabilidad = date('01/'+string(li_mes)+'/'+string(li_ann))


end event

public subroutine wf_change_fondo (string as_fondo);
end subroutine

on w_na_fondo.create
this.st_empresa=create st_empresa
this.Control[]={this.st_empresa}
end on

on w_na_fondo.destroy
destroy(this.st_empresa)
end on

event open;sqlca.autocommit = true
This.PostEvent("ue_post_open")
end event

event activate;LONG ll_RC
//ll_RC = DllRegisterServer()
end event

type st_empresa from statictext within w_na_fondo
boolean visible = false
integer x = 137
integer y = 1028
integer width = 1737
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long textcolor = 8388608
long backcolor = 16777215
boolean enabled = false
string text = " "
boolean focusrectangle = false
end type

