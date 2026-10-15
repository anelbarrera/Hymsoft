//objectcomments Ventana del Estado de Cuenta por rangos (Fecha,Clientes,Empresas o Grupos Financieros)
forward
global type w_estadocuenta from w_cc_padre_rango_fecha
end type
type gb_5 from groupbox within w_estadocuenta
end type
type dw_2 from datawindow within w_estadocuenta
end type
type dw_3 from datawindow within w_estadocuenta
end type
type gb_2 from groupbox within w_estadocuenta
end type
type st_desde from statictext within w_estadocuenta
end type
type st_hasta from statictext within w_estadocuenta
end type
type em_3 from editmask within w_estadocuenta
end type
type st_4 from statictext within w_estadocuenta
end type
type em_4 from editmask within w_estadocuenta
end type
type rb_1 from radiobutton within w_estadocuenta
end type
type rb_2 from radiobutton within w_estadocuenta
end type
type rb_3 from radiobutton within w_estadocuenta
end type
type rb_4 from radiobutton within w_estadocuenta
end type
type rb_5 from radiobutton within w_estadocuenta
end type
type pb_3 from picturebutton within w_estadocuenta
end type
type pb_4 from picturebutton within w_estadocuenta
end type
type rb_6 from radiobutton within w_estadocuenta
end type
type rb_7 from radiobutton within w_estadocuenta
end type
type rb_8 from radiobutton within w_estadocuenta
end type
type rb_9 from radiobutton within w_estadocuenta
end type
type dw_4 from datawindow within w_estadocuenta
end type
type rb_10 from radiobutton within w_estadocuenta
end type
type sle_1 from singlelineedit within w_estadocuenta
end type
type st_5 from statictext within w_estadocuenta
end type
type rb_11 from radiobutton within w_estadocuenta
end type
type dw_5 from datawindow within w_estadocuenta
end type
type rb_12 from radiobutton within w_estadocuenta
end type
type dw_6 from datawindow within w_estadocuenta
end type
type rb_30 from radiobutton within w_estadocuenta
end type
type rb_60 from radiobutton within w_estadocuenta
end type
type rb_90 from radiobutton within w_estadocuenta
end type
type rb_120 from radiobutton within w_estadocuenta
end type
type rb_total from radiobutton within w_estadocuenta
end type
type calendario from picture within w_estadocuenta
end type
type calendario2 from picture within w_estadocuenta
end type
type uo_1 from u_ddcalen within w_estadocuenta
end type
type uo_2 from u_ddcalen within w_estadocuenta
end type
type rb_2ann from radiobutton within w_estadocuenta
end type
type rb_1ann from radiobutton within w_estadocuenta
end type
type hpb_1 from hprogressbar within w_estadocuenta
end type
type gb_3 from groupbox within w_estadocuenta
end type
type gb_4 from groupbox within w_estadocuenta
end type
type gb_6 from groupbox within w_estadocuenta
end type
end forward

global type w_estadocuenta from w_cc_padre_rango_fecha
integer x = 864
integer y = 260
integer width = 2482
integer height = 1280
string title = "Emision de Estados de Cuentas"
windowtype windowtype = popup!
long backcolor = 12639424
string icon = "AppIcon!"
windowanimationstyle openanimation = rightslide!
windowanimationstyle closeanimation = rightslide!
gb_5 gb_5
dw_2 dw_2
dw_3 dw_3
gb_2 gb_2
st_desde st_desde
st_hasta st_hasta
em_3 em_3
st_4 st_4
em_4 em_4
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
rb_4 rb_4
rb_5 rb_5
pb_3 pb_3
pb_4 pb_4
rb_6 rb_6
rb_7 rb_7
rb_8 rb_8
rb_9 rb_9
dw_4 dw_4
rb_10 rb_10
sle_1 sle_1
st_5 st_5
rb_11 rb_11
dw_5 dw_5
rb_12 rb_12
dw_6 dw_6
rb_30 rb_30
rb_60 rb_60
rb_90 rb_90
rb_120 rb_120
rb_total rb_total
calendario calendario
calendario2 calendario2
uo_1 uo_1
uo_2 uo_2
rb_2ann rb_2ann
rb_1ann rb_1ann
hpb_1 hpb_1
gb_3 gb_3
gb_4 gb_4
gb_6 gb_6
end type
global w_estadocuenta w_estadocuenta

type variables
DatawindowChild idch_notercero,idch_tipclien, idch_notercero1
DatawindowChild idch_desdecliente,  idch_hastacliente,idch_tipsocio, idch_tipauditor

string    	is_data, ls_codigo, is_busqueda,&
            is_tip_busca, is_id_cta, is_sec_auto, is_clie_ter,&
            is_ruc_, is_refe_,is_fecha_est, is_piepagina,&
            is_tipocli, is_descripcion, is_que_mensaje = 'P',&
				is_mens_aldia, is_mostrar_mora, is_tipo_antig,is_preimpreso='N', is_user

long li_cliente, il_lter

str_rangofecha   lstr_rangfech, istr_rangfech
str_cc_formatos  istr_formato

boolean   ib_edito_ruc


end variables

forward prototypes
public subroutine wf_actualiza_antiguedad (string idioma)
public subroutine wf_setear_user (string as_user)
end prototypes

public subroutine wf_actualiza_antiguedad (string idioma);Integer  li_registros, li_i, li_empresa, li_grupofin, li_emp, li_dberror, &
         li_tipo, li_socio, li_audit
decimal  ld_x, ld_y, ld_monto
string   ls_db_err,ls_where_select, ls_error
long 		ll_tercero
Datetime ld_tiempo1, ld_tiempo2
Datastore lds_cliente, lds_tercero_empresa, lds_tercero_gf, lds_tercero_pais

DELETE FROM ccatempa
WHERE ( ccatempa.tmpa_g_financiero 	= :str.g_financiero 	) AND  
      ( ccatempa.tmpa_empresa 		= :str.empresa 		) and
		( ccatempa.tmpa_usuario_maquina = :str.maquina 		) ;
if sqlca.sqlcode = -1 then
	messagebox('error','error al elimianr registros desde ccatempa')
end if

DELETE FROM cchestado  
WHERE ( cchestado.est_g_financiero =:str.g_financiero  ) AND  
		( cchestado.est_empresa =:str.empresa  ) AND  
		( cchestado.est_usuario_maquina =:str.maquina  )   ;
if sqlca.sqlcode = -1 then
	mensaje('Error','Error eliminando de cchestado','')
end if

//datastore	lds_tercero_empresa, lds_tercero_gf,lds_cliente, lds_tercero_pais
Datawindowchild ldwc_sub_tran, ldwc_pais, ldwc_region

lds_cliente 			= create ds_dg_import_file
lds_tercero_empresa 	= create ds_dg_import_file
lds_tercero_gf 		= create ds_dg_import_file
lds_tercero_pais	 	= create ds_dg_import_file


//** Datawindows para cargar los clientes, empresas y grupos financierosa
if dw_3.getitemstring(1,'op_estado') = 'P' then
	if rb_3.checked = true then
		lds_cliente.dataobject = 'dw_cc_inf_terceros_rango_1_nom'
	elseif rb_4.checked = true then//Si la busqueda en por código de cliente(clie_ref_anterior)
		lds_cliente.dataobject = 'dw_cc_inf_terceros_rango_1_ref'
	elseif rb_5.checked = true then
		lds_cliente.dataobject = 'dw_cc_inf_terceros_rango_1_ruc'
	else
		lds_cliente.dataobject = 'dw_cc_inf_terceros_rango_1'
	end if
end if
//****************

lds_tercero_empresa.dataobject 	= 'dw_cc_inf_terceros_x_empresa_new'
lds_tercero_gf.dataobject 			= 'dw_cc_inf_terceros_x_gfin'
lds_tercero_pais.dataobject		= 'dw_cc_inf_terceros_x_pais2'

lds_tercero_empresa.settransobject(sqlca)
lds_tercero_gf.settransobject(sqlca)
lds_cliente.settransobject(sqlca)
lds_tercero_pais.settransobject(sqlca)

istr_rangfech =  lstr_rangfech
ld_tiempo1 = Datetime(istr_rangfech.fecha1,00:00:00)
ld_tiempo2 = Datetime(istr_rangfech.fecha2,00:00:00)

//lstr_rangfech.tip_cliente = il_tip_cliente

CHOOSE CASE istr_rangfech.opcion
	CASE 'P' //Por Cliente 
			
		//**filtra el dw por tipo de cliente
		if lstr_rangfech.tip_cliente = 'P' then
			if not isnull(istr_rangfech.tipo_cliesp) then li_tipo = 1
			if not isnull(istr_rangfech.tipo_socio)  then li_socio = 1
			if not isnull(istr_rangfech.tipo_auditor) then li_audit = 1
		
			if li_tipo = 1 then
				lds_cliente.setfilter("ccmclien_clie_clasificacion="+string(lstr_rangfech.tipo_cliesp))
				lds_cliente.filter()
			elseif li_socio = 1 then
				lds_cliente.setfilter("clie_socio="+string(lstr_rangfech.tipo_socio))
				lds_cliente.filter()
			elseif li_audit = 1 then
				lds_cliente.setfilter("clie_auditor="+string(lstr_rangfech.tipo_auditor))
				lds_cliente.filter()
			end if
						
		elseif lstr_rangfech.tip_cliente = 'T' then
			lds_cliente.Setfilter('')
			lds_cliente.filter()
		end if
      //***
		if rb_3.checked =  true then
			lds_cliente.retrieve(str.g_financiero,str.empresa,istr_rangfech.nombre1,istr_rangfech.nombre2)
			li_registros = lds_cliente.rowcount()
			
			ls_where_select="( rtrim(terc_descripcion) + convert(char(5),dgmterce.terc_tercero) between '"+lstr_rangfech.nombre1+"' and '"+lstr_rangfech.nombre2+"' )"
		elseif rb_4.checked = true then//***10/04/2000 Yira (por código de cliente clie_ref_anterior)
			lds_cliente.retrieve(str.g_financiero,str.empresa,istr_rangfech.desdeclienteref,istr_rangfech.hastaclienteref)
			li_registros = lds_cliente.rowcount()
			ls_where_select="( clie_ref_anterior between '"+lstr_rangfech.desdeclienteref+"' and '"+lstr_rangfech.hastaclienteref+"' )"	
		elseif rb_5.checked = true then
			lds_cliente.retrieve(str.g_financiero,str.empresa,istr_rangfech.ruccli1,istr_rangfech.ruccli2)
			li_registros = lds_cliente.rowcount()
			ls_where_select="( clie_ruc_tercero between '"+lstr_rangfech.ruccli1+"' and '"+lstr_rangfech.ruccli2+"' )"	
     	else
			lds_cliente.retrieve(str.g_financiero,str.empresa,istr_rangfech.desdecliente,istr_rangfech.hastacliente)
			li_registros = lds_cliente.rowcount()
			//ls_where_select="( dgmterce.terc_tercero between '"+lstr_rangfech.desdecliente+"' and '"+lstr_rangfech.hastacliente+"' )"	
		end if
		
		hpb_1.setrange(0,li_registros)
		hpb_1.setstep = 1
		hpb_1.visible = true
		
	//	hpb_1.setpos(0)
		for li_i = 1 to li_registros 
			//ole_1.object.value 	= (li_i/lds_cliente.rowcount()) * 100
					hpb_1.stepit()
			ll_tercero 				= lds_cliente.getitemnumber(li_i,"ccmclien_clie_tercero")
			if is_tipo_antig = 'N' then//Normal contra saldo
				
				gf_antiguedad_x_cliente(ld_tiempo2, ll_tercero,idioma,ld_tiempo1)
				istr_rangfech.tipo_antig = 'N'
			elseif is_tipo_antig = 'S' then//Historial con antigüedad pendiente
				istr_rangfech.tipo_antig = 'S'
				 //Llena la tabla CCHESTADO
				 DELETE FROM cchestado  
				WHERE ( cchestado.est_g_financiero =:str.g_financiero  ) AND  
						( cchestado.est_empresa =:str.empresa  ) AND  
						( cchestado.est_usuario_maquina =:str.maquina  )   ;
				if sqlca.sqlcode = -1 then
					mensaje('Error','Error eliminando de cchestado','')
				end if
				string  Sqlstatement,my_cursor
			
				Sqlstatement = "SELECT distinct terc_tercero "+ &
									 "FROM dgmterce,ccmclien "+ &
									 "WHERE ( ccmclien.clie_tercero = dgmterce.terc_tercero ) and "+ &
									 "( ccmclien.clie_mg_cuenta <> null ) and "+ &
									 "( ccmclien.clie_mg_cuenta <> '' ) and "+ &
									 ls_where_select
				
				//lstr_rangfech.fecha1 = date(em_1.text)
