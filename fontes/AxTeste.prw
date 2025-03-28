#include 'protheus.ch'

User Function AxTeste()
    Local aArea      := GetArea()
    Local aAreaB1    := JRC ->(GetArea())
    Local cDelOk     := ".T."
    Local cFunTOk    := ".T."


	AxCadastro("JRC", "Produtos - Teste", "Validacao de Exclusao", cDelOk, cFunTOk)

    RestArea(aAreaB1)
    RestArea(aArea)
return
