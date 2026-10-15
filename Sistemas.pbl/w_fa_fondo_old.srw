//objectcomments Fondo de la Aplicación
forward
global type w_fa_fondo_old from window
end type
type st_empresa from statictext within w_fa_fondo_old
end type
type dw_4 from datawindow within w_fa_fondo_old
end type
type dw_2 from datawindow within w_fa_fondo_old
end type
type dw_1 from datawindow within w_fa_fondo_old
end type
type sle_1 from singlelineedit within w_fa_fondo_old
end type
type gb_1 from groupbox within w_fa_fondo_old
end type
type dw_3 from datawindow within w_fa_fondo_old
end type
end forward

global type w_fa_fondo_old from window
integer x = 832
integer y = 360
integer width = 5042
integer height = 2620
boolean titlebar = true
string title = "Opciones del Sistema"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
windowstate windowstate = maximized!
long backcolor = 1090519039
string icon = "AppIcon!"
event ue_post_open ( )
event ue_pic ( )
event ue_postopen ( )
st_empresa st_empresa
dw_4 dw_4
dw_2 dw_2
dw_1 dw_1
sle_1 sle_1
gb_1 gb_1
dw_3 dw_3
end type
global w_fa_fondo_old w_fa_fondo_old

type prototypes
Function long ShellExecuteA (ulong hwind, string lpOperation, string lpFile, string lpParameters, string lpDirectory, long nShowCmd) library "shell32.dll"
end prototypes

type variables
str_fa_param str_para
str_colores istr_colores
str_aplica_links str_aplica_links
window w_login
datawindowchild idwc_empresa
str_fa_producto strp
Integer	ii_controla_modificaciones
String	is_exclusivo_cliente
date idt_fecha_contabilidad
boolean lb_primera_entrada = true
str_tr_param str_param
//str_cc_formatos str_formato1

uo_configuracion_regional uo_regional
end variables

forward prototypes
public function boolean wf_colores ()
public subroutine wf_change_fondo (string as_fondo)
public subroutine wf_normaliza_opcion1 (integer ai_opcion, string as_campo, datawindow ad_dw)
public function boolean wf_abrir_ventana (string as_opcion, window aw_parent)
end prototypes

event ue_postopen();////
//integer li_existe
//  SELECT favervencidos.ver_vencidos  
//    INTO :li_existe  
//    FROM favervencidos  
//   WHERE ( favervencidos.maquina = :str.maquina )   ;
//	if sqlca.sqlcode = -1 then
//		gf_mensaje('','Error al Validar Ver Vencidos '+sqlca.sqlerrtext,1,1,'E')
//		return
//	elseif sqlca.sqlcode = 100 then
//		li_existe = 1
//	end if
//if isnull(li_existe) then li_existe = 1	
//if li_existe > 0 then
//	opensheet(w_pedidos_vencidos,w_fa_fondo,2,Original!)
//end if
end event

public function boolean wf_colores ();  SELECT colores.fondo_principal,   
         colores.fondo_lateral,   
         colores.fondo_cursor,   
         colores.borde_cursor,   
         colores.titulo_opciones,   
         colores.letras_opciones,   
         colores.letra_seleccion_principal,   
         colores.titulo_opciones_lateral,   
         colores.letras_opciones_lateral,   
         colores.letra_seleccion_lateral  
    INTO :w_fa_fondo.istr_colores.fondo_principal,   
         :w_fa_fondo.istr_colores.fondo_lateral,   
         :w_fa_fondo.istr_colores.fondo_cursor,   
         :w_fa_fondo.istr_colores.borde_cursor,   
         :w_fa_fondo.istr_colores.titulo_opciones,   
         :w_fa_fondo.istr_colores.letras_opciones,   
         :w_fa_fondo.istr_colores.letra_seleccion_principal,   
         :w_fa_fondo.istr_colores.titulo_opciones_lateral,   
         :w_fa_fondo.istr_colores.letras_opciones_lateral,   
         :w_fa_fondo.istr_colores.letra_seleccion_lateral  
    FROM colores  
   WHERE colores.empresa = :str.empresa   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al cargar colores '+sqlca.sqlerrtext,1,1,'E')
	end if

return true
end function

public subroutine wf_change_fondo (string as_fondo);Long ll_x,ll_y,ll_ox,ll_oy,ll_cox,ll_coy
String ls_foto

//-----------Logo dchain para planilla

// Para X
ll_x = This.width/2
//ll_ox = ole_1.width/2
ll_cox = ll_x - ll_ox

// Para Y


ll_y = This.Height/2
//ll_oy = ole_1.Height/2
ll_coy = ll_y - ll_oy

//ole_1.x = ll_cox
//ole_1.y = ll_coy
//ole_1.visible = true
//--------- hasta aqui

ll_ox = sle_1.width/2
ll_cox = ll_x - ll_ox
ll_oy = sle_1.Height/2
ll_coy = ll_y - ll_oy

sle_1.x = ll_cox
sle_1.y =  This.Height - 200 //ll_coy + 600



end subroutine

public subroutine wf_normaliza_opcion1 (integer ai_opcion, string as_campo, datawindow ad_dw);integer i, li_final = 7
string  ls_rectangulo, ls_cadena