//mensaje('',Sqlstatement,'')

				PREPARE SQLSA FROM :Sqlstatement ;
				DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;
				
				OPEN DYNAMIC my_cursor;
				FETCH my_cursor  into :ll_tercero;	
				
				do while sqlca.sqlcode = 0

//				DECLARE sp_cc_recibos_factura procedure for sp_cc_recibos_factura
//					@gf      = :str.g_financiero, 
//					@emp     = :str.empresa,
//					@cliente = :ll_tercero,
//					@cliente1 =:ll_tercero,
//					@fecha   = :ld_tiempo2,
//					@usuario_maquina =:str.maquina;
//				EXECUTE sp_cc_recibos_factura ;

				if sqlca.sqlcode = -1 then
					ls_error=sqlca.sqlErrText
					rollback;
					messagebox("Error!!!!","Error en el Procedimiento sp_cc_recibos_factura_debito: "+"~r~n"+ls_error)
					return
				end if
				
				FETCH my_cursor  into :ll_tercero;	
				loop
				close my_cursor;
    
		      //lstr_rangfech.opcion = dw_3.getitemstring(dw_3.getrow(),'op_estado')

			 gf_antiguedad_x_cliente_docv1(ld_tiempo2,ll_tercero,idioma,ld_tiempo1)//pendiente
			else
				istr_rangfech.tipo_antig = 'N'
			end if		
		next
		//ole_1.visible = false


CASE 'R'	//General Paises

		//**	Se extrae los clientes en el rango de grupos financieros seleccionados
		lds_tercero_pais.retrieve(istr_rangfech.desdecliente,istr_rangfech.hastacliente, str.g_financiero, str.empresa)
		li_registros = lds_tercero_pais.rowcount()
		hpb_1.setrange(1,li_registros)
		hpb_1.setstep = 1
		hpb_1.visible = true
		for li_i = 1 to li_registros 
			yield()
			hpb_1.stepit()
			str.frame.setmicrohelp('Procesando el Cliente '+string(li_i)+ ' de '+string(li_registros) )
			//ole_1.object.value 	= (li_i/lds_tercero_pais.rowcount())*100
			ll_tercero 				= lds_tercero_pais.getitemnumber(li_i, "ccmclien_clie_tercero")
			li_grupofin 			= lds_tercero_pais.getitemnumber(li_i, "ccmclien_clie_g_financiero")
			li_empresa 				= lds_tercero_pais.getitemnumber(li_i, "ccmclien_clie_empresa")
			gf_antiguedad_x_cliente_rango(ld_tiempo2,li_grupofin,li_empresa, ll_tercero, idioma,ld_tiempo1)
			commit using sqlca;
		next
		str.frame.setmicrohelp('Hymsoft')
		//ole_1.visible = false


END CHOOSE

//ole_1.visible = false

IF ISVALID(lds_cliente)  THEN
	DESTROY lds_cliente
END IF
IF ISVALID(lds_tercero_empresa)  THEN
	DESTROY lds_tercero_empresa
END IF
IF ISVALID(lds_tercero_gf)  THEN
	DESTROY lds_tercero_gf
END IF
IF ISVALID(lds_tercero_pais)  THEN
	DESTROY lds_tercero_pais
END IF	
commit using sqlca;
return;
end subroutine

public subroutine wf_setear_user (string as_user);//Asigno el Usuario a la Variable de Instancia
is_user = as_user
end subroutine

on w_estadocuenta.create
int iCurrent
call super::create
this.gb_5=create gb_5
this.dw_2=create dw_2
this.dw_3=create dw_3
this.gb_2=create gb_2
this.st_desde=create st_desde
this.st_hasta=create st_hasta
this.em_3=create em_3
this.st_4=create st_4
this.em_4=create em_4
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.rb_4=create rb_4
this.rb_5=create rb_5
this.pb_3=create pb_3
this.pb_4=create pb_4
this.rb_6=create rb_6
this.rb_7=create rb_7
this.rb_8=create rb_8
this.rb_9=create rb_9
this.dw_4=create dw_4
this.rb_10=create rb_10
this.sle_1=create sle_1
this.st_5=create st_5
this.rb_11=create rb_11
this.dw_5=create dw_5
this.rb_12=create rb_12
this.dw_6=create dw_6
this.rb_30=create rb_30
this.rb_60=create rb_60
this.rb_90=create rb_90
this.rb_120=create rb_120
this.rb_total=create rb_total
this.calendario=create calendario
this.calendario2=create calendario2
this.uo_1=create uo_1
this.uo_2=create uo_2
this.rb_2ann=create rb_2ann
this.rb_1ann=create rb_1ann
this.hpb_1=create hpb_1
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_6=create gb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_5
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.st_desde
this.Control[iCurrent+6]=this.st_hasta
this.Control[iCurrent+7]=this.em_3
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.em_4
this.Control[iCurrent+10]=this.rb_1
this.Control[iCurrent+11]=this.rb_2
this.Control[iCurrent+12]=this.rb_3
this.Control[iCurrent+13]=this.rb_4
this.Control[iCurrent+14]=this.rb_5
this.Control[iCurrent+15]=this.pb_3
this.Control[iCurrent+16]=this.pb_4
this.Control[iCurrent+17]=this.rb_6
this.Control[iCurrent+18]=this.rb_7
this.Control[iCurrent+19]=this.rb_8
this.Control[iCurrent+20]=this.rb_9
this.Control[iCurrent+21]=this.dw_4
this.Control[iCurrent+22]=this.rb_10
this.Control[iCurrent+23]=this.sle_1
this.Control[iCurrent+24]=this.st_5
this.Control[iCurrent+25]=this.rb_11
this.Control[iCurrent+26]=this.dw_5
this.Control[iCurrent+27]=this.rb_12
this.Control[iCurrent+28]=this.dw_6
this.Control[iCurrent+29]=this.rb_30
this.Control[iCurrent+30]=this.rb_60
this.Control[iCurrent+31]=this.rb_90
this.Control[iCurrent+32]=this.rb_120
this.Control[iCurrent+33]=this.rb_total
this.Control[iCurrent+34]=this.calendario
this.Control[iCurrent+35]=this.calendario2
this.Control[iCurrent+36]=this.uo_1
this.Control[iCurrent+37]=this.uo_2
this.Control[iCurrent+38]=this.rb_2ann
this.Control[iCurrent+39]=this.rb_1ann
this.Control[iCurrent+40]=this.hpb_1
this.Control[iCurrent+41]=this.gb_3
this.Control[iCurrent+42]=this.gb_4
this.Control[iCurrent+43]=this.gb_6
end on

on w_estadocuenta.destroy
call super::destroy
destroy(this.gb_5)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.gb_2)
destroy(this.st_desde)
destroy(this.st_hasta)
destroy(this.em_3)
destroy(this.st_4)
destroy(this.em_4)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.pb_3)
destroy(this.pb_4)
destroy(this.rb_6)
destroy(this.rb_7)
destroy(this.rb_8)
destroy(this.rb_9)
destroy(this.dw_4)
destroy(this.rb_10)
destroy(this.sle_1)
destroy(this.st_5)
destroy(this.rb_11)
destroy(this.dw_5)
destroy(this.rb_12)
destroy(this.dw_6)
destroy(this.rb_30)
destroy(this.rb_60)
destroy(this.rb_90)
destroy(this.rb_120)
destroy(this.rb_total)
destroy(this.calendario)
destroy(this.calendario2)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.rb_2ann)
destroy(this.rb_1ann)
destroy(this.hpb_1)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_6)
end on

event open;call super::open;long    ll_recupero
string  ls_error

sqlca.autocommit = true

istr_formato = Message.PowerObjectParm

lstr_rangfech.tipo_bd = istr_formato.tipo_bd

//messagebox('istr_formato.tipo_bd',istr_formato.tipo_bd)
SELECT isnull(ccmparam.para_tipo_busqueda,'S'),
       isnull(ccmparam.para_fecha_estado_cuenta,'2'),
		 isnull(ccmparam.para_piepag_estado_cuenta,'2'),
		 isnull(ccmparam.para_tipocli_estado_cuenta,'N'),
		 ccmparam.para_tipo_busqueda,
		 isnull(ccmparam.para_mensaje_ecuenta,'P'),
		 isnull(ccmparam.para_mens_aldia,''),
		 isnull(ccmparam.para_mostrar_mora,'N'),
		 isnull(ccmparam.para_tipo_antig_en_ecuenta,'N'),
		 isnull(ccmparam.para_estcuen_preimpreso,'N')
  INTO :is_tip_busca,
       :is_fecha_est,
		 :is_piepagina,
		 :is_tipocli,
		 :is_busqueda,
		 :is_que_mensaje,
		 :is_mens_aldia,
		 :is_mostrar_mora,
		 :is_tipo_antig,:is_preimpreso
  FROM ccmparam  
  WHERE ( ccmparam.para_g_financiero = :str.g_financiero ) AND  
        ( ccmparam.para_empresa      = :str.empresa )   ;
