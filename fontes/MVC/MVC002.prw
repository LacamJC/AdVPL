#include 'protheus.ch'

User Function MVC002

    Local oBrowse   := FwMBrowse():New()

    oBrowse:setAlias('SZ0')
    oBrowse:setDescription('Carteira de clientes')
    oBrowse:Activate()

return

Static Function ModelDef()

    Local oStructSZ0    := FwFormStruct(1, 'SZ0')
    Local oStructSZ1    := FwFormStruct(1, 'SZ1')
    Local aRelation     := {}
    Local oModel 

    oModel              := MPFormModel():New("MVC002M")
    oModel:AddFields("SZ0MASTER",  , oStructSZ0)
    oModel:AddGrid('SZ1DETAIL', 'SZ0MASTER', oStructSZ1)    

return oModel
