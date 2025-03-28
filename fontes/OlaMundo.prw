#include 'protheus.ch'
#include 'parmtype.ch'
user function OlaMundo()

	Alert("Olá mundo")


return


user function SomaDois()
	Local aResp := {}
	Local aPegs := {}
	Local nA := 0
	Local nB := 0
	Local nResultado := 0

	aAdd(aPegs, {1,"Digite o primeiro valor", nA, "", "", "", "", 0, .T.})
	aAdd(aPegs, {1,"Digite o primeiro valor", nB, "", "", "", "", 0, .T.})


	If Parambox(aPegs, "Soma", aResp)
		nResultado := aResp[1] + aResp[2]

		Alert("O resultado foi: " + nResultado)

	Else
		Alert("Processo cancelado")
	Endif
return
