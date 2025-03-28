#include "Protheus.ch"
#include 'parmtype.ch'
/*/

Exemplo de primeiro programa em ADVPL


@author Jo√£o ramajo
@since 15/03/2025

/*/

User function TesteTI()
	Local aPegs := {}
	Local aResp := {}
	Local cNome := 2

	aAdd(aPegs, {1, "Digite seu nome", cNome, "", "", "" ,"", 0, .T.})

	if Parambox(aPegs, "Soma", aResp)
		Alert("Ol· " + aResp[1])
	Endif

	Alert("Teste")
Return


User Function SRMA()
	Local aPegs := {}
	Local aResp := {}
	Local cNome := ''

	aAdd(aPegs, {1, "Digite seu nome", cNome, "", "", "" ,"", 0, .T.})

	if Parambox(aPegs, "Soma", aResp)
		Alert("Ol· " + aResp[1])
	Endif

	Alert("Teste")
return 

