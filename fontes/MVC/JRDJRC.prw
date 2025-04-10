#include "PROTHEUS.CH"
#Include "FWMVCDEF.CH"
#include "TBICONN.CH"
#include "TOPCONN.CH"
#INCLUDE "MSOLE.CH"

User Function JRDJRC()

	Local aArea     := GetArea()
	Local oBrowse   := FwMBrowse():New()

	oBrowse:SetAlias('JRC')
	oBrowse:SetMenuDef('JRDJRC')
	oBrowse:SetDescription('JRC - JRC Controle de projetos por responsavel')

	oBrowse:Activate()

	RestArea(aArea)

return()

Static Function MenuDef()

	Local aRotina := {}

	ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.JRDJRC' OPERATION 2 ACCESS 0
	ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.JRDJRC' OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.JRDJRC' OPERATION 4 ACCESS 0
	ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.JRDJRC' OPERATION 5 ACCESS 0
	ADD OPTION aRotina TITLE 'Imprimir'   ACTION 'VIEWDEF.JRDJRC' OPERATION 8 ACCESS 0

Return aRotina

Static Function ModelDef()

	Local oModel    := NIL
	Local oStPai    := FWFormStruct(1, 'JRC')
	Local oStFilho  := FWFormStruct(1, 'JRC')

	oModel:= MpFormModel():New('JRDJRCM')
	oModel:AddFields('PAI_JRDJRC',   , oStPai)
	oModel:AddGrid('FILHO_JRDJRC', 'PAI_JRDJRC', oStFilho)

	oModel:SetRelation('FILHO_JRDJRC', {{'JRC_FILIAL', 'JRD_FILIAL'}})

	oModel:GetModel('FILHO_JRDJRC'):SetOptional(.T.)

	oModel:SetPrimaryKey({'JRC_FILIAL', 'JRC_COD'})

	oModel:SetDescription('JRD JRC - Controle de responsaveis')

	oModel:GetModel('PAI_JRDJRC'):SetDescription('Dados dos responsaveis')
	oModel:GetModel('FILHO_JRDJRC'):SetDescription('Dados dos projetos')

return oModel

Static Function ViewDef()

	Local oView
	Local oModel        := FWLoadModel('JRDJRC')
	Local oStPai        := FWFormStruct(2, 'JRC')
	Local oStFilho      := FWFormStruct(2, 'JRD')

	oView := FWFormView():New()
	oView:SetModel(oModel)

	oView:AddField('VIEW_PAI', oStPai, 'PAI_JRDJRC')
	oView:AddGrid('VIEW_FILHO', oStFilho, 'FILHO_JRDJRC')

	oView:CreateHorizontalBox('CABEC', 80)
	oView:CreateHorizontalBox('GRID', 20)


	oView:SetOwnerView('VIEW_PAI', 'CABEC')
	oView:SetOwnerView('VIEW_FILHO', 'GRID')

Return oView
