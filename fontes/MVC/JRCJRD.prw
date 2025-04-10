#include "PROTHEUS.CH"
#Include "FWMVCDEF.CH"
#include "TBICONN.CH"
#include "TOPCONN.CH"
#INCLUDE "MSOLE.CH"

User Function JRCJRD()

	Local aArea         := GetArea()
	Local oBrowse       := FwMBrowse():New()

	oBrowse:SetAlias('JRD')
	oBrowse:SetMenuDef('JRCJRD')
	oBrowse:SetDescription("JRC - JRD - Tabelas MVC 2")

    oBrowse:AddLegend("JRD_STATUS=='1'", "GREEN", "Em Andamento")
    oBrowse:AddLegend("JRD_STATUS=='2'", "BLUE", "Finalizado")
    oBrowse:AddLegend("JRD_STATUS=='3'", "GRAY", "Cancelado")

	oBrowse:Activate()

	RestArea(aArea)

return()

	Static Function MenuDef()

		Local aRotina := {}

		ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.JRCJRD' OPERATION 2 ACCESS 0
		ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.JRCJRD' OPERATION 3 ACCESS 0
		ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.JRCJRD' OPERATION 4 ACCESS 0
		ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.JRCJRD' OPERATION 5 ACCESS 0
		ADD OPTION aRotina TITLE 'Teste'      ACTION 'U_JRC_ALERT()'  OPERATION 5 ACCESS 0
		ADD OPTION aRotina TITLE 'Imprimir'   ACTION 'VIEWDEF.JRCJRD' OPERATION 8 ACCESS 0

	Return aRotina


Static Function ModelDef()
	Local oModel    := Nil
	Local oStPai    := FWFormStruct(1, 'JRD')
	Local oStFilho  := FWFormStruct(1, 'JRC')

	oModel          := MpFormModel():New('JRCJRDM')
	oModel:AddFields('PAI_JRCJRD', , oStPai)
	oModel:AddGrid('FILHO_JRCJRD', 'PAI_JRCJRD', oStFilho)

	oModel:SetRelation('FILHO_JRCJRD', {{'JRC_FILIAL', 'JRD_FILIAL'}, {'JRC_CODIGO', 'JRD_CODIGO'}})

	oModel:GetModel('FILHO_JRCJRD'):SetOptional(.T.)

	oModel:SetPrimaryKey({ 'JRD_FILIAL', 'JRD_COD'})

	oModel:SetDescription("JRC JRD - Cadastro")
	oModel:GetModel('PAI_JRCJRD'):SetDescription('Dados dos projetos')
	oModel:GetModel('FILHO_JRCJRD'):SetDescription('Dados dos usuarios')

return oModel

Static Function ViewDef()

	Local oView
	Local oModel        :=  FWLoadModel("JRCJRD")
	Local oStPai        :=  FWFormStruct(2, 'JRD')
	Local oStFilho      :=  FWFormStruct(2, 'JRC')

	oView := FWFormView():New()
	oView:SetModel(oModel)
	U_JRC_ALERT()

	oView:AddField('VIEW_PAI', oStPai, 'PAI_JRCJRD')
	oView:AddGrid('VIEW_FILHO', oStFilho, 'FILHO_JRCJRD')

	oView:CreateHorizontalBox('CABEC', 70)
	oView:CreateHorizontalBox('GRID', 30)

	oView:SetOwnerView('VIEW_PAI', 'CABEC')
	oView:SetOwnerView('VIEW_FILHO', 'GRID')

Return oView

User Function JRC_ALERT()
	Alert("SIM")
return
