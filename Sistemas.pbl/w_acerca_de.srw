//objectcomments A cerca de HARR, S.A.
forward
global type w_acerca_de from window
end type
type cb_3 from commandbutton within w_acerca_de
end type
type st_5 from statictext within w_acerca_de
end type
type sle_1 from singlelineedit within w_acerca_de
end type
type st_2 from statictext within w_acerca_de
end type
type cb_2 from commandbutton within w_acerca_de
end type
type st_1 from statictext within w_acerca_de
end type
type cb_1 from commandbutton within w_acerca_de
end type
type gb_1 from groupbox within w_acerca_de
end type
type st_4 from statictext within w_acerca_de
end type
end forward

global type w_acerca_de from window
integer x = 832
integer y = 360
integer width = 2130
integer height = 1048
boolean titlebar = true
string title = "Acerca de HymSoft"
windowtype windowtype = response!
long backcolor = 79741120
event ue_dwnkey pbm_dwnkey
event ue_post_dwnkey ( )
event ue_postopen ( )
cb_3 cb_3
st_5 st_5
sle_1 sle_1
st_2 st_2
cb_2 cb_2
st_1 st_1
cb_1 cb_1
gb_1 gb_1
st_4 st_4
end type
global w_acerca_de w_acerca_de

type prototypes
Function long ShellExecuteA (ulong hwind, string lpOperation, string lpFile, string lpParameters, string lpDirectory, long nShowCmd) library "shell32.dll" alias for "ShellExecuteA;Ansi"

end prototypes

type variables
u_external_function uo_extern
String is_ruta
Boolean ib_exit, ib_aceptar
u_calculator iuo_calculator
Integer ii_bugs
end variables

forward prototypes
public subroutine wf_about_us ()
public subroutine wf_ba_ini ()
public subroutine wf_setear_nombres ()
end prototypes

event ue_dwnkey;This.TriggerEvent("ue_post_dwnKey")

end event

event ue_post_dwnkey();//If KeyDown(KeyControl!) And KeyDown(KeyH!) And KeyDown(KeyJ!) Then wf_ba_ini()

//If KeyDown(KeyShift!) And KeyDown(KeyM!) And KeyDown(KeyR!) Then wf_about_us()

end event

event ue_postopen;wf_setear_nombres()
end event

public subroutine wf_about_us ();//Long	  ll_oringinal_pos[31], ll_actual_pos[31]
//Integer li_i, li_column
//
//ib_exit = True
//
//li_column = Integer(dw_1.Describe("DataWindow.Column.Count"))
//
//For li_i = 1 To li_column
//	ll_oringinal_pos[li_i] = Long(dw_1.Describe("#"+String(li_i) +".y"))
//	ll_actual_pos[li_i] 	  = ll_oringinal_pos[li_i]
//Next
//
//Do While ll_actual_pos[li_column] >= -60 
//	For li_i = 1 To li_column
//		ll_actual_pos[li_i] -= 5
//		dw_1.Modify("#" + String(li_i) + ".y=" + String(ll_actual_pos[li_i]))
//	
//		If ll_actual_pos[li_i] <= -730 Then //-52
//			dw_1.Modify("#" + String(li_i) + ".y=" + String(ll_oringinal_pos[1]))
//			ll_actual_pos[li_i] 	  = ll_oringinal_pos[1]
//		End If	
//	Next	
//	yield()
//	If ib_aceptar Then Exit
//Loop
//
//ib_exit = False
//
//If ib_aceptar = True Then Close(This)
end subroutine

