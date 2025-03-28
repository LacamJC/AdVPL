#include 'protheus.ch'
#Include "ApWebSrv.Ch"
#Include "TopConn.Ch"
#Include "TbiConn.Ch"
#INCLUDE 'totvs.ch'
#INCLUDE "RESTFUL.CH"
#INCLUDE "FWMVCDEF.CH"
#include "rwmake.ch"
#Include "AP5Mail.ch"
User Function EMAIL()
    EnvMail('João ramajo', '123', 'joaoramajo744@gmail.com', '(11) 946289761')
return


Static Function EnvMail(cNome,cTipo,cEmail,cNum)

	Local   cHora 		:= SUBSTR(TIME(), 1, 2)                     /// Resulta: 10
    Local   cSaudacao   := ""
    
    /*
    Local   cNomeResp   := "José da Silva"                          /// Nome     Exemplo
    Local   cTelResp    := "(11) 91234-5678"                        /// Telefone Exemplo
    Local   cEmailResp  := "JoseSilva@Teste123.com.br"              /// Email    Exemplo
    */

    Private mCorpo		:= ""
    Private cAssunto	:= "Envio de teste"
    Private cEmailCC    := ""
    Private cAnexo      := ""
    Private nLineSize	:= 60
    Private nTabSize	:= 3
    Private lWrap		:= .T.
    Private nLine		:= 0
    Private cTexto		:= ""
    Private lServErro	:= .T.
    Private cServer		:= Trim(GetMV("MV_RELSERV")) /// smtp.minerals.local:25 
    // Private cDe			:= Trim(GetMV("MV_RELACNT")) /// erp.bra@ozminerals.com
    Private cDe         := Trim('joaoramajo744@gmail.com')
    Private cPass		:= Trim(GetMV("MV_RELPSW"))  ///
    Private lAutentic	:= GetMv("MV_RELAUTH",,.F.)  /// .F.

    // Private cPara		:=  "rodrigo1737@gmail.com" //cEmail
    Private cPara       := 'joao2005ramajo@gmail.com'
    Private cCC			:= cEmailCC
    //Private cImage      := "C:\\caminho\\para\\sua\\imagem.jpg" //<== Imagem rodapé

///-------------------------- Prepara as Informações ---------------------------------------------------------///

    // cNome := AjustaNome(cNome)

    //cNome    := "Rodrigo Salomão"
   
    ///Ajusta Saudação
    // if  Val(cHora) >= 18
    //     cSaudacao := "Boa Noite, " + cNome + "!"
    // Elseif Val(cHora) >= 12
    //     cSaudacao := "Boa Tarde, " + cNome + "!"
    // Elseif Val(cHora) >= 6
    //     cSaudacao := "Bom Dia, " + cNome + "!"
    // Else 
    //     cSaudacao := "Boa Madrugada, " + cNome + "!"
    // Endif

