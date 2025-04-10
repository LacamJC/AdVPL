#INCLUDE "Protheus.ch"
#INCLUDE "FWMVCDEF.CH"


User Function BRWSZ9()
	Local aArea      := GetNextAlias()
	Local oBrowseJRC

	oBrowseJRC := FwmBrowse():New()
    oBrowseJRC:SetMenuDef('BRWSZ9')

	oBrowseJRC:SetAlias('JRC')
	oBrowseJRC:SetDescription('Tabela de cadastro')
	oBrowseJRC:Activate()

	RestArea(aArea)
return


Static Function ModelDef()
	Local oStruJRC := FwFormStruct(1, 'JRC') // Variaevel da estrutura da tabela JRC - Tabela personalizada
	Local oModel

	oModel := MpFormModel():New('MCBRWSZ9')
	oModel:AddFields('JRCMASTER', , oStruJRC)
	oModel:SetDescription('Modelo de dados de cadastro')
	oModel:GetModel( 'JRCMASTER' ):SetDescription( 'Dados de cadastro' )

return oModel


Static Function ViewDef()

	Local oModel     := FWLoadModel('BRWSZ9')// <- Mesmo nome do arquivo
	Local oStructJRC := FWFormStruct( 2, 'JRC')
	Local oView

	oView := FWFormView():New()
	oView:SetModel( oModel )
	oView:AddField( 'VIEW_JRC' , oStructJRC, 'JRCMASTER' )
    oModel:SetPrimaryKey({})
	oView:CreateHorizontalBox( 'TELA', 100) // <- Cria um container com 100% do espaço
	oView:SetOwnerView( 'VIEW_JRC', 'TELA')

return oView

Static Function MenuDef()

	Local aRotina := {}

	Add Option aRotina Title "Incluir"      Action "ViewDef.BRWSZ9" Operation 3 Access 0
	Add Option aRotina Title "Alterar"      Action "ViewDef.BRWSZ9" Operation 4 Access 0
	Add Option aRotina Title "Visualizar"   Action "ViewDef.BRWSZ9" Operation 2 Access 0
	Add Option aRotina Title "Excluir"      Action "ViewDef.BRWSZ9" Operation 5 Access 0
	Add Option aRotina Title "Imprimir"     Action "ViewDef.BRWSZ9" Operation 8 Access 0
	Add Option aRotina Title "Copiar"       Action "ViewDef.BRWSZ9" Operation 9 Access 0
    Add Option aRotina Title "Teste"        Action "U_AXJC()"       Operation 6 Access 0
Return aRotina

User Function AXJC()
    Alert("TEste")
return 