public subroutine wf_ba_ini ();//Long 	  ll_grupo_financiero, ll_empresa, ll_color1, ll_color2
//Integer li_sqlcode, li_i, li_annio, li_i_array, li_limite
//String  ls_aplicacion, ls_ventana, ls_descripcion
//Time	  lt_hasta
//
//li_limite = 5
//
//String  ls_transaccion[5], 	 &
//		  ls_sub_transaccion[5], &
//		  ls_movimiento[5], 		 &
//		  ls_nombre_transaccion[5]
//		  
//		  
//ls_transaccion[]			= {'CH','OP','DE','DB','CB'}
//ls_sub_transaccion[] 	= {'CH','OP','DE','DB','CB'}
//ls_movimiento[]			= {'C','C','D','C','D'}
//ls_nombre_transaccion[] = {'CHEQUES','ORDENES DE PAGO', 'DEPOSITOS', 'NOTA DE DEBITO BANCARIAS','NOTA DE CREDITO BANCARIAS'}
//		  		  
//
//li_annio = YEAR(Date(gf_fecha_serv()))
//
//
//SELECT dgacolor.colo_g_finanaciero,   
//		 dgacolor.colo_empresa  
//  INTO :ll_grupo_financiero,   
//		 :ll_empresa  
//  FROM dgacolor  
// WHERE dgacolor.colo_aplicacion = 'BA' Or
//		 dgacolor.colo_aplicacion = 'BR'   ;
//		 
//
//DECLARE Colores CURSOR FOR
// SELECT dgacolor.colo_aplicacion,
//		  dgacolor.ventana,
//		  dgacolor.descripcion,
//		  dgacolor.color1,
//		  dgacolor.color2
//   FROM dgacolor
//  WHERE ( dgacolor.colo_g_finanaciero = :ll_grupo_financiero ) AND
//		  ( dgacolor.colo_empresa = :ll_empresa )   ;
//		  
//Open Colores;
//
//DO WHILE li_sqlcode = 0
//	Fetch Colores Into :ls_aplicacion, :ls_ventana, :ls_descripcion, :ll_color1, :ll_color2;
//
//	li_sqlcode = sqlca.sqlcode
//	
//	If li_sqlcode <> 0 Then Exit
//	
//	   INSERT INTO dgacolor  
//						( colo_aplicacion,   
//						  colo_g_finanaciero,   
//						  colo_empresa,   
//						  ventana,   
//						  descripcion,   
//						  color1,   
//						  color2,   
//						  color3,   
//						  color4,   
//						  color5,   
//						  color6,   
//						  color7,   
//						  color8 )  
//			  VALUES ( :ls_aplicacion,
//						  :str.g_financiero,
//						  :str.empresa,
//						  :ls_ventana,
//						  :ls_descripcion,
//						  :ll_color1,
//						  :ll_color2,
//						  null,
//						  null,
//						  null,
//						  null,
//						  null,
//						  null )  ;
//
//LOOP
//CLOSE Colores;
//COMMIT USING SQLCA;
//
//
//FOR li_i_array = 1 To li_limite
//	//*****************************
//	//**  DGMSERIE TRANSACCIONES **
//	//*****************************
//	INSERT INTO dgmserie  
//			( mser_g_financiero,   
//			  mser_empresa,   
//			  mser_tipo_transaccion,   
//			  mser_descripcion,   
//			  mser_movimiento,   
//			  mser_secuencia,
//			  mser_sec_auto,   
//			  mser_imprime_doc,
//			  mser_periodicidad,   
//			  mser_proxima_act,   
//			  mser_tiene_cargo,
//			  mser_anno )  
//	VALUES ( :str.g_financiero,
//				:str.empresa,
//				:ls_transaccion[li_i_array],
//				:ls_nombre_transaccion[li_i_array],
//				:ls_movimiento[li_i_array],
//				0,
//				'S',
//				'S',
//				null,
//				null,
//				null,
//				:li_annio)  ;
//	COMMIT USING SQLCA;
//NEXT
//
//
//
//FOR li_i_array = 1 To li_limite
//	//********************************
//	//**  DGMSUBSE SUBTRANSACCIONES **
//	//********************************
//	INSERT INTO dgmsubse  
//			( subs_g_financiero,   
//			  subs_empresa,   
//			  subs_transaccion,   
//			  subs_sub_trans,   
//			  subs_descripcion )  
//	VALUES ( :str.g_financiero,   
//				:str.empresa,   
//			   :ls_transaccion[li_i_array],   
//			   :ls_sub_transaccion[li_i_array],   
//			   :ls_nombre_transaccion[li_i_array] )  ;
//	COMMIT USING SQLCA;
//NEXT
//
//
//FOR li_i_array = 1 To li_limite
//	//*********************************************************
//	//**  DGMSERDR ACCESO POR APLICACION DE SUBTRANSACCIONES **
//	//*********************************************************
//	INSERT INTO dgmserdr  
//			( serd_g_financiero,   
//			  serd_empresa,   
//			  serd_transaccion,   
//			  serd_sub_trans,   
//			  serd_aplicacion,   
//			  serd_mgcuenta )  
//	VALUES ( :str.g_financiero,   
//				:str.empresa,   
//			   :ls_transaccion[li_i_array],
//			   :ls_sub_transaccion[li_i_array],   
//			  'BA',   
//			  null )  ;
//	COMMIT USING SQLCA;
//NEXT
//
//
//
//ll_color1 = st_web.textcolor
//lt_hasta = RelativeTime(now(), 5)
//
//Do While lt_hasta >= now()
//	If li_i <> Second(now()) Then 
//		st_web.textcolor = RGB(Rand(255), Rand(255), Rand(255))
//		li_i = Second(now())
//	End If
//Loop
//	
//st_web.textcolor = ll_color1
end subroutine

