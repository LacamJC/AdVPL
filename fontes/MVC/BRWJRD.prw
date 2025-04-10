#include 'protheus.ch'
#include 'fwmvcdef.ch'

User Function BRWJRD()

    Local aArea     := GetArea()
    Local oBrowse   := FwMBrowse():New()

    oBrowse:SetMenuDef('BRWJRD')

    oBrowse:SetAlias('JRD')
    oBrowse:SetDescription('Tabela de projetos')
    oBrowse:Activate()

    RestArea(aArea)

return 

Static Function ModelDef()

    Local oStruJRD := FwFormStruct(1, 'JRD')
    Local oModel 

    oModel := MpFormModel():New('MCBRWJRD')
    oModel:AddFields('JRDMASTER', , oStruJRD)
    oModel:SetDescription('Modelo de projetos')
    oModel:GetModel('JRDMASTER'):SetDescription('Dados de projetos')
return oModel


Static Function ViewDef()
    
    Local oModel        := FWLoadModel('BRWJRD')
    Local oStructJRD    := FWFormStruct(2, 'JRD')
    Local oView 

    oView := FWFormView():New()
    oView:SetModel(oModel)
    oView:AddField('VIEW_JRD', oStructJRD, 'JRDMASTER')
    oModel:SetPrimaryKey({})
    oView:CreateHorizontalBox('TELA', 100)
    oView:SetOwnerView('VIEW_JRD', 'TELA')

return oView 

Static Function MenuDef()

	Local aRotina := {}

	Add Option aRotina Title "Incluir"      Action "ViewDef.BRWJRD" Operation 3 Access 0
	Add Option aRotina Title "Alterar"      Action "ViewDef.BRWJRD" Operation 4 Access 0
	Add Option aRotina Title "Visualizar"   Action "ViewDef.BRWJRD" Operation 2 Access 0
	Add Option aRotina Title "Excluir"      Action "ViewDef.BRWJRD" Operation 5 Access 0
	Add Option aRotina Title "Imprimir"     Action "ViewDef.BRWJRD" Operation 8 Access 0
	Add Option aRotina Title "Copiar"       Action "ViewDef.BRWJRD" Operation 9 Access 0
   
Return aRotina