if sqlca.sqldbcode = -1 then
	ls_error = sqlca.sqlerrtext
	Rollback;
	mensaje("Error","Ha ocurrido un error al recuperar el tipo de búsqueda",ls_error)

end if

if is_preimpreso = 'S' then rb_10.checked = true
sle_1.text = is_mens_aldia

dw_2.Dataobject = 'dw_cc_rango_cliente_nombre'

//--Refresca los dropdown de los tipo de cliente--------------
dw_4.GetChild("tipo_cliente",idch_tipclien)
idch_tipclien.SetTransObject(Sqlca)
idch_tipclien.Retrieve(str.g_financiero,str.empresa)
If idch_tipclien.rowcount() < 1 then
	idch_tipclien.InsertRow(0)
End If

dw_5.GetChild("tipo_socio",idch_tipsocio)
idch_tipsocio.SetTransObject(Sqlca)
idch_tipsocio.Retrieve(str.g_financiero,str.empresa)
If idch_tipsocio.rowcount() < 1 then
	idch_tipsocio.InsertRow(0)
End If

dw_6.GetChild("tipo_auditor",idch_tipauditor)
idch_tipauditor.SetTransObject(Sqlca)
idch_tipauditor.Retrieve(str.g_financiero,str.empresa)
If idch_tipauditor.rowcount() < 1 then
	idch_tipauditor.InsertRow(0)
End If

//--Datawindows externos por tipo
dw_4.settransobject(Sqlca)
dw_4.Insertrow(0)
dw_4.enabled = false

dw_5.settransobject(Sqlca)
dw_5.Insertrow(0)
dw_5.enabled = false

dw_6.settransobject(Sqlca)
dw_6.Insertrow(0)
dw_6.enabled = false

dw_2.Accepttext()
dw_3.insertRow(1)//Datawindow externo de opciones


if dw_3.getitemstring(1,'op_estado') = 'P' then
	pb_3.enabled = true
	pb_4.enabled = true
else
	pb_3.enabled = false
	pb_4.enabled = false
end if

is_data = 'P'

dw_3.PostEvent("clicked")
rb_1.PostEvent("clicked")

dw_2.ScrollToRow(dw_2.InsertRow(0))//DropDow de Clientes
em_3.SetFocus()

//**Cambiar ventana por parametro de mensaje**

this.y = 0
this.x = 805
end event

event ue_vistaprevia;idch_notercero.accepttext()
//terc_tercero
integer li_null
long   ll_i, ll_cliente,ll_flag, ll_ter1, ll_ter2
string ls_ruc_cliente, ls_estado_cuenta, ls_cliente, ls_cliente2,ls_error, ls_cuenta, ls_cuenta2
datawindowchild ldch_notercero, ldch_notercero1
setnull(li_null)

ls_cuenta   = em_3.text
ls_cuenta2 = em_4.text
//Si es gold america
//Elimina las tablas temporales 
  DELETE FROM ccatpan  
   WHERE ( ccatpan.tpan_g_financiero = :str.g_financiero ) AND  
         ( ccatpan.tpan_empresa = :str.empresa ) AND  
         ( ccatpan.tpan_maquina = :str.maquina )   ;
if sqlca.sqlcode = -1 then
	ls_error = sqlca.sqlerrtext
	rollback;
	mensaje('Aviso','Error al eliminar ccatpan',ls_error)
	return
end if
	
DELETE FROM ccatempa
WHERE ( ccatempa.tmpa_g_financiero 	= :str.g_financiero 	) AND  
      ( ccatempa.tmpa_empresa 		= :str.empresa 		) and
		( ccatempa.tmpa_usuario_maquina = :str.maquina 		) ;
if sqlca.sqlcode = -1 then
	messagebox('error','error al elimianr registros desde ccatempa')
end if

  DELETE FROM ccatemaf
   WHERE ( tmaf_g_financiero = :str.g_financiero ) AND  
         ( tmaf_empresa = :str.empresa ) AND  
         ( tmaf_usuario_maquina = :str.maquina )   ;
if sqlca.sqlcode = -1 then
	ls_error = sqlca.sqlerrtext
	rollback;
	mensaje('Aviso','Error al eliminar ccatemaf',ls_error)
	return
end if

DELETE FROM cchestado  
WHERE ( cchestado.est_g_financiero =:str.g_financiero  ) AND  
		( cchestado.est_empresa =:str.empresa  ) AND  
		( cchestado.est_usuario_maquina =:str.maquina  )   ;
if sqlca.sqlcode = -1 then
	mensaje('Error','Error eliminando de cchestado','')
end if


CHOOSE CASE is_data
 CASE 'P'//de un cliente
	ls_cliente  = dw_2.GetItemstring(dw_2.Getrow(),"desdecliente")
	ls_cliente2 = dw_2.GetItemstring(dw_2.Getrow(),"hastacliente")
//   if rb_3.checked = true then
	 lstr_rangfech.tipo_orden = 'A'//alfabetico
//	 ll_ter1 = dw_2.GetItemnumber(1,"desdecliente")
//	 ll_ter2= dw_2.GetItemnumber(1,"hastacliente")
	 
    SELECT dgmterce.terc_tercero
	 INTO :ll_ter1
    FROM dgmterce,   
         ccmclien  
    WHERE ( ccmclien.clie_tercero       = dgmterce.terc_tercero ) and  
          ( ( ccmclien.clie_ref_anterior = :ls_cuenta ) AND  
          ( ccmclien.clie_empresa 		 = :str.empresa ) AND  
          ( ccmclien.clie_g_financiero  = :str.g_financiero ) )   ;
	if sqlca.sqldbcode = -1 then
		ls_error = sqlca.sqlerrtext
		mensaje("Error","Ha ocurrido un error al recuperar el tercero",ls_error)
	end if
	
   SELECT dgmterce.terc_tercero
   INTO   :ll_ter2
   FROM dgmterce,   
         ccmclien  
   WHERE ( ccmclien.clie_tercero         = dgmterce.terc_tercero ) and  
         ( ( ccmclien.clie_ref_anterior   = :ls_cuenta2 ) AND  
         ( ccmclien.clie_empresa 		  = :str.empresa ) AND  
         ( ccmclien.clie_g_financiero 	  = :str.g_financiero ) )   ;
	if sqlca.sqldbcode = -1 then
		ls_error = sqlca.sqlerrtext
		mensaje("Error","Ha ocurrido un error al recuperar el tercero",ls_error)
	end if

	case 'R'	//POR PAIS
		
Case else
////		mensaje('informacion', dw_2.dataobject, '')
////		ll_ter1 = dw_2.GetItemnumber(1,"desdecliente")
////		ll_ter2= dw_2.GetItemnumber(1,"hastacliente")
//		
End choose


lstr_rangfech.desdecliente = ll_ter1
lstr_rangfech.hastacliente = ll_ter2

if rb_2.checked = true then
	lstr_rangfech.tipo_accion = '2'
end if

If rb_1.checked = True then
	lstr_rangfech.tipo_accion = '1'
End If

//---------------------------------Mensaje utilizado-----------------------------

lstr_rangfech.mensaje = is_que_mensaje 
if is_que_mensaje = 'C' then
	lstr_rangfech.texto_mensaje = sle_1.text
end if
//--------------------------------------Idioma-----------------------------------
If rb_6.checked = true or rb_10.checked then
	lstr_rangfech.idioma = 'E'
Elseif rb_7.checked = true then
	lstr_rangfech.idioma = 'I'
End If
//---------------------------------Tipo de Cliente-------------------------------
If rb_8.checked = true then
	lstr_rangfech.tip_cliente = 'T'//todos
Elseif rb_9.checked = true then
	lstr_rangfech.tip_cliente = 'P'//por tipo
	lstr_rangfech.tipo_cliesp = dw_4.getitemnumber(1,'tipo_cliente')
	lstr_rangfech.tipo_socio  = li_null
	lstr_rangfech.tipo_auditor = li_null
//---------------------------------Tipo de Socio-------------------------------
elseIf rb_11.checked = true then
	lstr_rangfech.tip_cliente = 'P'//por tipo
	lstr_rangfech.tipo_socio = dw_5.getitemnumber(1,'tipo_socio')
	lstr_rangfech.tipo_cliesp  = li_null
	lstr_rangfech.tipo_auditor = li_null
Elseif rb_12.checked = true then
	lstr_rangfech.tip_cliente = 'P'//por tipo
	lstr_rangfech.tipo_auditor = dw_6.getitemnumber(1,'tipo_auditor')
	lstr_rangfech.tipo_socio  = li_null
	lstr_rangfech.tipo_cliesp = li_null
end if

//--------------------------Formato de Estado de cuenta----------------------------
If rb_10.checked = true then
	lstr_rangfech.preimpreso = 'S'//preimpresos
Else
	lstr_rangfech.preimpreso = 'N'//preimpresos
End if
//--------------------------------Tipo de fecha-----------------------------------
lstr_rangfech.tipo_fecha  =  is_fecha_est 
lstr_rangfech.piepag      =  is_piepagina 
lstr_rangfech.tipocliente =  is_tipocli 

CHOOSE CASE is_data
	CASE 'P'//de un cliente
//------------------------------ORDENAR POR---------------------------------------
		if lstr_rangfech.tipo_orden = 'A' then
			lstr_rangfech.nombre1 = dw_2.GetItemstring(dw_2.Getrow(),"desdecliente")
			lstr_rangfech.nombre2 = dw_2.GetItemstring(dw_2.Getrow(),"hastacliente")
			
			lstr_rangfech.desdeclienteref = em_3.text
			lstr_rangfech.hastaclienteref = em_4.text
			
			If (lstr_rangfech.nombre2 < lstr_rangfech.nombre1) or (IsNull(lstr_rangfech.nombre1)) or &
				(IsNull(lstr_rangfech.nombre2) ) Then
				mensaje("Atención","Verifique que el rango de Clientes sea correcto ","")
				return
				dw_2.SetColumn("desdecliente")
				this.setfocus()
			End If
			
		elseif lstr_rangfech.tipo_orden = 'N' then
			lstr_rangfech.desdeclienteref = dw_2.GetItemstring(dw_2.Getrow(),"desdecliente")
			lstr_rangfech.hastaclienteref = dw_2.GetItemstring(dw_2.Getrow(),"hastacliente")
			
			If (lstr_rangfech.hastaclienteref < lstr_rangfech.desdeclienteref ) or (IsNull(lstr_rangfech.desdeclienteref )) or &
				(IsNull(lstr_rangfech.hastaclienteref) ) Then
				mensaje("Atención","Verifique que el rango de Clientes sea correcto ","")
				return
				dw_2.SetColumn("desdecliente")
				this.setfocus()
			End If
			
		elseif lstr_rangfech.tipo_orden = 'C' then
			lstr_rangfech.ruccli1 = dw_2.GetItemstring(dw_2.Getrow(),"desdecliente")
			lstr_rangfech.ruccli2 = dw_2.GetItemstring(dw_2.Getrow(),"hastacliente")
			
			If (lstr_rangfech.ruccli2 < lstr_rangfech.ruccli1 ) or (IsNull(lstr_rangfech.ruccli1 )) or &
				(IsNull(lstr_rangfech.ruccli2) ) Then
				mensaje("Atención","Verifique que el rango de Clientes sea correcto ","")
				return
				dw_2.SetColumn("desdecliente")
				this.setfocus()
			End If
		end if
