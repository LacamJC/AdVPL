#include 'protheus.ch'


User Function PB01()
    Local aPergs   := {}
    Local cN1      := Space(100)
    Local cN2      := Space(100)
    Local nN1, nN2, nSoma, cRes
    aAdd(aPergs, {1, "Primeiro valor", @cN1, "", ".T.", "", ".T.", 120, .T.})
    aAdd(aPergs, {1, "Segundo valor",  @cN2, "", ".T.", "SB1", ".T.", 80, .F.})
    
    If ParamBox(aPergs, "Informe os parametros")
        nN1         := MV_PAR01 
        nN2         := MV_PAR02
        nSoma       := val(nN1) + val(nN2)
        cRes        := AllTrim(Str(nSoma))

        If cRes != Nil
            FWAlertsucess(AllTrim(nN1) + "+" + AllTrim(nN2) + "=" + cRes, "Soma")
        EndIf
        
    EndIf
return 
