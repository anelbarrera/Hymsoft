//objectcomments Ventana para verificar los pedidos vs las listas de empaques
forward
global type w_fa_rep_imp_pedid_vs_emp from w_fa_padre_reportes
end type
end forward

global type w_fa_rep_imp_pedid_vs_emp from w_fa_padre_reportes
int Width=2551
int Height=1240
boolean TitleBar=true
string Title="Informe de Verificación"
string MenuName="m_fa_rep"
end type
global w_fa_rep_imp_pedid_vs_emp w_fa_rep_imp_pedid_vs_emp

type variables
string is_pedi,is_lis_emp,is_uni_vent
long il_pedi_anno
integer ii_por_my
str_fa_pedfac_vs_imp ilstr_pedfac
end variables

forward prototypes
public subroutine wf_set_valor (readonly integer asi_financiero, readonly integer asi_empresa, readonly string ass_ped_fac, readonly integer asi_anno, readonly string asi_pormy, readonly boolean asb_tipo)
end prototypes

public subroutine wf_set_valor (readonly integer asi_financiero, readonly integer asi_empresa, readonly string ass_ped_fac, readonly integer asi_anno, readonly string asi_pormy, readonly boolean asb_tipo);string ls_descrip, ls_empaq,ls_pedid, ls_lista_pedi , ls_empre
long ll_tercer,ll_ano_emp,ll_ano_pedid

If asb_tipo Then
   SELECT dgmterce.terc_tercero,   
         dgmterce.terc_descripcion,   
         fatempaq.enca_lista_empaque,   
         fatempaq.enca_ann,   
         fatpedid.pedi_no_pedido,   
         fatpedid.pedi_ann  
    INTO :ll_tercer,   
         :ls_descrip,   
         :ls_empaq,   
         :ll_ano_emp,   
         :ls_pedid,   
         :ll_ano_pedid  
    FROM dgmterce,   
         fatempaq,   
         fatpedid  
   WHERE ( fatpedid.pedi_cliente = dgmterce.terc_tercero ) and  
         ( fatempaq.enca_g_financiero = fatpedid.pedi_g_financiero ) and  
         ( fatempaq.enca_empresa = fatpedid.pedi_empresa ) and  
         ( fatempaq.enca_no_pedido = fatpedid.pedi_no_pedido ) and  
         ( fatempaq.enca_ann_pedido = fatpedid.pedi_ann ) and  
         ( fatempaq.enca_tipo = fatpedid.pedi_tipo ) AND
         ( ( fatpedid.pedi_g_financiero = :asi_financiero ) AND  
         ( fatpedid.pedi_empresa = :asi_empresa ) AND  
         ( fatpedid.pedi_no_pedido = :ass_ped_fac ) AND  
         ( fatpedid.pedi_ann = :asi_anno ) AND  
         ( fatpedid.pedi_tipo = :asi_pormy )) ;
Else
	
	  SELECT dgmterce.terc_tercero,   
         dgmterce.terc_descripcion,   
         fatempaq.enca_lista_empaque,   
         fatempaq.enca_ann,   
         fatdiari.fact_no_pedido,   
         fatdiari.fact_ann  
    INTO :ll_tercer,   
         :ls_descrip,   
         :ls_empaq,   
         :ll_ano_emp,   
         :ls_pedid,   
         :ll_ano_pedid  
    FROM fatdiari,   
         dgmterce,   
         fatempaq  
   WHERE ( dgmterce.terc_tercero = fatdiari.fact_cliente ) and  
         ( fatempaq.enca_g_financiero = fatdiari.fact_g_financiero ) and  
         ( fatempaq.enca_empresa = fatdiari.fact_empresa ) and  
         ( fatempaq.enca_no_pedido = fatdiari.fact_no_pedido ) and  
         ( fatempaq.enca_tipo = fatdiari.fact_tipo ) and  
         ( fatempaq.enca_ann_pedido = fatdiari.fact_ann ) and  
         ( ( fatdiari.fact_g_financiero = :asi_financiero ) AND  
         ( fatdiari.fact_empresa = :asi_empresa ) AND  
         ( fatdiari.fact_no_pedido = :ass_ped_fac ) AND  
         ( fatdiari.fact_ann = :asi_anno ) AND  
         ( fatdiari.fact_tipo = :asi_pormy))   ;
End If



dw.Object.datawindow.print.preview = true
dw.retrieve(str.g_financiero,str.empresa,ls_pedid,ll_ano_pedid)

dw.object.cliente.expression = "'("+string(ll_tercer)+") "+ls_descrip+&
										 "~n ~n Lista de Empaque "+ls_empaq+"/"+string(ll_ano_emp)+&
										 "  del pedido "+ls_pedid+"/"+string(ll_ano_pedid)+"'"
