#include 'Protheus.ch'
#include 'fwmvcdef.ch'



User Function MVCTST()
	Local aArea    := GetArea()
	Private oBrowse:= FwMBrowse():New()

	oBrowse:SetAlias('SB1')
	oBrowse:SetMenuDef('MVCTST')
	oBrowse:SetDescription('Cadastro de produtos')
	oBrowse:DisableDetails()
	oBrowse:Activate()

	RestArea(aArea)
return

Static Function MenuDef()
	Local aRotina := {}

	ADD OPTION aRotina TITLE 'Visualizar' ACTION 'ViewDef.MVCTST' OPERATION 2 ACCESS 0
	ADD OPTION aRotina TITLE 'Incluir'    ACTION 'ViewDef.MVCTST' OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE 'Alterar'    ACTION 'ViewDef.MVCTST' OPERATION 4 ACCESS 0
	ADD OPTION aRotina TITLE 'Excluir'    ACTION 'ViewDef.MVCTST' OPERATION 5 ACCESS 0
	ADD OPTION aRotina TITLE 'Nova Rotina'ACTION 'U_FUNCTST()'    OPERATION 6 ACCESS 0


Return aRotina



Static Function ModelDef()
	Local oModel := NIL
	Local oSTPai := FWFormStruct(1, 'SB1',,)

	oModel := MpFormModel():New('MDMVCTST', , {|oModel| TudoOK(oModel)}, ,)
	oModel:AddFields('PAI_MVCTST', , oSTPai, , , )

	oModel:SetPrimaryKey({})

	oModel:SetDescription('Cadastro de produtos')
	oModel:GetModel('PAI_MVCTST'):SetDescription('Dados do produto')


	oModel:SetVldActive({|oModel| fAlterar(oModel)})

Return oModel

Static Function ViewDef()
	Local oView := Nil
	Local oModel:= FwLoadModel('MVCTST')
	Local oSTPai := FwFormStruct(2, 'SB1')

	oView := FWFormView():New()
	oView:SetModel(oModel)
	oView:AddField('PAI_VIEW', oSTPai, "PAI_MVCTST")
	oView:CreateHorizontalBox('CABEC', 100)
	oView:setOwnerView('PAI_VIEW', 'CABEC')
	oView:EnableTitleView('PAI_VIEW', 'Dados do produto')
	oView:SetCloseOnOk({|| .T.})


Return oView

User Function FUNCTST()
	MsgAlert('Teste de função', 'Apenas um teste de função')
return



// V�lida os campos antes de salvar
Static Function TudoOK(oModel)
	Local nOpc := oModel:GetOperation() // opc -> Operea��o (Operation)
	Local oMdLPai := oModel:GetModel('PAI_MVCTST') // <- Buscando o sub modelo dentro de o model
	Local lRet := .T.

	if nOpc == 3 // <- Opera��o de inclur
		if Empty(AllTrim(oMdLPai:GetValue('B1_COD'))) // <- Buscando o campo especificado para maiores valida��es
			MsgAlert('Voce n�o digitou o campo', 'Aten��o aos campos')
			lRet := .F.

			lRet := VldDados(oModel)
		EndIf
	EndIf

	if nOpc == 4 // <- Opera��o de altera��o

	EndIf

	if nOpc == 5 // <- Opera��o de inclus�o

	EndIf

Return lRet

// Valida��o antes de entrar na tela de cadastro enquanto voc� est� no browse
Static Function fAlterar(oModel)
  Local lRet  := .T. 
  Local aArea := GetArea()
  Local nOpc  := oModel:GetOperation()
  
  if nOpc == 3 
  
  EndIf

  if nOpc ==  5 
    oMdlPai := oModel:GetModel('PAI_MVCTST'):GetValue('B1_COD')
  EndIf 

  RestArea(aArea)
Return lRet
 
 // Valida��o ao clicar em salvar as altera��es da tela de cadastro
Static Function VldDados(oModel)
	Local lRet        := .T.
	Local oModelSB1   := oModel:GetModel('PAI_MVCTST')

	if Empty(AllTrim(oModelSB1:GetValue('B1_COD')))
		MsgAlert('N�o digitou o campo do codigo', 'Aten��o')
		lRet := .F.
	EndIf
Return lRet
