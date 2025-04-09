#include 'protheus.ch'
#include 'fwmvcdef.ch'

User Function MVC002()

	Local oBrowse 	:= FWBrowse():New()

	oBrowse:SetAlias('JRD')
	oBrowse:SetDescription('Controle de projetos')
	oBrowse:Activate()

return


Static Function ModelDef()

	Local oStructJRD	:=	FWFormStruct(1, 'JRD')
	Local oStructJRC	:=  FWFormStruct(1, 'JRC')
	Local aRelation		:=  {}
	Local oModel

	oModel := MPFormModel():New("MVC002M")
	oModel:AddFields('JRDMASTER', , oStructJRD)
	oModel:AddGrid('JRCDETAIL', 'JRDMASTER', oStructJRC)

	aAdd(aRelation, {'JRC_FILIAl', 'xFilial("JRC")'})
	aAdd(aRelation, {'JRC_CODIGO', 'JRD_CODIGO'})

	oModel:SetRelation('JRCDETAIL', aRelation, JRC->(IndexKey(1)))
	oModel:SetDescription('Manutenção da carteira de projetos')
	oModel:GetModel('JRCDETAIL'):SetUniqueLine({'JRC_CODIGO', 'JRD_CODIGO'})
	oModel:GetModel('JRCDETAIL'):SetOptional(.T.)
	oModel:GetModel('JRCDETAIL'):SetMaxLine(1000)
Return oModel


Static Function ViewDef()

	Local oModel		:= FWLoadModel('MVC002')
	Local oStructJRD	:= FWFormStruct(2, 'JRD')
	Local oStructJRC	:= FWFormStruct(2, 'JRC')

	oView	:= FWFormView():New()
	oView:SetModel( oModel )
	oView:AddField('VIEW_JRD', oStructJRD, 'JRDMASTER')
	oView:AddGrid('VIEW_JRC', oStructJRC, 'JRCDETAIL')
	oView:CreateHorizontalBox('CABEC', 30)
	oView:CreateHorizontalBox('GRID', 70)
	oView:SetOwnerView('VIEW_JRD', 'CABEC')
	oView:SetOwnerView('VIEW_JRC', 'GRID')
	oView:SetViewProperty('VIEW_JRC', 'GRIDSEEK', {.T.})


	oStructJRC:RemoveField("JRC_CODIGO")
return oView


Static Function MenuDef()

	Local aRotina := {}

	ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.MVC002' OPERATION 2 ACCESS 0
	ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.MVC002' OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.MVC002' OPERATION 4 ACCESS 0
	ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.MVC002' OPERATION 5 ACCESS 0

Return aRotina