// -------------------------------- ORDENAR POR ----------------------------------
		lstr_rangfech.opcion = dw_3.getitemstring(dw_3.getrow(),'op_estado')
      lstr_rangfech.cadena = is_mostrar_mora
			
	CASE 'R'	// pais

		lstr_rangfech.desdecliente = dw_2.GetItemNumber(dw_2.Getrow(),"desdepais")
		lstr_rangfech.hastacliente = dw_2.GetItemNumber(dw_2.Getrow(),"hastapais")

		If (lstr_rangfech.hastacliente < lstr_rangfech.desdecliente) or (IsNull(lstr_rangfech.desdecliente)) or &
		(IsNull(lstr_rangfech.hastacliente) ) Then
			mensaje("Atención","Verifique que el rango del País sea correcto ","")
			return
			dw_2.SetColumn("pais")
			this.setfocus()
		End If
//		lstr_rangfech.empresa = idch_notercero.GetItemNumber(idch_notercero.Getrow(),"empr_empresa")
		lstr_rangfech.opcion = dw_3.getitemstring(dw_3.getrow(),'op_estado')
END CHOOSE

If isDate(em_1.text) then
	If isDate(em_2.text) then
		If date(em_1.text) <= date(em_2.text) then
			lstr_rangfech.fecha1 = date(em_1.text)
			lstr_rangfech.fecha2 = date(em_2.text)
			if not isnull(lstr_rangfech.fecha1) and not isnull(lstr_rangfech.fecha2) or &
			   lstr_rangfech.fecha1 <> date('00/00/0000') and lstr_rangfech.fecha2 <> date('00/00/0000')then
				commit using sqlca;
				wf_actualiza_antiguedad(lstr_rangfech.idioma)
	      	OpenSheetWithParm(w_estadocuenta_imp,lstr_rangfech,str.frame,1, layered!)
				hpb_1.visible = false
				//this.settoolbar(1,False)
			else
				Mensaje("Aviso","El Rango de Fecha es Inválido","Cerciórese de colocar la fecha correctamente")				
				return
			end if	
		Else
			Mensaje("Aviso","El Rango de Fecha es Inválido","Cerciórese de que el Rango de fecha DESDE no sea Mayor que el Rango de fecha HASTA")
         return			
		End If
	Else
		Mensaje("Aviso","La fecha HASTA es Inválida","Cerciórese de que la fecha está en el formato válido DIA/MES/AÑO")
      return		
	End If
Else
	Mensaje("Aviso","La fecha DESDE es Inválida","Cerciórese de que la fecha está en el formato válido DIA/MES/AÑO")
   Return	
End IF	





end event

event ue_post_open;//Override

Date 		ldt_fecha_ini,ldt_fecha_fin
Integer	li_anio,li_mes
string   ls_error, ls_ruc, ls_descrip
long		ll_tercero

ldt_fecha_ini = Date(gf_fecha_serv())
li_anio = year(ldt_fecha_ini)
li_mes  = month(ldt_fecha_ini)

//gf_fecha_ini_fecha_fin(li_mes,li_anio,ldt_fecha_ini,ldt_fecha_fin)

if pos(gf_dg_nombre_empresa(),'ELBROS') > 0 then
	em_1.text = '01/01/'+string(year(ldt_fecha_ini))
else
	//em_1.text = '01/01/'+string(year(ldt_fecha_ini) - 1)
	em_1.text = string(relativedate(date(gf_fecha_serv()), - 365))
end if
em_2.text = String(ldt_fecha_ini)

is_nombre = This.ClassName()

gf_win_used_by_user(is_nombre, true)

dw.settransobject(sqlca)

st_nom_ventana.text = is_nombre
 
if not isnull(is_busqueda) then
	if is_busqueda = 'N' then
		st_4.text = 'RUC'
	else
		st_4.text = 'CODIGO'
	end if
end if
//THIS.postevent("ue_hay_data")

dw_2.SetFocus()

ll_tercero = istr_formato.tercero

if ll_tercero > 0 then	
			
	  SELECT ccmclien.clie_ref_anterior  , terc_descripcion
		 INTO :ls_ruc , :ls_descrip
		 FROM ccmclien  , dgmterce
		WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
				( ccmclien.clie_empresa = :str.empresa ) AND  
				( ccmclien.clie_tercero = dgmterce.terc_tercero ) AND
				( ccmclien.clie_tercero = :ll_tercero )  ;
				if sqlca.sqlcode = -1 then
					mensaje("Aviso","Error al seleccionar el ruc ." +sqlca.sqlerrtext,"")
				end if
		
		em_3.text = ls_ruc
		em_4.text = ls_ruc
		
		dw_2.GetChild("desdecliente",idch_desdecliente)
		dw_2.GetChild("hastacliente",idch_hastacliente)
		
		idch_desdecliente.SetTransObject(Sqlca)
		idch_hastacliente.SetTransObject(Sqlca)
		
		If idch_desdecliente.Retrieve(str.g_financiero,str.empresa) < 1 Then idch_desdecliente.Insertrow(0)
		If idch_hastacliente.Retrieve(str.g_financiero,str.empresa) < 1 Then idch_hastacliente.Insertrow(0)

		
		dw_2.setitem(1,"desdecliente",ls_descrip+string(ll_tercero))
		dw_2.setitem(1,"hastacliente",ls_descrip+string(ll_tercero))
		
		dw_2.accepttext()
		
		This.TriggerEvent("ue_vistaprevia")
		
end if

//this.visible = true
this.setredraw(true)
end event

event key;//
end event

event ue_busqueda;//Override
String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error
integer li_c, li_b
long    ll_lter
lstr_rangfech.tipo_cliesp = dw_4.getitemnumber(1,'tipo_cliente')

Datawindow        dww
str_dg_dynamic_find	lstr_df

if isnull(is_tip_busca) or is_tip_busca = '' then
	is_tip_busca = 'S'
end if

ib_edito_ruc = false
CHOOSE CASE is_tip_busca
	CASE 'S'//código cliente
	
	lstr_df.texto_campo [1,1] = "dgmterce.terc_descripcion"
	lstr_df.texto_campo [1,2] = "Descripción"
	lstr_df.texto_campo [1,3] = ""
	lstr_df.texto_campo [1,4] = 'V'	
	lstr_df.texto_campo [1,5] = '650'	
	lstr_df.texto_campo [2,1] = "ccmclien.clie_ref_anterior"
	lstr_df.texto_campo [2,2] = "Código Cliente"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [3,1] = "dgmterce.terc_identificacion"
	lstr_df.texto_campo [3,2] = "RUC"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [3,5] = '300'	
	lstr_df.texto_campo [4,1] = "dgapais.pais_descripcion"
	lstr_df.texto_campo [4,2] = "País"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [4,5] = '650'
 	lstr_df.texto_campo [5,1] = "dgmterce.terc_tercero"
	lstr_df.texto_campo [5,2] = "Código Tercero"
	lstr_df.texto_campo [5,3] = "terc_tercero"
	lstr_df.texto_campo [5,4] = 'V'
	
 
	lstr_df.tabla = " dgmterce, dgapais, ccmclien "
	
	
	lstr_df.tabla_where = &
				"WHERE ( dgmterce.terc_pais = dgapais.pais_pais ) and  " +&						
						 "(ccmclien.clie_g_financiero = " + string(str.g_financiero) + " and " +&
						 "ccmclien.clie_empresa = " + string(str.empresa) + ") 	and " +&
						"(dgmterce.terc_tercero = ccmclien.clie_tercero)"
	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm
CASE 'N'//codigo ruc
	
	lstr_df.texto_campo [1,1] = "ccmclien.clie_ruc_tercero" //"dgmterce.terc_identificacion"
	lstr_df.texto_campo [1,2] = "RUC"
	lstr_df.texto_campo [1,3] = ""
	lstr_df.texto_campo [1,4] = 'V'
	lstr_df.texto_campo [1,5] = '450'
	lstr_df.texto_campo [2,1] = "dgmterce.terc_descripcion"
	lstr_df.texto_campo [2,2] = "Descripción"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '700'		
	lstr_df.texto_campo [3,1] = "dgmterce.terc_tercero"
	lstr_df.texto_campo [3,2] = "Código Tercero"
	lstr_df.texto_campo [3,3] = "terc_tercero"
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [4,1] = "dgapais.pais_descripcion"
	lstr_df.texto_campo [4,2] = "País"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [4,5] = '550'
	lstr_df.texto_campo [5,1] = "dgmterce.terc_telefono1"
	lstr_df.texto_campo [5,2] = "Telefono 1"
	lstr_df.texto_campo [5,3] = ""
	lstr_df.texto_campo [5,4] = 'V'
	lstr_df.texto_campo [5,5] = '550'
	lstr_df.texto_campo [6,1] = "dgmterce.terc_telefono2"
	lstr_df.texto_campo [6,2] = "Telefono 2"
	lstr_df.texto_campo [6,3] = ""
	lstr_df.texto_campo [6,4] = 'V'
	lstr_df.texto_campo [6,5] = '550'
	lstr_df.texto_campo [7,1] = "ccmclien.clie_contacto_telefono"
	lstr_df.texto_campo [7,2] = "Tel. Contacto"
	lstr_df.texto_campo [7,3] = ""
	lstr_df.texto_campo [7,4] = 'V'
	lstr_df.texto_campo [7,5] = '550'
	lstr_df.texto_campo [8,1] = "ccmclien.clie_ref_anterior"
	lstr_df.texto_campo [8,2] = "Código Cliente"
	lstr_df.texto_campo [8,3] = ""
	lstr_df.texto_campo [8,4] = 'V'
	lstr_df.texto_campo [8,5] = '400'		
	
	lstr_df.tabla = " dgmterce, dgapais, ccmclien "
	
	
	lstr_df.tabla_where = &
				"WHERE ( dgmterce.terc_pais = dgapais.pais_pais ) and  " +&				
						 "(ccmclien.clie_g_financiero = " + string(str.g_financiero) + " and " +&
						 "ccmclien.clie_empresa = " + string(str.empresa) + ") 	and " +&
						"(dgmterce.terc_tercero = ccmclien.clie_tercero)"
	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm
	
