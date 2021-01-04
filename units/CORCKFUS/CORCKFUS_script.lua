#ARM Cloakable Fusion Reactor - Produces Energy
#CORCKFUS
#
#Blueprint created by Raevn

local TAStructure = import('/mods/SCTA-master/lua/TAStructure.lua').TAStructure

CORCKFUS = Class(TAStructure) {
    OnStopBeingBuilt = function(self,builder,layer)
        TAStructure.OnStopBeingBuilt(self,builder,layer)
        self:SetMaintenanceConsumptionInactive()
        self:SetScriptBit('RULEUTC_CloakToggle', true)
        self:RequestRefreshUI()
    end,
}

TypeClass = CORCKFUS