///-------------------------- Mensagem do corpo do Email ---------------------------------------------------------///

    mCorpo += cSaudacao +Chr(13)+Chr(10)+Chr(13)+Chr(10)
    // mCorpo += 'Seu ' + cTipo + ' de numero: '+cNum+' não foi integrado com Protheus.' + Chr(13)+Chr(10)
    mCorpo += 'Favor entrar em contado com o setor responsavel. ' +Chr(13)+Chr(10)
    mCorpo += 'Este é um Email Automatico, favor não responder. ' +Chr(13)+Chr(10)
    /*
    mCorpo += '   - Documento 1' +Chr(13)+Chr(10)
    mCorpo += '   - Documento 2' +Chr(13)+Chr(10)
    mCorpo += '   - Documento 3' +Chr(13)+Chr(10)
    mCorpo += '   - Documento 4' +Chr(13)+Chr(10)
    mCorpo += '   - Documento 5' +Chr(13)+Chr(10)+Chr(13)+Chr(10)
    mCorpo += 'Qualquer dúvida me coloco à disposição.'+Chr(13)+Chr(10)+Chr(13)+Chr(10)
    mCorpo += 'Atenciosamente, '+Chr(13)+Chr(10)+Chr(13)+Chr(10)
    mCorpo += cNomeResp+Chr(13)+Chr(10)//+Chr(13)+Chr(10)
    mCorpo += 'Depto.Responsavel'+Chr(13)+Chr(10)
    mCorpo += cTelResp+Chr(13)+Chr(10)
    mCorpo += cEmailResp+Chr(13)+Chr(10)+Chr(13)+Chr(10)
    mCorpo += 'OZMinerals.'+Chr(13)+Chr(10)
    mCorpo += 'Telefone da Empresa'+Chr(13)+Chr(10)
    mCorpo += 'E-Mail: erp.bra@ozminerals.com'+Chr(13)+Chr(10)
    mCorpo += 'Site: https://www.ozminerals.com/'+Chr(13)+Chr(10)
    mCorpo += "<img src='cid:" + cImage + "' />" ///<== Adiciona imagem no Rodapé
    */


/*
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³ Criacao da Interface                                                ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    @ 122,67 To 531,733 Dialog maildlg Title OemToAnsi("Envio de E-Mail ")
    @ 2,4 To 78,324
    @ 80,4 To 182,324
    @ 11,15 Say OemToAnsi("De :") Size 30,8
    @ 23,15 Say OemToAnsi("Para :") Size 25,8
    @ 35,15 Say OemToAnsi("CC :") Size 30,8
    @ 47,15 Say OemToAnsi("Assunto :") Size 30,8
    @ 59,15 Say OemToAnsi("Anexos :") Size 30,8
    @ 10,40 Get cDe Size 270,10  When .F.
    @ 22,40 Get cPara Size 270,10 Object oPara
    @ 34,40 Get cCC Size 270,10   Object oCC
    @ 46,40 Get cAssunto Size 270,10
    @ 58,40 Get cAnexo  Size 270,10  //When .f.
    //@ 186,015 Say "Validade :" 
    //@ 186,40 Get _nValidade valid _nValidade > 0
    //@ 186,070 Say "Entrega  :"
    //@ 186,105 Get _nEntrega valid _nEntrega > 0
    //@ 186,100 Say "Condicao de Pagamento:"
    //@ 186,135 Get _cCondPag valid !Empty(_cCondpag) F3 "SE4"
    @ 88,9 Get mCorpo MEMO Size 310,90
    //@ 187,276 Button OemToAnsi("_Enviar") Size 36,16 Action IIF(!Empty(cPara),Close(maildlg),MsgAlert("E-Mail sem destinatario !!"))
    Activate Dialog maildlg centered
*/

///-------------------------- Preparação para o Envio do Email ---------------------------------------------------------///

    lServERRO := .F.
    lRet      := .T.
    lEnviado  := .T.

    CONNECT SMTP;
    SERVER 	 GetMV("MV_RELSERV"); 	// Nome do servidor de e-mail
    ACCOUNT  GetMV("MV_RELACNT"); 	// Nome da conta a ser usada no e-mail
    PASSWORD GetMV("MV_RELPSW") ; 	// Senha
    Result lConectou

    If lAutentic
        lRet := Mailauth(cDe,cPass)
    Endif

    If lRet
        cPara   := Rtrim(cPara)
        cCC		:= Rtrim(cCC)
        cAssunto:= Rtrim(cAssunto)

        SEND MAIL 	FROM cDe ;
                    To cPara ;
                    CC cCc;
                    SUBJECT	cAssunto ;
                    Body mCorpo;
                    ATTACHMENT cAnexo;
                    RESULT lEnviado

        DISCONNECT SMTP SERVER
    Endif

    If !(lConectou .AND. lEnviado)
        cMensagem := ""
        GET MAIL ERROR cMensagem
    Endif

Return