/* CASE 'T'//Tercero
	lstr_df.texto_campo [1,1] = "dgmterce.terc_tercero"
	lstr_df.texto_campo [1,2] = "Código"
	lstr_df.texto_campo [1,3] = "terc_tercero"
	lstr_df.texto_campo [1,4] = 'V'
	lstr_df.texto_campo [2,1] = "dgmterce.terc_descripcion"
	lstr_df.texto_campo [2,2] = "Descripción"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [3,1] = "ccmclien.clie_ref_anterior"
	lstr_df.texto_campo [3,2] = "Código Cliente"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [4,1] = "dgmterce.terc_identificacion"
	lstr_df.texto_campo [4,2] = "RUC"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [5,1] = "dgapais.pais_descripcion"
	lstr_df.texto_campo [5,2] = "País"
	lstr_df.texto_campo [5,3] = ""
	lstr_df.texto_campo [5,4] = 'V'
	lstr_df.texto_campo [5,5] = '650'

	lstr_df.tabla = " dgmterce, dgapais, dgaactiv, ccmclien "
	
	
	lstr_df.tabla_where = &
				"WHERE ( dgmterce.terc_pais *= dgapais.pais_pais ) and  " +&
						"( dgmterce.terc_actividad *= CONVERT (numeric, dgaactiv.acti_actividad)) and "+&
						 "(ccmclien.clie_g_financiero = " + string(str.g_financiero) + " and " +&
						 "ccmclien.clie_empresa = " + string(str.empresa) + ") 	and " +&
						"(dgmterce.terc_tercero = ccmclien.clie_tercero)"
	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm */
END CHOOSE


If len (ls_find) = 0 Then Return
	
	
ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo1,"'"," ")
ls_codigo1 = Trim(ls_codigo1)
il_lter = long(ls_codigo1)

  SELECT dgmterce.terc_descripcion  
    INTO :is_descripcion  
    FROM dgmterce  
   WHERE dgmterce.terc_tercero = :il_lter ;
if sqlca.sqldbcode = -1 then
	ls_error = sqlca.sqlerrtext
	mensaje("Error","Ha ocurrido un error al recuperar el ruc del cliente",ls_error)
end if



  SELECT ccmclien.clie_ruc_tercero,  
         ccmclien.clie_ref_anterior
    INTO :is_ruc_,:is_refe_
    FROM ccmclien  
   WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
         ( ccmclien.clie_empresa = :str.empresa ) AND  
         ( ccmclien.clie_tercero = :il_lter )   ;
if sqlca.sqldbcode = -1 then
	ls_error = sqlca.sqlerrtext
	mensaje("Error","Ha ocurrido un error al recuperar el ruc del cliente",ls_error)
end if


end event

event closequery;call super::closequery;string ls_error

//Elimina las tablas temporales 
  DELETE FROM ccatpan  
   WHERE ( ccatpan.tpan_g_financiero = :str.g_financiero ) AND  
         ( ccatpan.tpan_empresa = :str.empresa ) AND  
         ( ccatpan.tpan_maquina = :str.maquina );
if sqlca.sqlcode = -1 then
	ls_error = sqlca.sqlerrtext
	rollback;
	mensaje('Aviso','Error al eliminar ccatpan',ls_error)
	return
end if
	
DELETE FROM ccatempa
WHERE ( ccatempa.tmpa_g_financiero 	= :str.g_financiero 	) AND  
      ( ccatempa.tmpa_empresa 		= :str.empresa 		) and
		( ccatempa.tmpa_usuario_maquina = :str.maquina 		) ;
if sqlca.sqlcode = -1 then
	messagebox('error','error al elimianr registros desde ccatempa')
end if

  DELETE FROM ccatemaf
   WHERE ( tmaf_g_financiero = :str.g_financiero ) AND  
         ( tmaf_empresa = :str.empresa ) AND  
         ( tmaf_usuario_maquina = :str.maquina )   ;
if sqlca.sqlcode = -1 then
	ls_error = sqlca.sqlerrtext
	rollback;
	mensaje('Aviso','Error al eliminar ccatemaf',ls_error)
	return
end if

DELETE FROM cchestado  
WHERE ( cchestado.est_g_financiero =:str.g_financiero  ) AND  
		( cchestado.est_empresa =:str.empresa  ) AND  
		( cchestado.est_usuario_maquina =:str.maquina  )   ;
if sqlca.sqlcode = -1 then
	mensaje('Error','Error eliminando de cchestado','')
end if
end event

type st_nom_ventana from w_cc_padre_rango_fecha`st_nom_ventana within w_estadocuenta
boolean visible = false
integer x = 2217
integer y = 1376
integer width = 1298
integer height = 60
end type

type dw_1 from w_cc_padre_rango_fecha`dw_1 within w_estadocuenta
integer x = 2176
integer y = 296
integer width = 96
integer height = 72
integer taborder = 0
end type

event dw_1::ue_down;//
end event

type p_1 from w_cc_padre_rango_fecha`p_1 within w_estadocuenta
boolean visible = false
integer x = 2327
integer y = 164
end type

type em_2 from w_cc_padre_rango_fecha`em_2 within w_estadocuenta
event ue_key pbm_keydown
integer x = 923
integer y = 272
integer width = 434
integer height = 92
alignment alignment = center!
end type

event em_2::ue_key;if  KeyDown(KeyEnter!) then
	if dw_3.getitemstring(1,'op_estado') = 'P' then
		em_3.setfocus()
	else
		dw_2.setfocus()
	end if
end if
end event

event em_2::getfocus;cb_1.Default= false
end event

type st_2 from w_cc_padre_rango_fecha`st_2 within w_estadocuenta
integer x = 745
integer y = 288
integer width = 178
integer height = 68
integer textsize = -8
long textcolor = 15793151
long backcolor = 8421376
boolean border = false
borderstyle borderstyle = stylebox!
end type

type em_1 from w_cc_padre_rango_fecha`em_1 within w_estadocuenta
integer x = 233
integer y = 272
integer width = 434
integer height = 92
integer taborder = 30
alignment alignment = center!
end type

event em_1::losefocus;Date 		ldt_fecha_ini,ldt_fecha_fin
Integer	li_anio,li_mes

ldt_fecha_ini = date(em_1.text)
li_anio = year(ldt_fecha_ini)
li_mes  = month(ldt_fecha_ini)

//gf_fecha_ini_fecha_fin(li_mes,li_anio,ldt_fecha_ini,ldt_fecha_fin)

em_1.text = string(ldt_fecha_ini)
//em_2.text = String(ldt_fecha_fin)

end event

event em_1::ue_postkey;call super::ue_postkey;if  KeyDown(KeyEnter!) then
	em_2.setfocus()
end if
end event

event em_1::getfocus;cb_1.Default= false
end event

type st_1 from w_cc_padre_rango_fecha`st_1 within w_estadocuenta
integer x = 41
integer y = 284
integer width = 192
integer height = 72
integer textsize = -8
long textcolor = 15793151
long backcolor = 8421376
boolean border = false
borderstyle borderstyle = stylebox!
end type

type gb_1 from w_cc_padre_rango_fecha`gb_1 within w_estadocuenta
boolean visible = false
integer x = 14
integer y = 36
integer width = 1431
integer textsize = -8
long textcolor = 15793151
long backcolor = 8421376
string text = "Fechas:"
end type

type st_7 from w_cc_padre_rango_fecha`st_7 within w_estadocuenta
integer x = 969
integer y = 928
integer width = 448
integer height = 128
end type

type cb_1 from w_cc_padre_rango_fecha`cb_1 within w_estadocuenta
integer x = 987
integer y = 940
integer width = 421
integer height = 104
integer taborder = 120
string text = "CONSULTAR"
boolean default = false
end type

event cb_1::clicked;call super::clicked;//String  ls_sql
//
//ls_sql = sqlsyntax
//ls_sql+=  " AND  " + &
//"  ( plcvacac.vacac_g_financiero = " + String(str.g_financiero) + " ) AND " + &
//"  ( plcvacac.vacac_empresa = " +String(str.empresa) + " ) AND " + &
//"  ( plcvacac.vacac_tipo_plani = "  + String(w_pl_fondo.str_planilla.tipo_planilla) + " ) AND "  + &
//"  ( plcvacac.vacac_concepto = " + string(1) + " ) AND "  + &
//"  ( plmemple.empl_banco_empresa = " + string(ii_banco) + " )  AND " + &
//"  ( plmemple.empl_forma_pago = 'V' ) "  
//	This.SetSqlPreview(ls_sql)
end event

type pb_1 from w_cc_padre_rango_fecha`pb_1 within w_estadocuenta
end type

type pb_2 from w_cc_padre_rango_fecha`pb_2 within w_estadocuenta
end type

type gb_5 from groupbox within w_estadocuenta
boolean visible = false
integer x = 2926
integer y = 52
integer width = 599
integer height = 292
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
end type

type dw_2 from datawindow within w_estadocuenta
event ue_enter pbm_dwnkey
integer x = 1056
integer y = 556
integer width = 1070
integer height = 196
boolean bringtotop = true
string dataobject = "dw_cc_rango_cliente_nombre"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_codigo_ant
datawindowchild dwch_cliente, dwch_cliente1

CHOOSE CASE dw_2.getcolumnname()
//---------------------------------------------------------------------------------
CASE 'desdecliente'

		this.getchild('desdecliente', dwch_cliente)
		
		If is_busqueda = 'N' then
			ls_codigo_ant = dwch_cliente.getitemstring(dwch_cliente.getrow(),'ccmclien_clie_ruc_tercero')
		Else
		
			ls_codigo_ant = dwch_cliente.getitemstring(dwch_cliente.getrow(),'ccmclien_clie_ref_anterior')
			
		End If
//messagebox('ls_codigo_ant',ls_codigo_ant)
   	em_3.text = ls_codigo_ant
		em_4.text = ls_codigo_ant
		this.setitem(this.getrow(),'hastacliente',data)
		//em_3.postevent('modified')
CASE 'hastacliente'
		this.getchild('hastacliente', dwch_cliente)
		if is_busqueda = 'N' then
			ls_codigo_ant = dwch_cliente.getitemstring(dwch_cliente.getrow(),'ccmclien_clie_ruc_tercero')
	   else
			ls_codigo_ant = dwch_cliente.getitemstring(dwch_cliente.getrow(),'ccmclien_clie_ref_anterior')
		end if

		em_4.text = ls_codigo_ant
		