ls_empre = gf_dg_nombre_empresa()										 
dw.object.empresanom.expression = "'"+ls_empre+"'"




end subroutine

on w_fa_rep_imp_pedid_vs_emp.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_fa_rep" then this.MenuID = create m_fa_rep
end on

on w_fa_rep_imp_pedid_vs_emp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_post_open;//Override
/* dw corresponde al datawindows que se desea imprimir, por tanto
   si desea asignarle otro nombre haga lo siguiente 
	dw = otro_nombre */
dw = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()


//ll_pos = Pos(ilstr_pedfac.cadena,"%")
//is_pedi = Mid(ilstr_pedfac.cadena,1,ll_pos - 1)
//ls_cadena2 = mid(ilstr_pedfac.cadena,ll_pos+1, len(ilstr_pedfac.cadena))
//il_pedi_anno = long(Mid(ls_cadena2,1,Pos(ls_cadena2,"%")-1))
//
//ls_cadena3 =  mid(ls_cadena2,Pos(ls_cadena2,"%")+1, len(ls_cadena2))
//
//ii_por_my = integer(Mid(ls_cadena3,1,Pos(ls_cadena3,"%")-1))
//
//is_lis_emp = mid(ls_cadena3,Pos(ls_cadena3,"%")+1,len(ls_cadena3))

ilstr_pedfac = Message.PowerObjectParm

If ilstr_pedfac.reportes <= 0 then return

If ilstr_pedfac.por_tipo = true  then
	
	is_uni_vent = "fadpedid_dped_unidad_venta"

	IF ilstr_pedfac.reportes = 1 then
		dw.Dataobject = "dw_fa_inf_res_pedvsemp"
		dw.SettransObject(sqlca)
	ElseIf ilstr_pedfac.reportes = 2 Then
		dw.DataObject = "dw_fa_inf_det_pedvsemp"
		dw.SettransObject(sqlca)
	Else
		dw.DataObject = "dw_fa_inf_desg_pedido"
		dw.SettransObject(sqlca)
		wf_set_valor(str.g_financiero,str.empresa, &
			ilstr_pedfac.codigo,ilstr_pedfac.anno,ilstr_pedfac.tipo,ilstr_pedfac.por_tipo)
	End If
	
Else

	is_uni_vent = "faddiari_facd_unidad_venta"
	
	IF ilstr_pedfac.reportes = 1 then
		dw.Dataobject = "dw_fa_inf_res_fact_vs_listemp"
		dw.SettransObject(sqlca)
	ElseIf ilstr_pedfac.reportes = 2 then
		dw.DataObject = "dw_fa_inf_det_fact_vs_listemp"
		dw.SettransObject(sqlca)	
	Else
		dw.DataObject = "dw_fa_inf_desgloce_fact"
		dw.SettransObject(sqlca)
		wf_set_valor(str.g_financiero,str.empresa, &
			ilstr_pedfac.codigo,ilstr_pedfac.anno,ilstr_pedfac.tipo,ilstr_pedfac.por_tipo)
	End If
End IF

//messagebox("",ilstr_pedfac.codigo+"/"+string(ilstr_pedfac.anno)+"/"+ &
//				string(ilstr_pedfac.tipo)+"/"+ilstr_pedfac.codempaq)

If ilstr_pedfac.reportes <> 3 then
	dw.Object.datawindow.print.preview = true
	dw.retrieve(str.g_financiero,str.empresa,ilstr_pedfac.codigo,ilstr_pedfac.anno, &
					ilstr_pedfac.tipo,ilstr_pedfac.codempaq)
	dw.object.empresanom.expression = "'"+gf_dg_nombre_empresa()+"'"
End If
end event

