//Bibliotecas
#Include "Protheus.ch"

/*/{Protheus.doc} zMiniForm
FunÃ§Ã£o Mini FÃ³rmulas, para executar fÃ³rmulas
@author Atilio
@since 17/12/2017
@version 1.0
@type function
@obs Assim como o fÃ³rmulas foi bloqueado no Protheus 12, cuidado ao deixar exposto no menu o Mini FÃ³rmulas
/*/

User Function zMiniForm()
	Local aArea := GetArea()
	//VariÃ¡veis da tela
	Private oDlgForm
	Private oGrpForm
	Private oGetForm
	Private cGetForm := Space(250)
	Private oGrpAco
	Private oBtnExec
	//Tamanho da Janela
	Private nJanLarg := 500
	Private nJanAltu := 120
	Private nJanMeio := ((nJanLarg)/2)/2
	Private nTamBtn  := 048

	//Criando a janela
	DEFINE MSDIALOG oDlgForm TITLE "zMiniForm - ExecuÃ§Ã£o de FÃ³rmulas" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
	//Grupo FÃ³rmula com o Get
	@ 003, 003  GROUP oGrpForm TO 30, (nJanLarg/2)-1        PROMPT "FÃ³rmula: " OF oDlgForm COLOR 0, 16777215 PIXEL
	@ 010, 006  MSGET oGetForm VAR cGetForm SIZE (nJanLarg/2)-9, 013 OF oDlgForm COLORS 0, 16777215 PIXEL

	//Grupo AÃ§Ãµes com o BotÃ£o
	@ (nJanAltu/2)-30, 003 GROUP oGrpAco TO (nJanAltu/2)-3, (nJanLarg/2)-1 PROMPT "AÃ§Ãµes: " OF oDlgForm COLOR 0, 16777215 PIXEL
	@ (nJanAltu/2)-24, nJanMeio - (nTamBtn/2) BUTTON oBtnExec PROMPT "Executar" SIZE nTamBtn, 018 OF oDlgForm ACTION(fExecuta()) PIXEL

	//Ativando a janela
	ACTIVATE MSDIALOG oDlgForm CENTERED

	RestArea(aArea)
Return

/*---------------------------------------*
 | Func.: fExecuta                       |
 | Desc.: Executa a fÃ³rmula digitada     |
 *---------------------------------------*/
 
Static Function fExecuta()
    Local aArea    := GetArea()
    Local cFormula := Alltrim(cGetForm)
    Local cError   := ""
    Local bError   := ErrorBlock({ |oError| cError := oError:Description})
     
    //Se tiver conteÃºdo digitado
    If ! Empty(cFormula)
        //Inicio a utilizaÃ§Ã£o da tentativa
        Begin Sequence
            &(cFormula)
        End Sequence
         
        //Restaurando bloco de erro do sistema
        ErrorBlock(bError)
         
        //Se houve erro, serÃ¡ mostrado ao usuÃ¡rio
        If ! Empty(cError)
            MsgStop("Houve um erro na fÃ³rmula digitada: "+CRLF+CRLF+cError, "AtenÃ§Ã£o")
        EndIf
    EndIf
     
    RestArea(aArea)
Return