//---------------------------------------------------------------------------------
	CASE 'desdeempre'
		this.setitem(this.getrow(),'desdeempre', long(data) )
		//this.getchild('desdeempre',dwch_cliente)
		ls_codigo_ant = string(dwch_cliente.getitemnumber(dwch_cliente.getrow(),'empr_empresa'))
	   
		this.setitem(this.getrow(),'hastaempre', long(data) )
	//	em_3.postevent('modified')
	CASE 'desdegrupo'
		this.getchild('desdegrupo', dwch_cliente)
		
		ls_codigo_ant = string(dwch_cliente.getitemnumber(dwch_cliente.getrow(),'grup_g_financiero'))
	   this.setitem(this.getrow(),'hastagrupo', long(data) )
		//em_3.postevent('modified')
   CASE 'desdepais'
		this.getchild('desdepais', dwch_cliente)
		
		ls_codigo_ant = string(dwch_cliente.getitemnumber(dwch_cliente.getrow(),'pais_pais'))
	   this.setitem(this.getrow(),'hastapais', long(data) )
		
	//em_3.postevent('modified')
END CHOOSE

end event

event clicked;cb_1.Default= false
end event

type dw_3 from datawindow within w_estadocuenta
event ue_key pbm_dwnkey
integer x = 1550
integer y = 268
integer width = 750
integer height = 96
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_cc_externo_estado_cuenta"
boolean border = false
boolean livescroll = true
end type

event ue_key;If  KeyDown(KeyEnter!) then
	em_1.setfocus()
End if
end event

event itemchanged;this.PostEvent("clicked")


end event

event clicked;this.AcceptText()
cb_1.Default= false
em_3.enabled = false
em_4.enabled = false
em_3.text = ''
em_4.text = ''
is_data = this.getitemstring(this.getrow(),'op_estado')

if is_data = 'P' then
	rb_2.enabled = true
else
	rb_2.enabled = false
end if
CHOOSE CASE is_data
	CASE 'P'//Un cliente de una empresa
		pb_3.enabled = true
		pb_4.enabled = true
		rb_10.enabled = true	
		rb_9.enabled = true
		rb_11.enabled = true
		rb_12.enabled = true
		
		
		//datawindows sw tipo
		dw_4.enabled = true
		dw_5.enabled = true
		dw_6.enabled = true
				
		
		em_3.enabled = true
		em_4.enabled = true
		
		if rb_3.checked = true then// is_tip_busca = 'S' then
			dw_2.DataObject = 'dw_cc_rango_cliente_nombre'//codigo de cliente
		elseif rb_4.checked = true then
			dw_2.DataObject = 'dw_cc_rango_cliente_referencia'
		elseif rb_5.checked = true then
			dw_2.DataObject = 'dw_cc_rango_cliente_ruc'
		end if
		
		dw_2.Accepttext()
		dw_2.GetChild("desdecliente",idch_desdecliente)
		dw_2.GetChild("hastacliente",idch_hastacliente)
		
		idch_desdecliente.SetTransObject(Sqlca)
		idch_hastacliente.SetTransObject(Sqlca)
		
		If idch_desdecliente.Retrieve(str.g_financiero,str.empresa) < 1 Then idch_desdecliente.Insertrow(0)
		If idch_hastacliente.Retrieve(str.g_financiero,str.empresa) < 1 Then idch_hastacliente.Insertrow(0)
		
		dw_2.ScrollToRow(dw_2.InsertRow(0))
		dw_2.SetFocus()		
		
		  		
	CASE 'R'//Por pais
		dw_2.DataObject = 'dw_cc_rango_pais'
      
		pb_3.enabled = false
		pb_4.enabled = false
		
		rb_9.enabled = false
		
		//datawindows de tipo
		dw_4.enabled = false
		dw_5.enabled = false
		dw_6.enabled = false
		
		rb_10.enabled = false
		rb_11.enabled = false
		rb_12.enabled = false
		//rb_5.enabled = false
		
		dw_2.enabled = true // porque falso
		dw_2.Accepttext()
		dw_2.GetChild("desdepais",idch_desdecliente)
		dw_2.GetChild("hastapais",idch_hastacliente)
		
		idch_desdecliente.SetTransObject(Sqlca)
		idch_hastacliente.SetTransObject(Sqlca)
		
		If idch_desdecliente.Retrieve() < 1 Then idch_desdecliente.Insertrow(0)
		If idch_hastacliente.Retrieve() < 1 Then idch_hastacliente.Insertrow(0)
		
		dw_2.ScrollToRow(dw_2.InsertRow(0))
		dw_2.setfocus()	

END CHOOSE

end event

type gb_2 from groupbox within w_estadocuenta
boolean visible = false
integer x = 2222
integer y = 52
integer width = 617
integer height = 292
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = " Generar "
end type

type st_desde from statictext within w_estadocuenta
integer x = 846
integer y = 564
integer width = 206
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 8421376
boolean enabled = false
string text = "DESDE"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_hasta from statictext within w_estadocuenta
integer x = 846
integer y = 668
integer width = 206
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 8421376
boolean enabled = false
string text = "HASTA"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type em_3 from editmask within w_estadocuenta
event ue_key pbm_keydown
integer x = 192
integer y = 560
integer width = 480
integer height = 80
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "xxxxxxxxxxxxxxxxxxxx"
end type

event ue_key;if  KeyDown(KeyEnter!) then
	em_4.setfocus()
end if
end event

event modified;string  ls_error, ls_descripcion, ls_ref_anterior, ls_ruc
li_cliente = 0
ls_codigo = this.text

CHOOSE CASE is_tip_busca
	  CASE 'N'            //RUC
			SELECT ccmclien.clie_tercero 
			 into :li_cliente
			 FROM ccmclien  
			 WHERE ( ccmclien.clie_g_financiero = :str.g_financiero 	) AND  
					 ( ccmclien.clie_empresa 		= :str.empresa 		) AND  
					 ( ccmclien.clie_ruc_tercero  = :ls_codigo 			) ;
			if sqlca.sqldbcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje('Error','Error al recuperar el cliente',ls_error)
  			end if
		CASE ELSE         //CODIGO

		    SELECT ccmclien.clie_tercero
			 into :li_cliente 
			 FROM ccmclien  
			 WHERE ( ccmclien.clie_g_financiero = :str.g_financiero 	) AND  
					 ( ccmclien.clie_empresa 		= :str.empresa 		) AND  
					 ( ccmclien.clie_ref_anterior = :ls_codigo 			) ;
			if sqlca.sqldbcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje('Error','Error al recuperar el cliente',ls_error)
  			end if
		
/*	  CASE 'N'//RUC
			SELECT ccmclien.clie_tercero 
			 into :li_cliente
			 FROM ccmclien  
			 WHERE ( ccmclien.clie_g_financiero = :str.g_financiero 	) AND  
					 ( ccmclien.clie_empresa 		= :str.empresa 		) AND  
					 ( ccmclien.clie_ruc_tercero  = :ls_codigo 			) ;
			if sqlca.sqldbcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje('Error','Error al recuperar el cliente',ls_error)
  			end if
		CASE ELSE //tercero
			SELECT ccmclien.clie_tercero 
		 into :li_cliente
		 FROM ccmclien  
		 WHERE ( ccmclien.clie_g_financiero = :str.g_financiero 	) AND  
				 ( ccmclien.clie_empresa 		= :str.empresa 		) AND  
				 ( ccmclien.clie_ref_anterior = :ls_codigo 			) ;
		if sqlca.sqldbcode = -1 then
	   	ls_error = sqlca.sqlerrtext
			rollback;
			mensaje('Error','Error al recuperar el cliente',ls_error)
  		end if*/
      
END CHOOSE

if rb_3.checked = true  then
	SELECT dgmterce.terc_descripcion  
	INTO :ls_descripcion
	FROM dgmterce  
	WHERE dgmterce.terc_tercero = :li_cliente   ;
	if sqlca.sqldbcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje('Error','Error al recuperar la descripcion del cliente',ls_error)
	end if
elseif rb_5.checked = true  then	
	  SELECT dgmterce.terc_descripcion,   
            dgmterce.terc_identificacion  
    INTO :ls_descripcion,   
         :ls_ruc 
    FROM dgmterce  
	WHERE ( dgmterce.terc_tercero = :li_cliente )   ;
	if sqlca.sqldbcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje('Error','Error al recuperar el ruc del cliente',ls_error)
	end if
end if


	if isnull(li_cliente) or li_cliente = 0 then
		mensaje('Información', 'Este Código no Existe! Verifique si su busqueda es Por Cliente o Por RUC' ,&
		'Si usted desea modificar el tipo de Busqueda debe ir a Parámetros, Sistemas, Generales y Elegir la búsqueda deseada.')
		this.text = ''
		dw_2.setitem(1,'desdecliente',0)
	else
		
		if rb_3.checked = true  then
			dw_2.setitem(1,'desdecliente',ls_descripcion+string(li_cliente))
			dw_2.setitem(1,'hastacliente',ls_descripcion+string(li_cliente))
			em_4.text = ls_codigo
			em_3.setfocus()
			
		elseif rb_4.checked = true  then
			dw_2.setitem(1,'desdecliente',ls_codigo)
			dw_2.setitem(1,'hastacliente',ls_codigo)
			em_3.setfocus()
		else
			dw_2.setitem(1,'desdecliente',ls_ruc)
			dw_2.setitem(1,'hastacliente',ls_ruc)
			em_3.setfocus()
		end if
		em_4.text = ls_codigo
	end if
 

end event

event getfocus;cb_1.Default= false
end event

type st_4 from statictext within w_estadocuenta
integer x = 197
integer y = 508
integer width = 489
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 8421376
boolean enabled = false
string text = "Cuenta"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_4 from editmask within w_estadocuenta
event ue_key pbm_keydown
integer x = 192
integer y = 660
integer width = 480
integer height = 80
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "xxxxxxxxxxxxxxx"
end type

event ue_key;if  KeyDown(KeyEnter!) then
	cb_1.setfocus()
	cb_1.Default= true
end if
end event

event modified;
string  ls_error, ls_descripcion, ls_ruc

li_cliente = 0
ls_codigo = this.text