event open;call super::open;//ilstr_pedfac = Message.PowerObjectParm
//
//If ilstr_pedfac.reportes <= 0 then return
//
//If ilstr_pedfac.por_tipo = true  then
//	
//	is_uni_vent = "fadpedid_dped_unidad_venta"
//
//	IF ilstr_pedfac.reportes = 1 then
//		dw.Dataobject = "dw_fa_inf_res_pedvsemp"
//		dw.SettransObject(sqlca)
//	ElseIf ilstr_pedfac.reportes = 2 Then
//		dw.DataObject = "dw_fa_inf_det_pedvsemp"
//		dw.SettransObject(sqlca)
//	Else
//		dw.DataObject = "dw_fa_inf_desg_pedido"
//		dw.SettransObject(sqlca)
//		wf_set_valor(str.g_financiero,str.empresa, &
//			ilstr_pedfac.codigo,ilstr_pedfac.anno,ilstr_pedfac.pormy,ilstr_pedfac.por_tipo)
//	End If
//	
//Else
//
//	is_uni_vent = "faddiari_facd_unidad_venta"
//	
//	IF ilstr_pedfac.reportes = 1 then
//		dw.Dataobject = "dw_fa_inf_res_fact_vs_listemp"
//		dw.SettransObject(sqlca)
//	ElseIf ilstr_pedfac.reportes = 2 then
//		dw.DataObject = "dw_fa_inf_det_fact_vs_listemp"
//		dw.SettransObject(sqlca)		
//	End If
//End IF
//
////messagebox("",ilstr_pedfac.codigo+"/"+string(ilstr_pedfac.anno)+"/"+ &
////				string(ilstr_pedfac.pormy)+"/"+ilstr_pedfac.codempaq)
//
//If ilstr_pedfac.reportes <> 3 then
//	dw.Object.datawindow.print.preview = true
//	dw.retrieve(str.g_financiero,str.empresa,ilstr_pedfac.codigo,ilstr_pedfac.anno, &
//					ilstr_pedfac.pormy,ilstr_pedfac.codempaq)
//	dw.object.empresanom.expression = "'"+gf_dg_nombre_empresa()+"'"
//End If
end event

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_rep_imp_pedid_vs_emp
int TabOrder=10
boolean HScrollBar=true
boolean VScrollBar=true
end type

event dw_1::retrieveend;//

long 		ll_i, ll_cant_asig, ll_cant_uni, ll_cant_noasig, ll_cant_asignada, 	ld_cant_frac
string 	ls_uni_venta, ls_aprobado, ls_recolecta, ls_nombre, ls_apellido,ls_nombre_rec,&
			ls_apellido_rec
			
If rowcount < 1 then return

parent.SetRedraw(false)

If ilstr_pedfac.reportes <> 3 then
	
		For ll_i = 1 to rowcount
			ll_cant_asig = dw.GetItemNumber(ll_i,"asigna")
		
			ls_uni_venta =	dw.GetItemString(ll_i,is_uni_vent)
			gf_fa_convertuni_new(ls_uni_venta,ll_cant_asig,ll_cant_uni,ld_cant_frac)	
		
			dw.SetItem(ll_i,"asignado",string(ll_cant_uni)+"."+string(ld_cant_frac))
			
			ll_cant_noasig = dw.GetItemNumber(ll_i,"noasigna")
			ll_cant_uni = 0
			ld_cant_frac = 0
			gf_fa_convertuni_new(ls_uni_venta, ll_cant_noasig,ll_cant_uni,ld_cant_frac)
		
			dw.SetItem(ll_i,"noasignado",string(ll_cant_uni)+"."+string(ld_cant_frac))
			If ilstr_pedfac.reportes = 2 then
				ll_cant_asignada = dw.GetItemNumber(ll_i,"fadempaq_empa_cantidad")
				ll_cant_uni = 0
				ld_cant_frac = 0
				gf_fa_convertuni_new(ls_uni_venta,ll_cant_asignada,ll_cant_uni,ld_cant_frac)
				
				dw.SetItem(ll_i,"cantidad",string(ll_cant_uni)+"."+string(ld_cant_frac))
			End IF
		Next
		
		
			ls_aprobado = dw.getitemString(rowcount,"fatempaq_enca_autorizado_por")
			ls_recolecta = dw.GetItemString(rowcount,"fatempaq_enca_recolector")
			
			  SELECT faempbod.faem_nombre,   
						faempbod.faem_apellido  
				 INTO :ls_nombre,   
						:ls_apellido
				 FROM faempbod  
				WHERE ( faempbod.faem_g_financiero = :str.g_financiero ) AND  
						( faempbod.faem_empresa = :str.empresa ) AND  
						( faempbod.faem_bod_usuario = :ls_aprobado )   ;
						
				SELECT faempbod.faem_nombre,   
						faempbod.faem_apellido  
				 INTO :ls_nombre_rec,   
						:ls_apellido_rec
				 FROM faempbod  
				WHERE ( faempbod.faem_g_financiero = :str.g_financiero ) AND  
						( faempbod.faem_empresa = :str.empresa ) AND  
						( faempbod.faem_bod_usuario = :ls_recolecta )   ;		
			
			dw.SetItem(rowcount,"aprobado",ls_nombre+" "+ls_apellido)
			dw.SetItem(rowcount,"recolectado",ls_nombre_rec+" "+ls_apellido_rec)
		parent.SetRedraw(true)
		
		
		If Not ilstr_pedfac.asignado Then
			dw.SetFilter("asigna <> unimin")
			dw.filter()
		End If	

End If
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_rep_imp_pedid_vs_emp
int TabOrder=20
end type