for i = 1 to li_final
	ls_rectangulo = "r_"+string(i)
	if ai_opcion = i then	//Pantalla Principal
		//Pone el rectangulo visible
		ad_dw.Modify(ls_rectangulo+".Visible='1'")
		//Cambia el fondo a blanco				
		ad_dw.Modify("fondo"+string(i)+".Background.Color='"+string(w_fa_fondo.istr_colores.fondo_cursor)+"'")//'16777215'") //
		//Para el campo de titulo
		if as_campo = "o"+string(i)+"_titulo" then
			ad_dw.Modify("o"+string(i)+"_titulo.Font.Underline='1'")			
		else
			ad_dw.Modify("o"+string(i)+"_titulo.Font.Underline='0'")
		end if
		//Para el campo de opcion 1
		if as_campo = "o"+string(i)+"_opcion1" then
			ad_dw.Modify("o"+string(i)+"_opcion1.Font.Underline='1'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion1.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_principal)+"'")//'8388608'")//Azul intenso							
			else
				ad_dw.Modify("o"+string(i)+"_opcion1.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_lateral)+"'")//'16777215'")	//Color blanco							
			end if
		else
			ad_dw.Modify("o"+string(i)+"_opcion1.Font.Underline='0'")
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion1.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'") //'16724224'")				
			else
				ad_dw.Modify("o"+string(i)+"_opcion1.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//'16777215'")	//Color blanco				
			end if
		end if
		//Para el campo de opcion 2
		if as_campo = "o"+string(i)+"_opcion2" then
			ad_dw.Modify("o"+string(i)+"_opcion2.Font.Underline='1'")			
			if ad_dw = dw_3 then			
				ad_dw.Modify("o"+string(i)+"_opcion2.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_principal)+"'")//'8388608'")
			else
				ad_dw.Modify("o"+string(i)+"_opcion2.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_lateral)+"'")//'16777215'")	//Color blanco
			end if
		else
			ad_dw.Modify("o"+string(i)+"_opcion2.Font.Underline='0'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion2.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'") //'16724224'")				
			else
				ad_dw.Modify("o"+string(i)+"_opcion2.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//'16777215'")	//Color blanco
			end if
		end if
		//Para el campo de opcion 3
		if as_campo = "o"+string(i)+"_opcion3" then
			ad_dw.Modify("o"+string(i)+"_opcion3.Font.Underline='1'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion3.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_principal)+"'")//'8388608'")								
			else
				ad_dw.Modify("o"+string(i)+"_opcion3.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_lateral)+"'")//'16777215'")	//Color blanco
			end if
		else
			ad_dw.Modify("o"+string(i)+"_opcion3.Font.Underline='0'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion3.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")// '16724224'")	
			else
				ad_dw.Modify("o"+string(i)+"_opcion3.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//'16777215'")	//Color blanco
			end if
		end if		
		//Para el campo de opcion 4
		if as_campo = "o"+string(i)+"_opcion4" then
			ad_dw.Modify("o"+string(i)+"_opcion4.Font.Underline='1'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion4.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_principal)+"'")//'8388608'")								
			else
				ad_dw.Modify("o"+string(i)+"_opcion4.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_lateral)+"'")//'16777215'")	//Color blanco
			end if
		else
			ad_dw.Modify("o"+string(i)+"_opcion4.Font.Underline='0'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion4.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")// '16724224'")	
			else
				ad_dw.Modify("o"+string(i)+"_opcion4.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//'16777215'")	//Color blanco
			end if
		end if		
		
		//Para el campo de opcion 5
		if as_campo = "o"+string(i)+"_opcion5" then
			ad_dw.Modify("o"+string(i)+"_opcion5.Font.Underline='1'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion5.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_principal)+"'")//'8388608'")								
			else
				ad_dw.Modify("o"+string(i)+"_opcion5.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_lateral)+"'")//'16777215'")	//Color blanco
			end if
		else
			ad_dw.Modify("o"+string(i)+"_opcion5.Font.Underline='0'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion5.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")// '16724224'")	
			else
				ad_dw.Modify("o"+string(i)+"_opcion5.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//'16777215'")	//Color blanco
			end if
		end if		
	
		//Para el campo de opcion 6
		if as_campo = "o"+string(i)+"_opcion6" then
			ad_dw.Modify("o"+string(i)+"_opcion6.Font.Underline='1'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion6.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_principal)+"'")//'8388608'")								
			else
				ad_dw.Modify("o"+string(i)+"_opcion6.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_lateral)+"'")//'16777215'")	//Color blanco
			end if
		else
			ad_dw.Modify("o"+string(i)+"_opcion6.Font.Underline='0'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion6.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")// '16724224'")	
			else
				ad_dw.Modify("o"+string(i)+"_opcion6.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//'16777215'")	//Color blanco
			end if
		end if		
		//Para el campo de opcion 7
		if as_campo = "o"+string(i)+"_opcion7" then
			ad_dw.Modify("o"+string(i)+"_opcion7.Font.Underline='1'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion7.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_principal)+"'")//'8388608'")								
			else
				ad_dw.Modify("o"+string(i)+"_opcion7.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_lateral)+"'")//'16777215'")	//Color blanco
			end if
		else
			ad_dw.Modify("o"+string(i)+"_opcion7.Font.Underline='0'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion7.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")// '16724224'")	
			else
				ad_dw.Modify("o"+string(i)+"_opcion7.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//'16777215'")	//Color blanco
			end if
		end if		

		//Para el campo de opcion 7
		if as_campo = "o"+string(i)+"_opcion8" then
			ad_dw.Modify("o"+string(i)+"_opcion8.Font.Underline='1'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion8.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_principal)+"'")//'8388608'")								
			else
				ad_dw.Modify("o"+string(i)+"_opcion8.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_lateral)+"'")//'16777215'")	//Color blanco
			end if
		else
			ad_dw.Modify("o"+string(i)+"_opcion8.Font.Underline='0'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion8.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")// '16724224'")	
			else
				ad_dw.Modify("o"+string(i)+"_opcion8.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//'16777215'")	//Color blanco
			end if
		end if		

	
		//Para el campo de opcion 8
		if as_campo = "o"+string(i)+"_opcion9" then
			ad_dw.Modify("o"+string(i)+"_opcion9.Font.Underline='1'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion9.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_principal)+"'")//'8388608'")								
			else
				ad_dw.Modify("o"+string(i)+"_opcion9.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_lateral)+"'")//'16777215'")	//Color blanco
			end if
		else
			ad_dw.Modify("o"+string(i)+"_opcion9.Font.Underline='0'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion9.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")// '16724224'")	
			else
				ad_dw.Modify("o"+string(i)+"_opcion9.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//'16777215'")	//Color blanco
			end if
		end if		


		//Para el campo de opcion 10
		if as_campo = "o"+string(i)+"_opcion10" then
			ad_dw.Modify("o"+string(i)+"_opcion10.Font.Underline='1'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion10.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_principal)+"'")//'8388608'")								
			else
				ad_dw.Modify("o"+string(i)+"_opcion10.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_lateral)+"'")//'16777215'")	//Color blanco
			end if
		else
			ad_dw.Modify("o"+string(i)+"_opcion10.Font.Underline='0'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion10.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")// '16724224'")	
			else
				ad_dw.Modify("o"+string(i)+"_opcion10.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//'16777215'")	//Color blanco
			end if
		end if		
	
	
		//Para el campo de opcion 11
		if as_campo = "o"+string(i)+"_opcion11" then
			ad_dw.Modify("o"+string(i)+"_opcion11.Font.Underline='1'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion11.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_principal)+"'")//'8388608'")								
			else
				ad_dw.Modify("o"+string(i)+"_opcion11.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_lateral)+"'")//'16777215'")	//Color blanco
			end if
		else
			ad_dw.Modify("o"+string(i)+"_opcion11.Font.Underline='0'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion11.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")// '16724224'")	
			else
				ad_dw.Modify("o"+string(i)+"_opcion11.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//'16777215'")	//Color blanco
			end if
		end if		
	
		//Para el campo de opcion 12
		if as_campo = "o"+string(i)+"_opcion12" then
			ad_dw.Modify("o"+string(i)+"_opcion12.Font.Underline='1'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion12.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_principal)+"'")//'8388608'")								
			else
				ad_dw.Modify("o"+string(i)+"_opcion12.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_lateral)+"'")//'16777215'")	//Color blanco
			end if
		else
			ad_dw.Modify("o"+string(i)+"_opcion12.Font.Underline='0'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion12.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")// '16724224'")	
			else
				ad_dw.Modify("o"+string(i)+"_opcion12.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//'16777215'")	//Color blanco
			end if
		end if		

		//Para el campo de opcion 13
		if as_campo = "o"+string(i)+"_opcion13" then
			ad_dw.Modify("o"+string(i)+"_opcion13.Font.Underline='1'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion13.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_principal)+"'")//'8388608'")								
			else
				ad_dw.Modify("o"+string(i)+"_opcion13.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_lateral)+"'")//'16777215'")	//Color blanco
			end if
		else
			ad_dw.Modify("o"+string(i)+"_opcion13.Font.Underline='0'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion13.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")// '16724224'")	
			else
				ad_dw.Modify("o"+string(i)+"_opcion13.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//'16777215'")	//Color blanco
			end if
		end if		

		//Para el campo de opcion 14
		if as_campo = "o"+string(i)+"_opcion14" then
			ad_dw.Modify("o"+string(i)+"_opcion14.Font.Underline='1'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion14.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_principal)+"'")//'8388608'")								
			else
				ad_dw.Modify("o"+string(i)+"_opcion14.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_lateral)+"'")//'16777215'")	//Color blanco
			end if
		else
			ad_dw.Modify("o"+string(i)+"_opcion14.Font.Underline='0'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion14.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")// '16724224'")	
			else
				ad_dw.Modify("o"+string(i)+"_opcion14.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//'16777215'")	//Color blanco
			end if
		end if		

		//Para el campo de opcion 15
		if as_campo = "o"+string(i)+"_opcion15" then
			ad_dw.Modify("o"+string(i)+"_opcion15.Font.Underline='1'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion15.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_principal)+"'")//'8388608'")								
			else
				ad_dw.Modify("o"+string(i)+"_opcion15.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_lateral)+"'")//'16777215'")	//Color blanco
			end if
		else
			ad_dw.Modify("o"+string(i)+"_opcion15.Font.Underline='0'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion15.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")// '16724224'")	
			else
				ad_dw.Modify("o"+string(i)+"_opcion15.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//'16777215'")	//Color blanco
			end if
		end if		

		//Para el campo de opcion 16
		if as_campo = "o"+string(i)+"_opcion16" then
			ad_dw.Modify("o"+string(i)+"_opcion16.Font.Underline='1'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion16.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_principal)+"'")//'8388608'")								
			else
				ad_dw.Modify("o"+string(i)+"_opcion16.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_lateral)+"'")//'16777215'")	//Color blanco
			end if
		else
			ad_dw.Modify("o"+string(i)+"_opcion16.Font.Underline='0'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion16.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")// '16724224'")	
			else
				ad_dw.Modify("o"+string(i)+"_opcion16.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//'16777215'")	//Color blanco
			end if
		end if		


		//Para el campo de la imagen
		if as_campo = "imagen"+string(i) then
			ad_dw.Modify("imagen"+string(i)+".Border='6'")		
		else
			ad_dw.Modify("imagen"+string(i)+".Border='0'")		
		end if		
	else
		ad_dw.Modify("o"+string(i)+"_titulo.Font.Underline='0'")			
		ad_dw.Modify(ls_rectangulo+".Pen.Color='"+string(w_fa_fondo.istr_colores.borde_cursor)+"'")		//rectangulo
		ad_dw.Modify("o"+string(i)+"_opcion1.Font.Underline='0'")	
		ad_dw.Modify("o"+string(i)+"_opcion2.Font.Underline='0'")		
		ad_dw.Modify("o"+string(i)+"_opcion3.Font.Underline='0'")		
		ad_dw.Modify("o"+string(i)+"_opcion4.Font.Underline='0'")		
		ad_dw.Modify("o"+string(i)+"_opcion5.Font.Underline='0'")
		ad_dw.Modify("o"+string(i)+"_opcion6.Font.Underline='0'")		
		ad_dw.Modify("o"+string(i)+"_opcion7.Font.Underline='0'")				
		ad_dw.Modify("o"+string(i)+"_opcion8.Font.Underline='0'")						
		ad_dw.Modify("o"+string(i)+"_opcion9.Font.Underline='0'")						
		ad_dw.Modify("o"+string(i)+"_opcion10.Font.Underline='0'")						
		ad_dw.Modify("o"+string(i)+"_opcion11.Font.Underline='0'")						
		ad_dw.Modify("o"+string(i)+"_opcion12.Font.Underline='0'")								
		ad_dw.Modify("o"+string(i)+"_opcion13.Font.Underline='0'")								
		ad_dw.Modify("o"+string(i)+"_opcion14.Font.Underline='0'")								
		ad_dw.Modify("o"+string(i)+"_opcion15.Font.Underline='0'")									
		ad_dw.Modify("o"+string(i)+"_opcion16.Font.Underline='0'")											
		if ad_dw = dw_3 then
			ad_dw.Modify("o"+string(i)+"_titulo.Color='"+string(w_fa_fondo.istr_colores.titulo_opciones)+"'") //color del titulo
			ad_dw.Modify("o"+string(i)+"_opcion1.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")//'16724224'")	//Azul intenso
			ad_dw.Modify("o"+string(i)+"_opcion2.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")//=Letras de las opciones
			ad_dw.Modify("o"+string(i)+"_opcion3.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")//=
			ad_dw.Modify("o"+string(i)+"_opcion4.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")//=			
			ad_dw.Modify("o"+string(i)+"_opcion5.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")//=						
			ad_dw.Modify("o"+string(i)+"_opcion6.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")//=									
			ad_dw.Modify("o"+string(i)+"_opcion7.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")//=												
			ad_dw.Modify("o"+string(i)+"_opcion8.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")//=															
			ad_dw.Modify("o"+string(i)+"_opcion9.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")//=															
			ad_dw.Modify("o"+string(i)+"_opcion10.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")//=																		
			ad_dw.Modify("o"+string(i)+"_opcion11.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")//=	
			ad_dw.Modify("o"+string(i)+"_opcion12.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")//=				
			ad_dw.Modify("o"+string(i)+"_opcion13.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")//=							
			ad_dw.Modify("o"+string(i)+"_opcion14.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")//=							
			ad_dw.Modify("o"+string(i)+"_opcion15.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")//=										
			ad_dw.Modify("o"+string(i)+"_opcion16.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")//=													
			ad_dw.Modify("fondo"+string(i)+".Background.Color='"+string(w_fa_fondo.istr_colores.fondo_principal)+"'")//'15400938'") //verde claro				
		else
			ad_dw.Modify("o"+string(i)+"_titulo.Color='"+string(w_fa_fondo.istr_colores.titulo_opciones_lateral)+"'") //color del titulo
			ad_dw.Modify("o"+string(i)+"_opcion1.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//'16776960'")		//Aqua
			ad_dw.Modify("o"+string(i)+"_opcion2.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//=	
			ad_dw.Modify("o"+string(i)+"_opcion3.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//=			
			ad_dw.Modify("o"+string(i)+"_opcion4.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//=						
			ad_dw.Modify("o"+string(i)+"_opcion5.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//=									
			ad_dw.Modify("o"+string(i)+"_opcion6.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//=												
			ad_dw.Modify("o"+string(i)+"_opcion7.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//=															
			ad_dw.Modify("o"+string(i)+"_opcion8.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//=																		
			ad_dw.Modify("o"+string(i)+"_opcion9.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//=																		
			ad_dw.Modify("o"+string(i)+"_opcion10.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//=																					
			ad_dw.Modify("o"+string(i)+"_opcion11.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//=																					
			ad_dw.Modify("o"+string(i)+"_opcion12.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//=																								
			ad_dw.Modify("o"+string(i)+"_opcion13.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//=																								
			ad_dw.Modify("o"+string(i)+"_opcion14.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//=																											
			ad_dw.Modify("o"+string(i)+"_opcion15.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//=																											
			ad_dw.Modify("o"+string(i)+"_opcion16.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//=																														
			ad_dw.Modify("DataWindow.Color='"+string(w_fa_fondo.istr_colores.fondo_lateral)+"'")//'15400938'") //												
		end if
		ad_dw.Modify("imagen"+string(i)+".Border='0'")		
		if ad_dw.describe(ls_rectangulo+".visible") = '1' then
			ad_dw.Modify(ls_rectangulo+".Visible=0")
		end if

	end if
next
end subroutine

public function boolean wf_abrir_ventana (string as_opcion, window aw_parent);string ls_ventana, ls_null
integer li_tipo
str_fa_formato lstr_datawindow		
choose case as_opcion

	case 'o1_opcion1'	//	
		ls_ventana = dw_3.getitemstring(1,'o3_ventana1')
		SetPointer(HourGlass!)		
		
		if str.imprime_fiscal = 1 then	//Facturacion de Pesos, decimales en la cantidad
			OpenSheetWithparm(w_facturacion_fiscal,0,aw_parent,2, Original!)			
		else
			//OpenSheetWithparm(w_facturacion,0,aw_parent,2, Original!)			
			Opensheet(w_facturacion, aw_parent, 0, Layered! )
//			w_facturacion lw_wnd1
//			w_fa_co_consulta_existencia lw_wnd2
//
//			// Abrir la primera ventana
//			lw_wnd1 = CREATE w_facturacion
//			lw_wnd1.Open()
//			
//			lw_wnd2 = CREATE w_fa_co_consulta_existencia
//			lw_wnd2.Open()
			
		end if
		SetPointer(Arrow!)
										
	case 'o1_opcion2'	//	
		ls_ventana = dw_3.getitemstring(1,'o3_ventana3')
		
//		OpenSheetWithparm(w_orden_facturacion,0,aw_parent,2, Original!)			
				
//			LLAMADO A EJECUTABLE
//		SetNull (ls_null)
//		ShellExecuteA(Handle(this), ls_null, "C:\Sistemas\Hymsoft\Sistemas\prefactura.exe" ,ls_null, ls_null, 1)
	case 'o1_opcion3'	//	
		
		OpenSheet(w_transacciones,aw_parent,2, Original!)
									
	case 'o1_opcion4'	//	
		
//		OpenSheetwithparm(w_fixing,1,aw_parent,2, Original!)			
		ls_ventana = dw_3.getitemstring(1,'o2_ventana1')
		
		if str.contabiliza = 0 then
			OpenSheet(w_entrada,aw_parent,2, Original!)
		else
			OpenSheet(w_entrada_arriba,aw_parent,2, Original!)
		end if
															

	case 'o1_opcion5'	//	
		
//		OpenSheetwithparm(w_cierre_fixing,1,aw_parent,2, Original!)			
		OpenSheetwithparm(w_generar_cargos_por_mora,1,aw_parent,2, Original!)			
											
	case 'o1_opcion6'	//	
		
		OpenSheet(w_captura_pedidos,str.frame,2,Original!)
								
	case 'o1_opcion7'	//	
		
		if str.imprime_fiscal = 1 or pos(upper(str.empr_acceso_especial),'CITY') > 0 then
			OpenSheet(w_captura_proformas_fiscal,str.frame,2,Original!)
		else
			OpenSheet(w_captura_proformas,str.frame,2,Original!)
		end if
								
	case 'o1_opcion8' // Clientes Con Metal Pendiente, sacar de Saldos de Clientes
		
		OpenSheet(w_orden_compra,str.frame,2, Original!)
													
	case 'o1_opcion9' // Clientes Con Metal Pendiente, sacar de Saldos de Clientes
		
		OpenSheet(w_transito,str.frame,2, Original!)
													

	case 'o1_opcion10' // Clientes Con Metal Pendiente, sacar de Saldos de Clientes
		
		OpenSheet(w_captura_proformas_productos_no_creados,str.frame,2, Original!)
							
	case 'o1_opcion11' // Pases Adicionales
		
		OpenSheet(w_pases_adicionales,str.frame,2, Original!)
							
		
		/*		
	case 'o1_opcion7' //	
		if gf_mensaje('','Facturar Metal Pendiente ?',2,2,'E') = 1 then
			OpenSheetwithparm(w_facturacion,1,aw_parent,2, Original!)			
		end if
	case 'o1_opcion9' //
		
		OpenSheet(w_movimiento_metal,aw_parent,2, Layered!)
													
		
	case 'o1_opcion10' //
		
		OpenSheetwithparm(w_cierre_metal,1,aw_parent,2, Original!)			
									
*/
//	case 'o1_opcion11' //
//		ls_ventana = dw_3.getitemstring(1,'o2_ventana1')
//		
//		if str.contabiliza = 0 then
//			OpenSheet(w_entrada,aw_parent,2, Original!)
//		else
//			OpenSheet(w_entrada_arriba,aw_parent,2, Original!)
//		end if
//	
//    case 'o1_opcion12' //
//		
//		OpenSheetwithparm(w_generar_cargos_por_mora,1,aw_parent,2, Original!)			
//									
//		
	case	'o2_opcion1'	 //	
		ls_ventana = dw_3.getitemstring(1,'o5_ventana1')
		
		str_rangofecha lstr_rangfech		
		opensheetWithParm(w_cc_ranf_antig,lstr_rangfech,str.frame,2,Original!)		
		//OpenSheet(w_reporte_proveedor,aw_parent,2, Original!)
										

	case	'o2_opcion2'	 //	
		
		OpenSheet(w_reportes_ventas,str.frame,2, Original!)
		
	
	case 'o2_opcion3'	//	
		
		OpenSheet(w_reporte_inventario,str.frame,2, Layered!)
				
		
	case 'o2_opcion4'	//	
		ls_ventana = dw_3.getitemstring(1,'o2_ventana4')
		
		OpenSheet(w_reporte_entradas, aw_parent,2, Original!) //Entrada de Trafico
							
	
	case 'o2_opcion5'	//	
		
		OpenSheet(w_reporte_clientes,aw_parent,2, Original!)
							

	case  'o2_opcion6'	//	
		
		OpenSheet(w_cc_ranf_cobros,str.frame,2,Original!)
					
		
	case 'o2_opcion7'	//	
		
		OpenSheet(w_reporte_transferencias, aw_parent,2, Original!) 
						
		
	case 'o2_opcion8'	//	
		
		OpenSheet(w_reporte_ajustes, aw_parent,2, Original!) 
						

	case 'o2_opcion9'	//	
		//
		OpenSheet(w_reporte_ordenes, aw_parent,2, Original!) 
		//				
	case 'o2_opcion10'	//	
		//
		OpenSheet(w_rotacion_del_inventario, aw_parent,2, Layered!) 
	case 'o2_opcion11'	//	
		//
		OpenSheet(w_reporte_antiguedad_inventario, aw_parent,2, Layered!) 
	case 'o2_opcion12'	//	
		//
		OpenSheet(w_productos_sin_movimiento, aw_parent,2, Layered!) 
	case 'o2_opcion13'	//	
		//
		OpenSheet(w_sugerido_de_compras, aw_parent,2, Layered!) 
	case 'o2_opcion14'	//	
		//
		OpenSheet(w_reporte_mas_vendidos, aw_parent,2, Layered!) 
	case 'o2_opcion15'	//	
		//
		OpenSheet(w_catalogos, aw_parent,2, Layered!) 

case 'o3_opcion1'	//	
		
		if str.contabiliza = 0 then
			OpenSheet(w_ajustes,aw_parent,2, Original!)
		else
			OpenSheet(w_ajustes_costeando,aw_parent,2, Original!)
		end if
									

	case 'o3_opcion2'	//
		
		OpenSheet(w_transacciones_cxp,aw_parent,2, Original!)
																			

	case 'o3_opcion3'	//	
		
		OpenSheet(w_transacciones_conta,aw_parent,2, Original!)
											

	case 'o3_opcion4'	//	
		
		OpenSheet(w_caja_menuda_transito,aw_parent,2, Original!)
													

	case 'o3_opcion5' //
		
		OpenSheet(w_transacciones_banco,aw_parent,2, Original!)
																			

	case 'o3_opcion6' //
		
		OpenSheet(w_ajustes_caja,aw_parent,2, Original!)
															
		

	case 'o3_opcion7' //
		
//		OpenSheetwithparm(w_entrada_plateria,1,aw_parent,2, Original!)			
		OpenSheetwithparm(w_transferencia,1,aw_parent,2, Original!)			
					

	case 'o3_opcion8' //
		
		OpenSheetwithparm(w_captura_depositos,1,aw_parent,2, Original!)			
											
	
//	case 'o3_opcion9' //
//		
//		OpenSheetwithparm(w_transferencia,1,aw_parent,2, Original!)			
//											
//								
	case 'o4_opcion1'	//
		window				lw_child
		lstr_datawindow.datawindow = "dw_co_fa_consulta_existencias_elbros" //dw_co_fa_consulta_factura
		OpenSheetWithParm(lw_child, lstr_datawindow,'w_fa_co_consulta_existencia', str.frame,2,Original!)				
		
	case 'o4_opcion2'	//	
		
		Window lw_child_v				
		str_kardex  str_opcion
		
			str_opcion.opcion_menu = 'MCP'
			str_opcion.opcion_ventana    = 'P'
			str_opcion.dwpantalla     = 'dw_in_mcp_prod_kard_1'
			if str.contabiliza = 0 then
				str_opcion.dwreporte      = 'dw_in_mcp_prod_kard_2'
			else
				str_opcion.dwreporte      = 'dw_in_mcp_prod_kard_2_arriba'
			end if
			str_opcion.titulo_ventana = 'Movimientos de Productos (Kardex) '
			str_opcion.kproducto=''
			
			if isvalid(w_in_movi_prod_kardex) then
				w_in_movi_prod_kardex.bringtotop = true
				w_in_movi_prod_kardex.setredraw(true)
			else
				OpenSheetWithParm(w_in_movi_prod_kardex,str_opcion,str.frame,2,Original!)		
			end if
//			OpenSheetWithParm(lw_child_v,str_opcion,"w_in_movi_prod_kardex",str.frame,2,Original!)		
		
	case 'o4_opcion3'	//	
				
		opensheet(w_historial_cliente,aw_parent,2,Original!)		//Ventas por producto
						
		
	case 'o4_opcion4'	//	
		SetPointer(HourGlass!)
		str_cc_formatos str_formato1
		str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
		Opensheetwithparm(w_estadocuenta,str_formato1,str.frame,2,original!)
		
	case 'o4_opcion5'	//	
				
		w_facturas_actualizadas	lw_
		opensheet(lw_,aw_parent,2,Original!)
						
	
	case 'o4_opcion6'	//	
				
		w_consulta_transacciones	lw_2
		opensheet(lw_2,aw_parent,2,Original!)		
				
		
//		OpenSheet(w_depositos,aw_parent,2, Original!)
	case 'o4_opcion7' //
		ls_ventana = dw_3.getitemstring(1,'o3_ventana4')
				
		lstr_datawindow.datawindow = "dw_fa_rep_reserva_existencia_new"
		OpenSheetWithParm(w_disponibles,lstr_datawindow, aw_parent,2, Original!)
							

	case 'o4_opcion8' //
		ls_ventana = dw_3.getitemstring(1,'o3_ventana4')
				
		str_cc_rangofecha str_formato2
		Opensheetwithparm(w_estado_cta_cxp,str_formato2,str.frame,2,original!)		
									
		
	case 'o4_opcion9' //		
				
		w_consulta_transacciones_cxp	lw_3
		opensheet(lw_3,aw_parent,2,Original!)		
				
		
	case 'o4_opcion10' //
		
		OpenSheet(w_conciliacion_bancaria,aw_parent,2, Original!)
																					
	case 'o4_opcion11' //
				
		opensheet(w_consulta_transacciones_conta,aw_parent,2,Original!)		
				
	case 'o4_opcion12' //			
				
		opensheet(w_reporte_cuentas_bancarias,aw_parent,2,Layered!)		
						

case 'o4_opcion13'	//CIERRES MENSUALES	
		
		OpenSheet(w_cierre_mensual,aw_parent,2, Original!)
																			

	case 'o5_opcion1' //
		ls_ventana = dw_3.getitemstring(1,'o1_ventana1')
		
//		OpenSheet(w_subir_saldos_clientes, aw_parent,2, Original!)
//		OpenSheet(w_subir_saldos_provee, aw_parent,2, Original!)
		OpenSheet(w_colores,aw_parent,2, Original!)
			

	case 'o5_opcion2'	//			
		ls_ventana = dw_3.getitemstring(1,'o1_ventana2')
		
		OpenSheet(w_mant_clientes,aw_parent,2, Original!)
			
	case 'o5_opcion3' //
		ls_ventana = dw_3.getitemstring(1,'o1_ventana3')
		str_kardex  str_opciones
		OpenSheetwithparm(w_productos,str_opciones,aw_parent,2, Original!)
					
		
	case 'o5_opcion4'	//
		ls_ventana = dw_3.getitemstring(1,'o1_ventana4')
		
		OpenSheet(w_mant_proveedores,aw_parent,2, Original!)
							
		
	case 'o5_opcion5' //			
		ls_ventana = dw_3.getitemstring(1,'o1_ventana5')
		OpenSheet(w_parametros_generales,aw_parent,2, Original!)
		//open(w_main)
		
	case 'o5_opcion6'	//
		
		OpenSheet(w_plan_de_cuentas,aw_parent,2, Original!)
											
		
	case 'o5_opcion7'	//	
		ls_ventana = dw_3.getitemstring(1,'o2_ventana2')
		
		w_fa_fondo.setredraw(false)
		OpenSheet(w_parametros_entradas,aw_parent,2, Original!)
					

	case 'o5_opcion8'	//	
		ls_ventana = dw_3.getitemstring(1,'o3_ventana2')
		
		OpenSheet(w_parametros_salidas,aw_parent,2, Original!)
						

	case 'o5_opcion9'	//
		
		OpenSheet(w_usuarios,aw_parent,2, Original!)
			
		
	case 'o5_opcion10'	//
		
		OpenSheet(w_directorio_telefonico,aw_parent,2, Layered!)
			
		
	case 'o5_opcion11'	//
		
		OpenSheet(w_fa_co_fotos_asig,aw_parent,2, Original!)
			

case 'o6_opcion1'	//	
		
		str_cc_formatos lstr_sec
		w_reporte_transacciones_bco 	lw_4
		opensheetwithparm(lw_4,lstr_sec,aw_parent,2,Original!)		
			

	case 'o6_opcion2' //
		
		OpenSheet(w_antiguedad_cxp,aw_parent,2, Original!) //w_movimiento_metal
											
		
	case 'o6_opcion3' //
		
		OpenSheet(w_reporte_proveedores,aw_parent,2, Original!)
						
		
	case 'o6_opcion4' //
		
		OpenSheet(w_rep_transacciones_cxp,aw_parent,2, Original!)
							
			
	case 'o6_opcion5' //
		
		OpenSheet(w_reporte_historico_cuentas,aw_parent,2, Original!)
							
		
	case 'o6_opcion6' //
		
		OpenSheet(w_reporte_balance_de_prueba,aw_parent,2, Layered!)
								
	
	case 'o6_opcion7' //
		
		OpenSheet(w_ventas_resumen,str.frame,2,Original!)
					
		
	case 'o6_opcion8' //
		
		OpenSheet(w_reporte_auxiliares,aw_parent,2, Original!)
							

	case 'o6_opcion9'	//		
		
		OpenSheet(w_reporte_estados_financieros,aw_parent,2, Layered!)
							

	case 'o6_opcion10' //
//		
		OpenSheet(w_reporte_mayor_general,aw_parent,2, Original!)
//							
		
end choose


return true
end function

on w_fa_fondo_old.create
this.st_empresa=create st_empresa
this.dw_4=create dw_4
this.dw_2=create dw_2
this.dw_1=create dw_1
this.sle_1=create sle_1
this.gb_1=create gb_1
this.dw_3=create dw_3
this.Control[]={this.st_empresa,&
this.dw_4,&
this.dw_2,&
this.dw_1,&
this.sle_1,&
this.gb_1,&
this.dw_3}
end on

on w_fa_fondo_old.destroy
destroy(this.st_empresa)
destroy(this.dw_4)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.sle_1)
destroy(this.gb_1)
destroy(this.dw_3)
end on

event open;sqlca.autocommit =true

//This.PostEvent("ue_post_open")

String  ls_fondo, ls_nombre, ls_titulo_kardex, ls_titulo_reservado,ls_retorno, &
		ls_titulo_entradas, ls_titulo_estado, ls_titulo_factura, ls_empresa, ls_dberror, ls_descrip, ls_ventana
integer li_mes, li_ann, li_ventas_diarias, li_g_financiero, li_empresa, li_opcion, li_nivel, i
integer li_opcion11,  li_opcion12,   li_opcion13,  li_opcion14,  li_opcion15,  li_opcion16,  li_opcion17,   li_opcion18,   li_opcion19,   li_opcion110,   li_opcion21,  li_opcion111, &
       li_opcion22,   li_opcion23,   li_opcion24,   li_opcion25,   li_opcion26,   li_opcion27,   li_opcion28,   li_opcion29,   li_opcion210,   li_opcion31,   li_opcion32,   li_opcion33,   &
	  li_opcion34,   li_opcion35,   li_opcion36,   li_opcion37,   li_opcion38,   li_opcion39,   li_opcion310,   li_opcion311,   li_opcion312,   li_opcion313,   li_opcion314,   li_opcion315,   li_opcion41,   &
       li_opcion42,  li_opcion43,   li_opcion44,   li_opcion45,   li_opcion46,   li_opcion47,   li_opcion48,   li_opcion49,   li_opcion410,   li_opcion411,   li_opcion412,   li_opcion413,   li_opcion414,   &
       li_opcion415,   li_opcion416,   li_opcion417,   li_opcion418,   li_opcion419,   li_opcion420,    &
       li_opcion51, li_opcion52,  li_opcion53,   li_opcion54,   li_opcion55,   li_opcion56,   li_opcion57,   li_opcion58,   li_opcion59,   li_opcion510,   li_opcion511,   li_opcion512,   li_opcion513,   li_opcion514,   &
       li_opcion515,   li_opcion516,   li_opcion517,   li_opcion518,   li_opcion519,   li_opcion520,   li_opcion71, &
	  li_opcion61, li_opcion62,  li_opcion63,   li_opcion64,   li_opcion65,   li_opcion66,   li_opcion67,   li_opcion68,   li_opcion69,   li_opcion610,   li_opcion611,   li_opcion612,   li_opcion613,   li_opcion614,   &
       li_opcion615,   li_opcion616,   li_opcion617,   li_opcion618,   li_opcion619,   li_opcion620   , li_opcion211, li_opcion212, li_opcion213
			 
long ll_gris = 12171705

SQLCA.AutoCommit = True

//uo_configuracion_regional 

uo_regional = create uo_configuracion_regional 

uo_regional.of_getvalores()
uo_regional.of_setvalores()



//gf_fa_param()		//Carga la estructura de Facturacion

if lb_primera_entrada then
	//open(w_acceso)
	open(w_login_modern)
	ls_retorno = message.stringparm
	if ls_retorno <> 'OK' then
		halt close
	end if
	lb_primera_entrada = false
end if

wf_colores()

dw_2.Modify("DataWindow.Color='"+string(w_fa_fondo.istr_colores.fondo_lateral)+"'")//'15400938'") //									
dw_2.triggerevent("ue_microhelp")
dw_3.triggerevent("ue_microhelp")
//
dw_1.insertrow(1)
//dw_1.setitem(1,'empresa',ls_empresa)
wf_change_fondo("")

dw_4.getchild('empresa',idwc_empresa)
idwc_empresa.settransobject(sqlca)
idwc_empresa.retrieve(str.usuario)
if idwc_empresa.rowcount() > 1 then
	dw_4.insertrow(1)
	dw_4.setitem(1,'empresa',str.empresa)
	dw_4.visible = true
	st_empresa.visible = true
else
	dw_4.visible = false
	st_empresa.visible = false
end if


//CARGALAS OPCIONES DEL MENU
dw_3.settransobject(sqlca)
dw_3.insertrow(1)
dw_2.settransobject(sqlca)
dw_2.insertrow(1)

	Declare cur_opciones cursor for
	  SELECT opciones.nivel,   
         opciones.opcion,   
         opciones.descripcion
		FROM opciones  ;
	  	if sqlca.sqlcode = -1 then
			ls_dberror = sqlca.sqlerrtext
			gf_mensaje("","Error al declarar el cursor "+ls_dberror,1,1,'E')
			return
		End If

		open cur_opciones;
	  	if sqlca.sqlcode = -1 then
			ls_dberror = sqlca.sqlerrtext
			gf_mensaje("","Error al Abrir el cursor "+ls_dberror,1,1,'E')
			return
		End If		
		
			//Selecciona el primer registro del cursor
		fetch cur_opciones into :li_nivel, :li_opcion, :ls_descrip;	
		if sqlca.sqlcode = -1 then
			ls_dberror = sqlca.sqlerrtext
			gf_mensaje("","Error en el Fetch el cursor "+ls_dberror,1,1,'E')
			return
		End If
		
		 DO WHILE SQLCA.SQLCODE = 0	
			i ++
				if li_opcion = 0 then	//imagen
					dw_3.setitem(1,'imagen'+string(li_nivel),ls_descrip)								
					dw_2.setitem(1,'imagen'+string(li_nivel),ls_descrip)								
				elseif li_opcion = 1 then	//titulo
					dw_3.setitem(1,'o'+string(li_nivel)+'_titulo',ls_descrip)				
					dw_2.setitem(1,'o'+string(li_nivel)+'_titulo',ls_descrip)									
				else
					dw_3.setitem(1,'o'+string(li_nivel)+'_opcion'+string(li_opcion - 1), ls_descrip)
					dw_2.setitem(1,'o'+string(li_nivel)+'_opcion'+string(li_opcion - 1), ls_descrip)
//					dw_3.setitem(1,'o'+string(li_nivel)+'_ventana'+string(li_opcion - 1), ls_ventana)
					//dw_2.setitem(1,'o'+string(li_nivel)+'_ventana'+string(li_opcion - 1), ls_ventana)					
					//incluir ventana en el dw_2
				end if
		
				fetch cur_opciones into :li_nivel, :li_opcion, :ls_descrip ;	
				if sqlca.sqlcode = -1 then
					ls_dberror = sqlca.sqlerrtext
					gf_mensaje("","Error en el Fetch el cursor "+ls_dberror,1,1,'E')
					return
				End If
		 LOOP
		
		close cur_opciones;
		
//
//Recupera el mes y annio de contabilidad, para que no puedan introducir transacciones menores al cierre
  SELECT comparam.para_ann_actual,   
         comparam.para_mes_actual  
    INTO :li_ann,   
         :li_mes  
    FROM comparam  
   WHERE ( comparam.para_g_financiero = :str.g_financiero ) AND  
         ( comparam.para_empresa = :str.empresa )  ;
			if sqlca.sqlcode = -1 then
				mensaje('Aviso','Error al Seleccionar Mes y Año de Contabilidad',sqlca.sqlerrtext)
			end if

idt_fecha_contabilidad = date('01/'+string(li_mes)+'/'+string(li_ann))
		
		
//selecciona el nombre de la empresa
  SELECT dgmempre.empr_razon_social  , empr_acceso_especial, empr_valor_fixing, isnull(empr_clave_estados_de_cuenta,''), empr_bodegas_definidas, isnull(empr_bodega1,''), isnull(empr_bodega2,''), isnull(empr_bodega3,''), isnull(empr_bodega4,''), isnull(empr_bodega5,''), isnull(empr_bodega6,''), isnull(empr_bodega7,'')
    INTO :str.nombre_empresa , :str.empr_acceso_especial, :str.valor_fixing, :str.clave_estado_de_cuenta, :str.bodegas_definidas, :str.bodega1, :str.bodega2, :str.bodega3, :str.bodega4, :str.bodega5, :str.bodega6, :str.bodega7
    FROM dgmempre  
   WHERE ( dgmempre.empr_g_financiero = :str.g_financiero ) AND  
         ( dgmempre.empr_empresa = :str.empresa ) ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al seleccionar el nombre de la empresa '+sqlca.sqlerrtext,1,1,'E')
			end if
sle_1.text = str.nombre_empresa + ' - HYMSOFT V 2.0'
str.frame.title = str.nombre_empresa	+ ' SISTEMA INTEGRADO HymSoft V 2.0'		

wf_normaliza_opcion1(0, '', dw_2)

SELECT usuarios_accesos.priv_opcion11,   
         usuarios_accesos.priv_opcion12,   
         usuarios_accesos.priv_opcion13,   
         usuarios_accesos.priv_opcion14,   
         usuarios_accesos.priv_opcion15,   
         usuarios_accesos.priv_opcion16,   
         usuarios_accesos.priv_opcion17,   
         usuarios_accesos.priv_opcion18,   
         usuarios_accesos.priv_opcion19,   
         usuarios_accesos.priv_opcion110,   
         usuarios_accesos.priv_opcion111,   
         usuarios_accesos.priv_opcion21,   
         usuarios_accesos.priv_opcion22,   
         usuarios_accesos.priv_opcion23,   
         usuarios_accesos.priv_opcion24,   
         usuarios_accesos.priv_opcion25,   
         usuarios_accesos.priv_opcion26,   
         usuarios_accesos.priv_opcion27,   
         usuarios_accesos.priv_opcion28,   
         usuarios_accesos.priv_opcion29,   
         usuarios_accesos.priv_opcion210,   
         usuarios_accesos.priv_opcion31,   
         usuarios_accesos.priv_opcion32,   
         usuarios_accesos.priv_opcion33,   
         usuarios_accesos.priv_opcion34,   
         usuarios_accesos.priv_opcion35,   
         usuarios_accesos.priv_opcion36,   
         usuarios_accesos.priv_opcion37,   
         usuarios_accesos.priv_opcion38,   
         usuarios_accesos.priv_opcion39,   
         usuarios_accesos.priv_opcion310,   
         usuarios_accesos.priv_opcion311,   
         usuarios_accesos.priv_opcion312,   
         usuarios_accesos.priv_opcion313,   
         usuarios_accesos.priv_opcion314,   
         usuarios_accesos.priv_opcion315,   
         usuarios_accesos.priv_opcion41,   
         usuarios_accesos.priv_opcion42,   
         usuarios_accesos.priv_opcion43,   
         usuarios_accesos.priv_opcion44,   
         usuarios_accesos.priv_opcion45,   
         usuarios_accesos.priv_opcion46,   
         usuarios_accesos.priv_opcion47,   
         usuarios_accesos.priv_opcion48,   
         usuarios_accesos.priv_opcion49,   
         usuarios_accesos.priv_opcion410,   
         usuarios_accesos.priv_opcion411,   
         usuarios_accesos.priv_opcion412,   
         usuarios_accesos.priv_opcion413,   
         usuarios_accesos.priv_opcion414,   
         usuarios_accesos.priv_opcion415,   
         usuarios_accesos.priv_opcion416,   
         usuarios_accesos.priv_opcion417,   
         usuarios_accesos.priv_opcion418,   
         usuarios_accesos.priv_opcion419,   
         usuarios_accesos.priv_opcion420,   
         usuarios_accesos.priv_opcion51,   
         usuarios_accesos.priv_opcion52,   
         usuarios_accesos.priv_opcion53,   
         usuarios_accesos.priv_opcion54,   
         usuarios_accesos.priv_opcion55,   
         usuarios_accesos.priv_opcion56,   
         usuarios_accesos.priv_opcion57,   
         usuarios_accesos.priv_opcion58,   
         usuarios_accesos.priv_opcion59,   
         usuarios_accesos.priv_opcion510,   
         usuarios_accesos.priv_opcion511,   
         usuarios_accesos.priv_opcion512,   
         usuarios_accesos.priv_opcion513,   
         usuarios_accesos.priv_opcion514,   
         usuarios_accesos.priv_opcion515,   
         usuarios_accesos.priv_opcion516,   
         usuarios_accesos.priv_opcion517,   
         usuarios_accesos.priv_opcion518,   
         usuarios_accesos.priv_opcion519,   
         usuarios_accesos.priv_opcion520,   
         usuarios_accesos.priv_opcion61,   
         usuarios_accesos.priv_opcion62,   
         usuarios_accesos.priv_opcion63,   
         usuarios_accesos.priv_opcion64,   
         usuarios_accesos.priv_opcion65,   
         usuarios_accesos.priv_opcion66,   
         usuarios_accesos.priv_opcion67,   
         usuarios_accesos.priv_opcion68,   
         usuarios_accesos.priv_opcion69,   
         usuarios_accesos.priv_opcion610,   
         usuarios_accesos.priv_opcion611,   
         usuarios_accesos.priv_opcion612,   
         usuarios_accesos.priv_opcion613,   
         usuarios_accesos.priv_opcion614,   
         usuarios_accesos.priv_opcion615,   
         usuarios_accesos.priv_opcion71,
         usuarios_accesos.priv_opcion211,
         usuarios_accesos.priv_opcion212,
         usuarios_accesos.priv_opcion213   			
    INTO :li_opcion11,   
         :li_opcion12,   
         :li_opcion13,   
         :li_opcion14,   
         :li_opcion15,   
         :li_opcion16,   
         :li_opcion17,   
         :li_opcion18,   
         :li_opcion19,   
         :li_opcion110,   
         :li_opcion111,   
         :li_opcion21,   
         :li_opcion22,   
         :li_opcion23,   
         :li_opcion24,   
         :li_opcion25,   
         :li_opcion26,   
         :li_opcion27,   
         :li_opcion28,   
         :li_opcion29,   
         :li_opcion210,   
         :li_opcion31,   
         :li_opcion32,   
         :li_opcion33,   
         :li_opcion34,   
         :li_opcion35,   
         :li_opcion36,   
         :li_opcion37,   
         :li_opcion38,   
         :li_opcion39,   
         :li_opcion310,   
         :li_opcion311,   
         :li_opcion312,   
         :li_opcion313,   
         :li_opcion314,   
         :li_opcion315,   
         :li_opcion41,   
         :li_opcion42,   
         :li_opcion43,   
         :li_opcion44,   
         :li_opcion45,   
         :li_opcion46,   
         :li_opcion47,   
         :li_opcion48,   
         :li_opcion49,   
         :li_opcion410,   
         :li_opcion411,   
         :li_opcion412,   
         :li_opcion413,   
         :li_opcion414,   
         :li_opcion415,   
         :li_opcion416,   
         :li_opcion417,   
         :li_opcion418,   
         :li_opcion419,   
         :li_opcion420,   
         :li_opcion51,   
         :li_opcion52,   
         :li_opcion53,   
         :li_opcion54,   
         :li_opcion55,   
         :li_opcion56,   
         :li_opcion57,   
         :li_opcion58,   
         :li_opcion59,   
         :li_opcion510,   
         :li_opcion511,   
         :li_opcion512,   
         :li_opcion513,   
         :li_opcion514,   
         :li_opcion515,   
         :li_opcion516,   
         :li_opcion517,   
         :li_opcion518,   
         :li_opcion519,   
         :li_opcion520,   
         :li_opcion61,   
         :li_opcion62,   
         :li_opcion63,   
         :li_opcion64,   
         :li_opcion65,   
         :li_opcion66,   
         :li_opcion67,   
         :li_opcion68,   
         :li_opcion69,   
         :li_opcion610,   
         :li_opcion611,   
         :li_opcion612,   
         :li_opcion613,   
         :li_opcion614,   
         :li_opcion615,
         :li_opcion71,
		:li_opcion211,
		:li_opcion212,
		:li_opcion213
    FROM usuarios_accesos  
   WHERE ( usuarios_accesos.priv_g_financiero = :str.g_financiero ) AND  
         ( usuarios_accesos.priv_empresa = :str.empresa ) AND  
         ( usuarios_accesos.priv_usuario = :str.usuario )   ;
	if sqlca.sqlcode = -1 then 
		gf_mensaje('','Error al buscar accesos '+ sqlca.sqlerrtext,1,1,'E')
	end if

	if li_opcion11 = 0 then 
		dw_3.Modify("o1_opcion1.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o1_opcion1.Pointer='Arrow!'")
	end if
	if li_opcion12 = 0 then
		dw_3.Modify("o1_opcion2.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o1_opcion2.Pointer='Arrow!'")
	end if
	if li_opcion13 = 0 then 
		dw_3.Modify("o1_opcion3.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o1_opcion3.Pointer='Arrow!'")		
	end if
	if li_opcion14 = 0 then 
		dw_3.Modify("o1_opcion4.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o1_opcion4.Pointer='Arrow!'")		
	end if
	if li_opcion15 = 0 then 
		dw_3.Modify("o1_opcion5.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o1_opcion5.Pointer='Arrow!'")		
	end if
	if li_opcion16 = 0 then 
		dw_3.Modify("o1_opcion6.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o1_opcion6.Pointer='Arrow!'")		
	end if
	if li_opcion17 = 0 then 
		dw_3.Modify("o1_opcion7.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o1_opcion7.Pointer='Arrow!'")		
	end if
	if li_opcion18 = 0 then 
		dw_3.Modify("o1_opcion8.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o1_opcion8.Pointer='Arrow!'")		
	end if
	if li_opcion19 = 0 then 
		dw_3.Modify("o1_opcion9.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o1_opcion9.Pointer='Arrow!'")		
	end if
	if li_opcion110 = 0 then 
		dw_3.Modify("o1_opcion10.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o1_opcion10.Pointer='Arrow!'")		
	end if
	if li_opcion111 = 0 then 
		dw_3.Modify("o1_opcion11.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o1_opcion11.Pointer='Arrow!'")		
	end if

	//opcion 2
	if li_opcion21 = 0 then 
		dw_3.Modify("o2_opcion1.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o2_opcion1.Pointer='Arrow!'")
	end if
	if li_opcion22 = 0 then
		dw_3.Modify("o2_opcion2.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o2_opcion2.Pointer='Arrow!'")
	end if
	if li_opcion23 = 0 then 
		dw_3.Modify("o2_opcion3.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o2_opcion3.Pointer='Arrow!'")		
	end if
	if li_opcion24 = 0 then 
		dw_3.Modify("o2_opcion4.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o2_opcion4.Pointer='Arrow!'")		
	end if
	if li_opcion25 = 0 then 
		dw_3.Modify("o2_opcion5.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o2_opcion5.Pointer='Arrow!'")		
	end if
	if li_opcion26 = 0 then 
		dw_3.Modify("o2_opcion6.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o2_opcion6.Pointer='Arrow!'")		
	end if
	if li_opcion27 = 0 then 
		dw_3.Modify("o2_opcion7.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o2_opcion7.Pointer='Arrow!'")		
	end if
	if li_opcion28 = 0 then 
		dw_3.Modify("o2_opcion8.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o2_opcion8.Pointer='Arrow!'")		
	end if
	if li_opcion29 = 0 then 
		dw_3.Modify("o2_opcion9.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o2_opcion9.Pointer='Arrow!'")		
	end if
	if li_opcion210 = 0 then 
		dw_3.Modify("o2_opcion10.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o2_opcion10.Pointer='Arrow!'")		
	end if
	if li_opcion211 = 0 then 
		dw_3.Modify("o2_opcion11.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o2_opcion11.Pointer='Arrow!'")		
	end if
	if li_opcion212 = 0 then 
		dw_3.Modify("o2_opcion12.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o2_opcion12.Pointer='Arrow!'")		
	end if
	if li_opcion213 = 0 then 
		dw_3.Modify("o2_opcion13.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o2_opcion13.Pointer='Arrow!'")		
	end if	
//opcio 3
	if li_opcion31 = 0 then 
		dw_3.Modify("o3_opcion1.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o3_opcion1.Pointer='Arrow!'")
	end if
	if li_opcion32 = 0 then
		dw_3.Modify("o3_opcion2.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o3_opcion2.Pointer='Arrow!'")
	end if
	if li_opcion33 = 0 then 
		dw_3.Modify("o3_opcion3.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o3_opcion3.Pointer='Arrow!'")		
	end if
	if li_opcion34 = 0 then 
		dw_3.Modify("o3_opcion4.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o3_opcion4.Pointer='Arrow!'")		
	end if
	if li_opcion35 = 0 then 
		dw_3.Modify("o3_opcion5.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o3_opcion5.Pointer='Arrow!'")		
	end if
	if li_opcion36 = 0 then 
		dw_3.Modify("o3_opcion6.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o3_opcion6.Pointer='Arrow!'")		
	end if
	if li_opcion37 = 0 then 
		dw_3.Modify("o3_opcion7.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o3_opcion7.Pointer='Arrow!'")		
	end if
	if li_opcion38 = 0 then 
		dw_3.Modify("o3_opcion8.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o3_opcion8.Pointer='Arrow!'")		
	end if
	if li_opcion39 = 0 then 
		dw_3.Modify("o3_opcion9.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o3_opcion9.Pointer='Arrow!'")		
	end if
	if li_opcion310 = 0 then 
		dw_3.Modify("o3_opcion10.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o3_opcion10.Pointer='Arrow!'")		
	end if
	if li_opcion311 = 0 then 
		dw_3.Modify("o3_opcion11.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o3_opcion11.Pointer='Arrow!'")		
	end if	
//opcio 4
	if li_opcion41 = 0 then 
		dw_3.Modify("o4_opcion1.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o4_opcion1.Pointer='Arrow!'")
	end if
	if li_opcion42 = 0 then
		dw_3.Modify("o4_opcion2.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o4_opcion2.Pointer='Arrow!'")
	end if
	if li_opcion43 = 0 then 
		dw_3.Modify("o4_opcion3.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o4_opcion3.Pointer='Arrow!'")		
	end if
	if li_opcion44 = 0 then 
		dw_3.Modify("o4_opcion4.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o4_opcion4.Pointer='Arrow!'")		
	end if
	if li_opcion45 = 0 then 
		dw_3.Modify("o4_opcion5.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o4_opcion5.Pointer='Arrow!'")		
	end if
	if li_opcion46 = 0 then 
		dw_3.Modify("o4_opcion6.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o4_opcion6.Pointer='Arrow!'")		
	end if
	if li_opcion47 = 0 then 
		dw_3.Modify("o4_opcion7.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o4_opcion7.Pointer='Arrow!'")		
	end if
	if li_opcion48 = 0 then 
		dw_3.Modify("o4_opcion8.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o4_opcion8.Pointer='Arrow!'")		
	end if
	if li_opcion49 = 0 then 
		dw_3.Modify("o4_opcion9.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o4_opcion9.Pointer='Arrow!'")		
	end if
	if li_opcion410 = 0 then 
		dw_3.Modify("o4_opcion10.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o4_opcion10.Pointer='Arrow!'")		
	end if
	if li_opcion411 = 0 then 
		dw_3.Modify("o4_opcion11.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o4_opcion11.Pointer='Arrow!'")		
	end if
	if li_opcion412 = 0 then 
		dw_3.Modify("o4_opcion12.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o4_opcion12.Pointer='Arrow!'")		
	end if
//opcion 5
	if li_opcion51 = 0 then 
		dw_3.Modify("o5_opcion1.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o5_opcion1.Pointer='Arrow!'")
	end if
	if li_opcion52 = 0 then
		dw_3.Modify("o5_opcion2.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o5_opcion2.Pointer='Arrow!'")
	end if
	if li_opcion53 = 0 then 
		dw_3.Modify("o5_opcion3.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o5_opcion3.Pointer='Arrow!'")		
	end if
	if li_opcion54 = 0 then 
		dw_3.Modify("o5_opcion4.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o5_opcion4.Pointer='Arrow!'")		
	end if
	if li_opcion55 = 0 then 
		dw_3.Modify("o5_opcion5.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o5_opcion5.Pointer='Arrow!'")		
	end if
	if li_opcion56 = 0 then 
		dw_3.Modify("o5_opcion6.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o5_opcion6.Pointer='Arrow!'")		
	end if
	if li_opcion57 = 0 then 
		dw_3.Modify("o5_opcion7.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o5_opcion7.Pointer='Arrow!'")		
	end if
	if li_opcion58 = 0 then 
		dw_3.Modify("o5_opcion8.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o5_opcion8.Pointer='Arrow!'")		
	end if
	if li_opcion59 = 0 then 
		dw_3.Modify("o5_opcion9.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o5_opcion9.Pointer='Arrow!'")		
	end if
	if li_opcion510 = 0 then 
		dw_3.Modify("o5_opcion10.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o5_opcion10.Pointer='Arrow!'")		
	end if
	if li_opcion511 = 0 then 
		dw_3.Modify("o5_opcion11.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o5_opcion11.Pointer='Arrow!'")		
	end if
	if li_opcion512 = 0 then 
		dw_3.Modify("o5_opcion12.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o5_opcion12.Pointer='Arrow!'")		
	end if

//opcion 6
	if li_opcion61 = 0 then 
		dw_3.Modify("o6_opcion1.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o6_opcion1.Pointer='Arrow!'")
	end if
	if li_opcion62 = 0 then
		dw_3.Modify("o6_opcion2.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o6_opcion2.Pointer='Arrow!'")
	end if
	if li_opcion63 = 0 then 
		dw_3.Modify("o6_opcion3.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o6_opcion3.Pointer='Arrow!'")		
	end if
	if li_opcion64 = 0 then 
		dw_3.Modify("o6_opcion4.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o6_opcion4.Pointer='Arrow!'")		
	end if
	if li_opcion65 = 0 then 
		dw_3.Modify("o6_opcion5.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o6_opcion5.Pointer='Arrow!'")		
	end if
	if li_opcion66 = 0 then 
		dw_3.Modify("o6_opcion6.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o6_opcion6.Pointer='Arrow!'")		
	end if
	if li_opcion67 = 0 then 
		dw_3.Modify("o6_opcion7.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o6_opcion7.Pointer='Arrow!'")		
	end if
	if li_opcion68 = 0 then 
		dw_3.Modify("o6_opcion8.Color='"+string(ll_gris)+"'")								
		dw_3.Modify("o6_opcion8.Pointer='Arrow!'")		
	end if
	if li_opcion69 = 0 then 
		dw_3.Modify("o6_opcion9.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o6_opcion9.Pointer='Arrow!'")
	end if
	if li_opcion610 = 0 then
		dw_3.Modify("o6_opcion10.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o6_opcion10.Pointer='Arrow!'")
	end if
	if li_opcion611 = 0 then 
		dw_3.Modify("o6_opcion11.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o6_opcion11.Pointer='Arrow!'")		
	end if
	if li_opcion612 = 0 then 
		dw_3.Modify("o6_opcion12.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o6_opcion12.Pointer='Arrow!'")		
	end if
	if li_opcion613 = 0 then 
		dw_3.Modify("o6_opcion13.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o6_opcion13.Pointer='Arrow!'")		
	end if
	if li_opcion614 = 0 then 
		dw_3.Modify("o6_opcion14.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o6_opcion14.Pointer='Arrow!'")		
	end if
	if li_opcion615 = 0 then 
		dw_3.Modify("o6_opcion15.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o6_opcion15.Pointer='Arrow!'")		
	end if
//opcion 7
	if li_opcion61 = 0 then 
		dw_3.Modify("o7_opcion1.Color='"+string(ll_gris)+"'")							
		dw_3.Modify("o7_opcion1.Pointer='Arrow!'")		
	end if

this.postevent('ue_postopen')
end event

event resize;dw_2.height = newheight - 10
//sle_1.y = newheight - 150
dw_3.width = This.width - 805
dw_3.height= This.Height - 10
//gb_1.height = newheight - 200
//gb_1.width  = newwidth - 100
//gb_1.x = 50
//gb_1.y = 100
//
//sle_2.width = newwidth - 190
end event

event close;uo_regional.of_setvalores_anteriores()

end event

event activate;PrintSetPrinter (str.printer1)
end event

type st_empresa from statictext within w_fa_fondo_old
integer x = 4087
integer y = 64
integer width = 402
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "EMPRESAS"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_4 from datawindow within w_fa_fondo_old
integer x = 3973
integer y = 132
integer width = 690
integer height = 100
integer taborder = 40
string title = "none"
string dataobject = "dw_external_empresas"
boolean border = false
boolean livescroll = true
end type

event itemchanged;accepttext()
String	ls_aplicacion
Integer	li_pos, li_rtn_msg, li_i=1, li_j, j, li_top
str_active_sheet str_wsheet


str_wsheet.wSheet[li_i] = str.frame.GetFirstSheet()
//str_wsheet.wSheet[li_i] = w_fa_fondo.GetFirstSheet()

IF IsValid(str_wsheet.wSheet[li_i]) THEN

	str_wsheet.titulo[li_i] = str_wsheet.wsheet[li_i].Title
	str_wsheet.nombre[li_i] = str_wsheet.wsheet[li_i].ClassName()

	If IsValid(str_wsheet.wSheet[li_i]) And (lower(Right(str_wsheet.nombre[li_i],5)) = "fondo" And Len(str_wsheet.nombre[li_i]) = 10 ) Then
			str_wsheet.wSheet[li_i] = str.frame.GetNextSheet(str_wsheet.wSheet[li_i])
			if IsValid(str_wsheet.wSheet[li_i]) then
				str_wsheet.titulo[li_i] = str_wsheet.wsheet[li_i].Title
				str_wsheet.nombre[li_i] = str_wsheet.wsheet[li_i].ClassName()
			end if
	end if
	
		DO WHILE IsValid(str_wsheet.wSheet[li_i])				
			j ++
			
			if j > 8 then exit
			
			If (lower(Right(str_wsheet.nombre[li_i],5)) = "fondo" And Len(str_wsheet.nombre[li_i]) = 10 ) Then 
				li_j = li_i
				li_i++
				str_wsheet.wSheet[li_i] = str.frame.GetNextSheet(str_wsheet.wSheet[li_j])
				Continue
			else
				li_j = li_i
				li_i++
				str_wsheet.wSheet[li_i] = str.frame.GetNextSheet(str_wsheet.wSheet[li_j])
			end if
			
			If Not IsValid(str_wsheet.wSheet[li_i]) Then Continue
			
				str_wsheet.titulo[li_i] = str_wsheet.wsheet[li_i].Title
				str_wsheet.nombre[li_i] = str_wsheet.wsheet[li_i].ClassName()
		LOOP

	//	if upperbound(str_wsheet.nombre) > 1 then OpenWithParm(w_active_sheets, str_wsheet)
	
li_top = UpperBound(str_wsheet.wSheet[]) - 1
If li_top > 0 Then
	FOR li_i=1 TO li_top
		if len(str_wsheet.nombre[li_i]) = 0 then continue
		close(str_wsheet.wsheet[li_i])
	NEXT
End If
	
//	End if
END IF


str.empresa = integer(data)
  SELECT dgmempre.empr_razon_social  
    INTO :str.nombre  
    FROM dgmempre  
   WHERE ( dgmempre.empr_g_financiero = :str.g_financiero ) AND  
         ( dgmempre.empr_empresa = :str.empresa )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al buscar nombre '+sqlca.sqlerrtext,1,1,'E')
	end if

parent.triggerevent('open')

end event

type dw_2 from datawindow within w_fa_fondo_old
event ue_micro_help pbm_nchittest
boolean visible = false
integer width = 805
integer height = 2532
integer taborder = 40
string title = "dw_fondo_pantalla_principal"
string dataobject = "dw_external_opciones_lateral"
boolean border = false
boolean livescroll = true
end type

event ue_micro_help;////Para cuando pasa por encima del objeto
////Override
//return
//
//Integer li_pos, li_x, li_y,li_largo
//String ls_objeto, ls_col
//
//ls_objeto = This.GetObjectAtPointer()
//li_pos = pos  (ls_objeto,"~t")
//ls_col = left (ls_objeto, li_pos - 1)
//
//
//// Dependiendo de la Columna el Mensaje de Ayuda varía
//CHOOSE CASE ls_col
//	CASE 'o1_titulo', 'o1_opcion1', 'o1_opcion2', 'o1_opcion3', 'o1_opcion4', 'o1_opcion5', 'o1_opcion6', 'o1_opcion7'
//		wf_normaliza_opcion1(1, ls_col, dw_2)
////--------------------------------------------------------
//	CASE 'o2_titulo', 'o2_opcion1', 'o2_opcion2', 'o2_opcion3', 'o2_opcion4', 'o2_opcion5', 'o2_opcion6'
//		wf_normaliza_opcion1(2, ls_col, dw_2)
////--------------------------------------------------------		
//	CASE 'o3_titulo', 'o3_opcion1', 'o3_opcion2', 'o3_opcion3', 'o3_opcion4', 'o3_opcion5', 'o3_opcion6', 'o3_opcion7', 'o3_opcion8', 'o3_opcion9'
//		wf_normaliza_opcion1(3, ls_col, dw_2)
////--------------------------------------------------------		
//	CASE 'o4_titulo', 'o4_opcion1', 'o4_opcion2', 'o4_opcion3', 'o4_opcion4', 'o4_opcion5', 'o4_opcion6', 'o4_opcion7', 'o4_opcion8', 'o4_opcion9', 'o4_opcion10'
//		wf_normaliza_opcion1(4, ls_col, dw_2)
////--------------------------------------------------------		
//	CASE 'o5_titulo', 'o5_opcion1', 'o5_opcion2', 'o5_opcion3', 'o5_opcion4', 'o5_opcion5', 'o5_opcion6', 'o5_opcion7', 'o5_opcion8', 'o5_opcion9'		
//		wf_normaliza_opcion1(5, ls_col, dw_2)
////--------------------------------------------------------		
//	CASE 'o6_titulo', 'o6_opcion1', 'o6_opcion2', 'o6_opcion3', 'o6_opcion4', 'o6_opcion5', 'o6_opcion6', 'o6_opcion7', 'o6_opcion8', 'o6_opcion9', 'o6_opcion10', 'o6_opcion11', 'o6_opcion12', 'o6_opcion13', 'o6_opcion14', 'o6_opcion15'
//		wf_normaliza_opcion1(6, ls_col, dw_2)
////--------------------------------------------------------		
//	CASE 'o7_titulo', 'o7_opcion1', 'o7_opcion2'
//		wf_normaliza_opcion1(7, ls_col, dw_2)
////--------------------------------------------------------		
//	CASE 'o8_titulo', 'o8_opcion1', 'o8_opcion2'
//		wf_normaliza_opcion1(8, ls_col, dw_2)
////--------------------------------------------------------		
//	case 'fondo1', 'imagen1'		
//		wf_normaliza_opcion1(1, ls_col, dw_2)		
//	case 'fondo2', 'imagen2'
//		wf_normaliza_opcion1(2, ls_col, dw_2)
//	case 'fondo3', 'imagen3'
//		wf_normaliza_opcion1(3, ls_col, dw_2)
//	case 'fondo4', 'imagen4'
//		wf_normaliza_opcion1(4, ls_col, dw_2)
//	case 'fondo5', 'imagen5'
//		wf_normaliza_opcion1(5, ls_col, dw_2)
//	case 'fondo6', 'imagen6'
//		wf_normaliza_opcion1(6, ls_col, dw_2)
//	case 'fondo7', 'imagen7'
//		wf_normaliza_opcion1(7, ls_col, dw_2)
//	case 'fondo8', 'imagen8'
//		wf_normaliza_opcion1(8, ls_col, dw_2)
//	CASE ELSE
//		wf_normaliza_opcion1(0, ls_col, dw_2)
//
//END CHOOSE
end event

event clicked;string ls_campo, ls_color
this.accepttext()
ls_campo = dwo.name

ls_color = dw_3.describe(ls_campo+'.color')
if ls_color <> '12171705' then 
	wf_abrir_ventana( ls_campo, w_fa_fondo)
end if
//dw_3.trigger event clicked(1,1,1,object)
end event

type dw_1 from datawindow within w_fa_fondo_old
boolean visible = false
integer x = 2537
integer y = 40
integer width = 2066
integer height = 256
integer taborder = 30
string title = "none"
string dataobject = "dw_empresa"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_fa_fondo_old
boolean visible = false
integer x = 1184
integer y = 2280
integer width = 3255
integer height = 148
integer taborder = 40
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Book Antiqua"
long textcolor = 33554432
string text = "SISTEMA INTEGRADO VERSION 1.00"
boolean border = false
boolean displayonly = true
end type

type gb_1 from groupbox within w_fa_fondo_old
boolean visible = false
integer x = 18
integer y = 28
integer width = 480
integer height = 376
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_3 from datawindow within w_fa_fondo_old
integer x = 18
integer width = 4960
integer height = 2396
integer taborder = 40
string title = "none"
string dataobject = "dw_external_opciones"
boolean border = false
boolean livescroll = true
end type

event clicked;string ls_ventana, ls_opcion, ls_color
this.accepttext()
parent.SetRedraw ( false )
ls_opcion = dwo.name

ls_color = dw_3.describe(ls_opcion+'.color')
if ls_color <> '12171705' then 
	wf_abrir_ventana( ls_opcion, w_fa_fondo)
end if
parent.SetRedraw ( True )
end event