CHOOSE CASE is_tip_busca//is_busqueda

   CASE 'N'//RUC
		SELECT ccmclien.clie_tercero 
		 into :li_cliente
		 FROM ccmclien  
		 WHERE ( ccmclien.clie_g_financiero = :str.g_financiero 	) AND  
				 ( ccmclien.clie_empresa 		= :str.empresa 		) AND  
				 ( ccmclien.clie_ruc_tercero  = :ls_codigo 			) ;
		if sqlca.sqldbcode = -1 then
	   	ls_error = sqlca.sqlerrtext
			rollback;
			mensaje('Error','Error al recuperar el cliente',ls_error)
  		end if


	CASE ELSE //'S'//
		SELECT ccmclien.clie_tercero 
		 into :li_cliente
		 FROM ccmclien  
		 WHERE ( ccmclien.clie_g_financiero = :str.g_financiero 	) AND  
				 ( ccmclien.clie_empresa 		= :str.empresa 		) AND  
				 ( ccmclien.clie_ref_anterior = :ls_codigo 			) ;
		if sqlca.sqldbcode = -1 then
	   	ls_error = sqlca.sqlerrtext
			rollback;
			mensaje('Error','Error al recuperar el cliente',ls_error)
  		end if

		
	/*	CASE ELSE		
			SELECT ccmclien.clie_tercero 
			 into :li_cliente
			 FROM ccmclien  
			 WHERE ( ccmclien.clie_g_financiero = :str.g_financiero 	) AND  
					 ( ccmclien.clie_empresa 		= :str.empresa 		) AND  
					 ( ccmclien.clie_ruc_tercero  = :ls_codigo 			) ;
			if sqlca.sqldbcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje('Error','Error al recuperar el cliente',ls_error)
  			end if*/
END CHOOSE

if rb_3.checked = true then
	
	SELECT dgmterce.terc_descripcion  
	INTO :ls_descripcion
	FROM dgmterce  
	WHERE dgmterce.terc_tercero = :li_cliente   ;
	if sqlca.sqldbcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje('Error','Error al recuperar la descripcion del cliente',ls_error)
	end if
elseif rb_5.checked = true  then	
	SELECT dgmterce.terc_descripcion, dgmterce.terc_identificacion  
	INTO :ls_descripcion, :ls_ruc
	FROM dgmterce  
	WHERE dgmterce.terc_tercero = :li_cliente   ;
	if sqlca.sqldbcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje('Error','Error al recuperar la descripcion del cliente',ls_error)
	end if

end if

	if isnull(li_cliente) or li_cliente = 0 then
		mensaje('Información', 'Este Código no Existe! Verifique si su búsqueda es Por Cliente, Por RUC o Por Tercero' ,&
		'Si usted desea modificar el tipo de Búsqueda debe ir a Parámetros, Sistemas, Generales y Elegir la búsqueda deseada.')
		
		this.text = ''
		dw_2.setitem(1,'hastacliente',0)
	//end if
	else
		if rb_3.checked = true  then
			dw_2.setitem(1,'hastacliente',ls_descripcion+string(li_cliente))
			em_4.setfocus()
		elseif rb_4.checked = true then	
			dw_2.setitem(1,'hastacliente',ls_codigo)
			em_4.setfocus()
		else
			dw_2.setitem(1,'hastacliente',ls_ruc)
			em_4.setfocus()
		end if
	
	end if

end event

event getfocus;cb_1.Default= false
end event

type rb_1 from radiobutton within w_estadocuenta
boolean visible = false
integer x = 2939
integer y = 132
integer width = 558
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sólo con Movimientos"
boolean checked = true
end type

event clicked;cb_1.Default= false
end event

type rb_2 from radiobutton within w_estadocuenta
boolean visible = false
integer x = 2967
integer y = 204
integer width = 480
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sin Movimientos"
end type

event clicked;cb_1.Default= false
end event

type rb_3 from radiobutton within w_estadocuenta
boolean visible = false
integer x = 2286
integer y = 772
integer width = 507
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = " Alfabeticamente"
boolean checked = true
end type

event clicked;cb_1.Default= false
if is_data = 'P' then
	dw_2.Dataobject = 'dw_cc_rango_cliente_nombre'
	
	dw_2.Accepttext()
	dw_2.GetChild("desdecliente",idch_notercero)
	idch_notercero.SetTransObject(Sqlca)
	idch_notercero.Retrieve(str.g_financiero,str.empresa)
	If idch_notercero.rowcount() < 1 then
		idch_notercero.InsertRow(0)
	End If
	
	dw_2.GetChild("hastacliente",idch_notercero1)
	idch_notercero1.SetTransObject(Sqlca)
	idch_notercero1.Retrieve(str.g_financiero,str.empresa)
	If idch_notercero1.rowcount() < 1 then
		idch_notercero1.InsertRow(0)
	End If
	
	dw_3.insertRow(1)//Datawindow externo de opciones
	dw_2.ScrollToRow(dw_2.InsertRow(0))//DropDow de Clientes
	dw_2.SetFocus()
	
	
	idch_notercero.Setsort('cliente A')
	idch_notercero.sort()
	idch_notercero1.Setsort('cliente A')
	idch_notercero1.sort()
end if
end event

type rb_4 from radiobutton within w_estadocuenta
boolean visible = false
integer x = 2286
integer y = 832
integer width = 489
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Por Nº de Cliente"
end type

event clicked;cb_1.Default= false

dw_2.Dataobject = 'dw_cc_rango_cliente_referencia'

dw_2.Accepttext()
dw_2.GetChild("desdecliente",idch_notercero)
idch_notercero.SetTransObject(Sqlca)
idch_notercero.Retrieve(str.g_financiero,str.empresa)
If idch_notercero.rowcount() < 1 then
	idch_notercero.InsertRow(0)
End If

dw_2.GetChild("hastacliente",idch_notercero1)
idch_notercero1.SetTransObject(Sqlca)
idch_notercero1.Retrieve(str.g_financiero,str.empresa)
If idch_notercero1.rowcount() < 1 then
	idch_notercero1.InsertRow(0)
End If

dw_3.insertRow(1)//Datawindow externo de opciones
dw_2.ScrollToRow(dw_2.InsertRow(0))//DropDow de Clientes
dw_2.SetFocus()


idch_notercero.Setsort('ccmclien_clie_ref_anterior A')
idch_notercero.sort()
idch_notercero1.Setsort('ccmclien_clie_ref_anterior A')
idch_notercero1.sort()
end event

type rb_5 from radiobutton within w_estadocuenta
boolean visible = false
integer x = 2286
integer y = 896
integer width = 512
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Por RUC del Cliente"
end type

event clicked;cb_1.Default= false

dw_2.Dataobject = 'dw_cc_rango_cliente_ruc'

dw_2.Accepttext()
dw_2.GetChild("desdecliente",idch_notercero)
idch_notercero.SetTransObject(Sqlca)
idch_notercero.Retrieve(str.g_financiero,str.empresa)
If idch_notercero.rowcount() < 1 then
	idch_notercero.InsertRow(0)
End If

dw_2.GetChild("hastacliente",idch_notercero1)
idch_notercero1.SetTransObject(Sqlca)
idch_notercero1.Retrieve(str.g_financiero,str.empresa)
If idch_notercero1.rowcount() < 1 then
	idch_notercero1.InsertRow(0)
End If


dw_3.insertRow(1)//Datawindow externo de opciones
dw_2.ScrollToRow(dw_2.InsertRow(0))//DropDow de Clientes
dw_2.SetFocus()

idch_notercero.Setsort('ccmclien_clie_ruc_tercero A')
idch_notercero.sort()
idch_notercero1.Setsort('ccmclien_clie_ruc_tercero A')
idch_notercero1.sort()
end event

type pb_3 from picturebutton within w_estadocuenta
integer x = 713
integer y = 548
integer width = 110
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Find1!"
string disabledname = "Find1!"
alignment htextalign = left!
end type

event clicked;Parent.TriggerEvent("ue_busqueda")//

if rb_3.checked = true then       //alfabetico
	
	dw_2.setitem(1,'desdecliente',is_descripcion+string(il_lter))
	dw_2.setitem(1,'hastacliente',is_descripcion+string(il_lter))
	
elseif rb_4.checked = true then  //cliente
	dw_2.setitem(1,'desdecliente',is_refe_)
	dw_2.setitem(1,'hastacliente',is_refe_)

elseif rb_5.checked = true then  //ruc

	dw_2.setitem(1,'desdecliente',is_ruc_)
	dw_2.setitem(1,'hastacliente',is_ruc_)
	
end if


If is_tip_busca = 'N' then
	em_3.text = is_ruc_
	em_4.text = is_ruc_
Else
	em_3.text = is_refe_ 
	em_4.text = is_refe_
End if	
	


end event

type pb_4 from picturebutton within w_estadocuenta
integer x = 713
integer y = 656
integer width = 110
integer height = 96
integer taborder = 100
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Find1!"
string disabledname = "Find1!"
alignment htextalign = left!
end type

event clicked;Parent.TriggerEvent("ue_busqueda")//

if rb_3.checked = true then//alfabetico
//	em_3.text = is_refe_ 
//	em_4.text = is_refe_
	
//	dw_2.setitem(1,'desdecliente',is_descripcion)
	dw_2.setitem(1,'hastacliente',is_descripcion+string(il_lter))
	
elseif rb_4.checked = true then //cliente
//	em_3.text = is_refe_
//	em_4.text = is_refe_
	
//	dw_2.setitem(1,'desdecliente',is_refe_)
	dw_2.setitem(1,'hastacliente',is_refe_)

elseif rb_5.checked = true then//ruc
//	em_3.text = is_ruc_
//	em_4.text = is_ruc_
	
//	dw_2.setitem(1,'desdecliente',is_ruc_)
	dw_2.setitem(1,'hastacliente',is_ruc_)
	
end if
//em_3.postevent('modified')

If is_tip_busca = 'N' then
	em_4.text = is_ruc_	
Else
	em_4.text = is_refe_
End if	
end event

type rb_6 from radiobutton within w_estadocuenta
integer x = 1746
integer y = 80
integer width = 302
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Español"
boolean checked = true
end type

type rb_7 from radiobutton within w_estadocuenta
integer x = 2062
integer y = 80
integer width = 238
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Inglés"
end type

type rb_8 from radiobutton within w_estadocuenta
boolean visible = false
integer x = 2738
integer y = 336
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Todos"
boolean checked = true
end type

event clicked;integer  li_null

setnull(li_null)
dw_4.enabled = false
dw_4.setitem(dw_3.getrow(),'tipo_cliente',li_null)
dw_4.setitem(dw_4.getrow(),'tipo_cliente',li_null)

dw_5.enabled = false
dw_5.setitem(dw_5.getrow(),'tipo_socio',li_null)

dw_6.enabled = false
dw_6.setitem(dw_6.getrow(),'tipo_auditor',li_null)

idch_desdecliente.Setfilter("")
idch_desdecliente.Filter()
idch_hastacliente.Setfilter("")
idch_hastacliente.Filter()

idch_desdecliente.Setsort('cliente A')
idch_desdecliente.sort()
idch_hastacliente.Setsort('cliente A')
idch_hastacliente.sort()
end event

type rb_9 from radiobutton within w_estadocuenta
boolean visible = false
integer x = 2738
integer y = 420
integer width = 338
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Tipo "
end type

