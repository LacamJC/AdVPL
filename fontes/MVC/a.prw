#INCLUDE "Protheus.ch"
#INCLUDE "FWMVCDEF.CH"
#INCLUDE 'FILEIO.CH'
#Include "TopConn.ch"

/*
¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨
¨    FUNCAO.:  CADZZJ                           ||   AUTOR: ROGERIO MACHADO - TOTVS IBIRAPUERA     ¨
¨    DESCRI.:  CADASTRO DE CAIXA                ||                                                 ¨
¨    DATA...:  04/10/2019                       ||                                                 ¨
¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨
*/
User Function CADZZJ()

	Local aArea     := GetArea()
	Private oBrowse := FwMBrowse():New()


	oBrowse:SetAlias('ZZJ')
	oBrowse:SetMenudef('CADZZJ')

	//Descrição da Parte Superior Esquerda do Browse
	oBrowse:SetDescripton("Cadastro de Caixa")

	//Desabilita os Detalhes da parte inferior do Browse
	oBrowse:DisableDetails()

	//Ativa o Browse
	oBrowse:Activate()

	RestArea(aArea)

Return()


/*
¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨
¨    FUNCAO:  MenuDef                          ||   AUTOR: ROGERIO MACHADO - TOTVS IBIRAPUERA      ¨
¨    DESCRI.:                                  ||                                                  ¨
¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨
*/
Static Function MenuDef()

	Local aRotina := {}
	Add Option aRotina Title "Visualizar"   Action "ViewDef.CADZZJ" Operation OP_VISUALIZAR Access 0
	Add Option aRotina Title "Incluir"      Action "ViewDef.CADZZJ" Operation OP_INCLUIR Access 0
	Add Option aRotina Title "Alterar"      Action "ViewDef.CADZZJ" Operation OP_ALTERAR Access 0
	Add Option aRotina Title "Excluir"      Action "ViewDef.CADZZJ" Operation OP_EXCLUIR Access 0


Return aRotina


/*
¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨
¨    FUNCAO:  ModelDef                         ||   AUTOR: ROGERIO MACHADO - TOTVS IBIRAPUERA      ¨
¨    DESCRI.:                                  ||                                                  ¨
¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨
*/
Static Function ModelDef()

	Local oModel    := Nil
	Local oStPai    := FWFormStruct(1,'ZZJ', /*bAvalCampo*/, /*lViewUsado*/) //Retorna a Estrutura do Alias passado como Parametro (1=Model,2=View)

	//Instancia do Objeto de Modelo de Dados
	oModel := MpFormModel():New('MDCADZZJ',,{|oModel| TudoOK(oModel)},)
	oModel:AddFields('PAI_CADZZJ', /*cOwner*/  , oStPai)

	oModel:SetPrimaryKey({})

	//Setando as descrições
	oModel:SetDescription("Cadastro de Caixa")
	oModel:GetModel('PAI_CADZZJ'):SetDescription('Cadastro de Caixa')

	oModel:SetVldActive( { | oModel | fAlterar( oModel ) } )

Return(oModel)



/*
¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨
¨    FUNCAO:  ViewDef                          ||   AUTOR: ROGERIO MACHADO - TOTVS IBIRAPUERA      ¨
¨    DESCRI.:                                  ||                                                  ¨
¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨
*/
Static Function ViewDef()

	Local oView         := Nil
	Local oModel        := FWLoadModel('CADZZJ')
	Local oStPai        := FWFormStruct(2, 'ZZJ')


	//Criando a View
	oView := FWFormView():New()
	oView:SetModel(oModel)


	//Adicionando os campos do cabeçalho e o grid dos filhos
	oView:AddField('VIEW_PAI',oStPai,'PAI_CADZZJ')



	//Setando o dimensionamento de tamanho
	oView:CreateHorizontalBox('CABEC',100)

	//Amarrando a view com as box
	oView:SetOwnerView('VIEW_PAI','CABEC')

	oView:EnableTitleView('VIEW_PAI' , 'Login Senha Customizados' )

	//Habilitando título
	oView:SetCloseOnOk({ || .T. })

Return oView
