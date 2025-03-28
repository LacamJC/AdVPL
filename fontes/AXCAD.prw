#include 'protheus.ch'

User Function AXCAD()

	Local aArea     := GetArea()
	Local aAreaA1   := JRC->(GetArea())

	AxCadastro('JRC', 'Tabela - JRC - Teste', 'U_AXSET("Deletar")','U_AXSET("Alterar")')

	RestArea(aAreaA1)
	RestArea(aArea)
return

User Function AXSET(cFra)
	Local lRet := .T.

	if MsgYesNo("O usuario pode " + cFra)
		lRet := .T.
	else
		lRet := .F.
	endIf

return lRet