event clicked;dw_4.enabled = true

dw_5.enabled = false
dw_6.enabled = false
end event

type dw_4 from datawindow within w_estadocuenta
boolean visible = false
integer x = 3109
integer y = 388
integer width = 777
integer height = 80
integer taborder = 80
boolean bringtotop = true
string dataobject = "dw_cc_ext_tipo_cliente"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;integer  li_data,li_null
string ls_null
li_data = integer(data)
setnull(li_null)

//Limpia el datawindow de busqueda

dw_2.setitem(1,'desdecliente',ls_null)
dw_2.setitem(1,'hastacliente',ls_null)


idch_desdecliente.Setfilter("clie_clasificacion ="+ string(li_data))
idch_desdecliente.Filter()
idch_hastacliente.Setfilter("clie_clasificacion ="+ string(li_data))
idch_hastacliente.Filter()

idch_notercero.Setfilter("clie_clasificacion ="+ string(li_data))
idch_notercero.Filter()
idch_notercero1.Setfilter("clie_clasificacion ="+ string(li_data))
idch_notercero1.Filter()

dw_5.setitem(dw_5.getrow(),'tipo_socio',li_null)

dw_6.setitem(dw_6.getrow(),'tipo_auditor',li_null)
em_3.text = ''
em_4.text = ''
end event

type rb_10 from radiobutton within w_estadocuenta
boolean visible = false
integer x = 2377
integer y = 436
integer width = 329
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Preimpreso"
boolean righttoleft = true
end type

type sle_1 from singlelineedit within w_estadocuenta
boolean visible = false
integer x = 2226
integer y = 728
integer width = 1966
integer height = 172
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type st_5 from statictext within w_estadocuenta
boolean visible = false
integer x = 2222
integer y = 652
integer width = 288
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 80263328
string text = "Mensaje :"
boolean focusrectangle = false
end type

type rb_11 from radiobutton within w_estadocuenta
boolean visible = false
integer x = 2738
integer y = 512
integer width = 311
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Socio"
end type

event clicked;dw_5.enabled = true

dw_4.enabled = false
dw_6.enabled = false
end event

type dw_5 from datawindow within w_estadocuenta
boolean visible = false
integer x = 3109
integer y = 492
integer width = 777
integer height = 88
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "dw_cc_ext_socio"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;integer  li_data, li_null
string   ls_null

li_data = integer(data)
setnull(li_null)
setnull(ls_null)
//Limpia el datawindow de busqueda

dw_2.setitem(1,'desdecliente',ls_null)
dw_2.setitem(1,'hastacliente',ls_null)

idch_desdecliente.Setfilter("clie_socio ="+ string(li_data))
idch_desdecliente.Filter()
idch_hastacliente.Setfilter("clie_socio ="+ string(li_data))
idch_hastacliente.Filter()

idch_notercero.Setfilter("clie_socio ="+ string(li_data))
idch_notercero.Filter()
idch_notercero1.Setfilter("clie_socio ="+ string(li_data))
idch_notercero1.Filter()

dw_4.setitem(dw_4.getrow(),'tipo_cliente',li_null)
dw_6.setitem(dw_6.getrow(),'tipo_auditor',li_null)
em_3.text = ''
em_4.text = ''

end event

type rb_12 from radiobutton within w_estadocuenta
boolean visible = false
integer x = 2738
integer y = 612
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Auditor"
end type

event clicked;dw_6.enabled = true

dw_5.enabled = false
dw_4.enabled = false
end event

type dw_6 from datawindow within w_estadocuenta
boolean visible = false
integer x = 3109
integer y = 600
integer width = 777
integer height = 80
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "dw_cc_ext_auditor"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;integer  li_data, li_null
string   ls_null
li_data = integer(data)
setnull(li_null)
setnull(ls_null)

//Limpia el datawindow de busqueda

dw_2.setitem(1,'desdecliente',ls_null)
dw_2.setitem(1,'hastacliente',ls_null)


idch_desdecliente.Setfilter("clie_auditor ="+ string(li_data))
idch_desdecliente.Filter()
idch_hastacliente.Setfilter("clie_auditor ="+ string(li_data))
idch_hastacliente.Filter()

idch_notercero.Setfilter("clie_auditor ="+ string(li_data))
idch_notercero.Filter()
idch_notercero1.Setfilter("clie_auditor ="+ string(li_data))
idch_notercero1.Filter()

dw_4.setitem(dw_4.getrow(),'tipo_cliente',li_null)
dw_5.setitem(dw_5.getrow(),'tipo_socio',li_null)
em_3.text = ''
em_4.text = ''

end event

type rb_30 from radiobutton within w_estadocuenta
boolean visible = false
integer x = 32
integer y = 80
integer width = 283
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "30 Dias"
end type

event clicked;if this.checked then
	rb_60.checked = false
	rb_90.checked = false
	rb_120.checked = false	
	rb_total.checked = false
	rb_1ann.checked = false	
	rb_2ann.checked = false
end if

em_2.text = string(date(gf_fecha_serv()))
em_1.text = string(relativedate(date(gf_fecha_serv()), - 30))
end event

type rb_60 from radiobutton within w_estadocuenta
integer x = 59
integer y = 80
integer width = 283
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "60 Dias"
end type

event clicked;if this.checked then
	rb_30.checked = false
	rb_90.checked = false
	rb_120.checked = false	
	rb_total.checked = false
	rb_1ann.checked = false	
	rb_2ann.checked = false	
end if

em_2.text = string(date(gf_fecha_serv()))
em_1.text = string(relativedate(date(gf_fecha_serv()), - 60))
end event

type rb_90 from radiobutton within w_estadocuenta
integer x = 338
integer y = 80
integer width = 283
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "90 Dias"
end type

event clicked;if this.checked then
	rb_30.checked = false
	rb_60.checked = false
	rb_120.checked = false	
	rb_total.checked = false
	rb_1ann.checked = false
	rb_2ann.checked = false
end if

em_2.text = string(date(gf_fecha_serv()))
em_1.text = string(relativedate(date(gf_fecha_serv()), - 90))
end event

type rb_120 from radiobutton within w_estadocuenta
integer x = 631
integer y = 80
integer width = 283
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "120 Dias"
end type

event clicked;if this.checked then
	rb_30.checked = false
	rb_60.checked = false
	rb_90.checked = false	
	rb_total.checked = false
	rb_1ann.checked = false
	rb_2ann.checked = false
end if

em_2.text = string(date(gf_fecha_serv()))
em_1.text = string(relativedate(date(gf_fecha_serv()), - 120))
end event

type rb_total from radiobutton within w_estadocuenta
integer x = 1463
integer y = 80
integer width = 224
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Total"
end type

event clicked;if this.checked then
	rb_30.checked = false
	rb_60.checked = false
	rb_90.checked = false
	rb_120.checked = false	
	rb_1ann.checked = false
	rb_2ann.checked = false	
end if

em_2.text = string(date(gf_fecha_serv()))
em_1.text = string(relativedate(date(gf_fecha_serv()), - 2000))
end event

type calendario from picture within w_estadocuenta
integer x = 667
integer y = 272
integer width = 69
integer height = 92
boolean bringtotop = true
string picturename = "C:\Sistemas\Hymsoft\Art\ddfec.bmp"
boolean focusrectangle = false
end type

event clicked;date 	ld_date,ld_ini_date, ld_hoy
	
	ld_ini_date=date(em_1.text)
	if year(ld_ini_date) = 1900 then
		ld_ini_date = ld_hoy
	end if
	if uo_1.visible=false then
		uo_1.wf_set_value(ld_ini_date)
		uo_1.visible=true
		uo_1.allow_close=false
		uo_1.inicializar()
		uo_1.TriggerEvent('ue_abrir')
	end if

end event

type calendario2 from picture within w_estadocuenta
integer x = 1358
integer y = 268
integer width = 69
integer height = 96
boolean bringtotop = true
string picturename = "C:\Sistemas\Hymsoft\Art\ddfec.bmp"
boolean focusrectangle = false
end type

event clicked;date 	ld_date,ld_ini_date, ld_hoy
	
	ld_ini_date=date(em_2.text)
	if year(ld_ini_date) = 1900 then
		ld_ini_date = ld_hoy
	end if
	if uo_2.visible=false then
		uo_2.wf_set_value(ld_ini_date)
		uo_2.visible=true
		uo_2.allow_close=false
		uo_2.inicializar()
		uo_2.TriggerEvent('ue_abrir')
	end if

end event

type uo_1 from u_ddcalen within w_estadocuenta
boolean visible = false
integer x = 18
integer y = 344
integer taborder = 60
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;em_1.text = string(uo_1.return_sel_date())

if uo_1.allow_close then
	this.visible=false
	em_1.SetFocus()
end if


end event

on uo_1.destroy
call u_ddcalen::destroy
end on

type uo_2 from u_ddcalen within w_estadocuenta
boolean visible = false
integer x = 713
integer y = 344
integer taborder = 70
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;em_2.text = string(uo_2.return_sel_date())

if uo_2.allow_close then
	this.visible=false
	em_2.SetFocus()
end if


end event

on uo_2.destroy
call u_ddcalen::destroy
end on

type rb_2ann from radiobutton within w_estadocuenta
integer x = 1175
integer y = 80
integer width = 283
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "2 Años"
end type

event clicked;if this.checked then
	rb_30.checked = false
	rb_60.checked = false
	rb_90.checked = false	
	rb_1ann.checked = false
	rb_total.checked = false
	rb_120.checked = false	
end if

em_2.text = string(date(gf_fecha_serv()))
em_1.text = string(relativedate(date(gf_fecha_serv()), - 730))
end event

type rb_1ann from radiobutton within w_estadocuenta
integer x = 928
integer y = 84
integer width = 247
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "1 Año"
boolean checked = true
end type

event clicked;if this.checked then
	rb_30.checked = false
	rb_60.checked = false
	rb_90.checked = false	
	rb_total.checked = false
	rb_120.checked = false	
	rb_2ann.checked = false	
end if

em_2.text = string(date(gf_fecha_serv()))
em_1.text = string(relativedate(date(gf_fecha_serv()), - 365))
end event

type gb_3 from groupbox within w_estadocuenta
integer x = 105
integer y = 444
integer width = 2066
integer height = 364
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 8421376
string text = "Valores"
end type

type gb_4 from groupbox within w_estadocuenta
integer x = 18
integer y = 20
integer width = 1691
integer height = 172
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Periodo"
end type

type gb_6 from groupbox within w_estadocuenta
integer x = 1733
integer y = 20
integer width = 626
integer height = 172
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Idioma"
end type

type hpb_1 from hprogressbar within w_estadocuenta
boolean visible = false
integer x = 114
integer y = 820
integer width = 2066
integer height = 84
boolean bringtotop = true
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
end type