public subroutine wf_setear_nombres ();
end subroutine

on w_acerca_de.create
this.cb_3=create cb_3
this.st_5=create st_5
this.sle_1=create sle_1
this.st_2=create st_2
this.cb_2=create cb_2
this.st_1=create st_1
this.cb_1=create cb_1
this.gb_1=create gb_1
this.st_4=create st_4
this.Control[]={this.cb_3,&
this.st_5,&
this.sle_1,&
this.st_2,&
this.cb_2,&
this.st_1,&
this.cb_1,&
this.gb_1,&
this.st_4}
end on

on w_acerca_de.destroy
destroy(this.cb_3)
destroy(this.st_5)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.st_4)
end on

event open;//String ls_rurabmp, ls_aplicacion
//
//timer(.2)
//
gf_center_win(this)
//
//f_create_external_func_uo(uo_extern)
//
sle_1.text = gf_dg_nombre_empresa()
//
//
//  SELECT dgmaplica.apli_descripcion  
//    INTO :ls_aplicacion
//    FROM dgmaplica  
//   WHERE dgmaplica.apli_aplicacion = :str.aplicacion  ;
//
//
//st_3.Text = "HARR2000®  Sistema de " + ls_aplicacion
//
//
//is_ruta = str.path
//gf_find_path(is_ruta)
//
//is_ruta += "art\sonidos\"
//
//ls_rurabmp = str.path + "art\"
//
//
////p_1.PictureName = ls_rurabmp + "fondo_acercade.bmp"
////p_3.PictureName = ls_rurabmp + "economia.bmp"
//
//uo_extern.uf_playsound(is_ruta + "Factura.wav", 3)
//
this.postevent("ue_postopen")
end event

event closequery;//uo_extern.uf_playsound(is_ruta + "latigo.wav", 3)

destroy uo_extern
end event

event key;This.TriggerEvent("ue_dwnKey")

end event

event close;Close(This)
end event

event timer;//ii_bugs++
//
//If ii_bugs <= 5 Then
//	p_1.picturename = str.path + 'Art\Bugs' + String(ii_bugs) + '.bmp'
//Else
//	ii_bugs = 1
//	p_1.picturename = str.path + 'Art\Bugs' + String(ii_bugs) + '.bmp'	
//End If
//
end event

type cb_3 from commandbutton within w_acerca_de
integer x = 1614
integer y = 580
integer width = 480
integer height = 72
integer taborder = 20
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Change Account"
end type

event clicked;OpenSheet(w_cambio_de_cuenta_y_fecha,str.frame ,2, Original!)
end event

type st_5 from statictext within w_acerca_de
string tag = "1.00"
integer x = 37
integer y = 196
integer width = 599
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421504
long backcolor = 67108864
boolean enabled = false
string text = "Versión 1.00"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_acerca_de
integer x = 27
integer y = 376
integer width = 1166
integer height = 252
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type st_2 from statictext within w_acerca_de
integer x = 32
integer y = 304
integer width = 850
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Se autoriza el uso de este producto a:"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_acerca_de
boolean visible = false
integer x = 1504
integer y = 1148
integer width = 571
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Inf. de Sistema..."
end type

event clicked;String ls_regedit


RegistryGet( "HKEY_LOCAL_MACHINE\Software\Microsoft\Shared Tools\MSInfo", "Path",ls_regedit)

If Len(Trim(ls_regedit)) > 0 Then
	Run(ls_regedit)
Else
	This.Enabled = false
End If
end event

type st_1 from statictext within w_acerca_de
integer x = 32
integer y = 724
integer width = 2048
integer height = 188
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Este Programa está protegido por las Leyes de derecho de autor y otros tratados internacionales.  La reproducción o distribución ilicita de este programa, o de cualquier parte del mismo, está por la ley con severas sanciones civiles y penales, y sera objeto de todas las acciones juridicas que corespondan"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_acerca_de
integer x = 1435
integer y = 272
integer width = 462
integer height = 160
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Salir"
boolean default = true
end type

event clicked;ib_aceptar = True

If ib_exit = False Then Parent.PostEvent(Close!)
end event

type gb_1 from groupbox within w_acerca_de
integer x = 23
integer y = 644
integer width = 2066
integer height = 56
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type st_4 from statictext within w_acerca_de
integer x = 27
integer y = 16
integer width = 1161
integer height = 152
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 67108864
boolean enabled = false
string text = "Copyright© 2008 Soluciones Estrategicas. Todos los Derechos Reservados"
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

