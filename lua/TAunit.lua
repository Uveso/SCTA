#Generic TA unit
local Unit = import('/lua/sim/Unit.lua').Unit
local FireState = import('/lua/game.lua').FireState
local explosion = import('/lua/defaultexplosions.lua')
local scenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local Game = import('/lua/game.lua')
local util = import('/lua/utilities.lua')

TAunit = Class(Unit) 
{

    --LOGDBG = function(self, msg)
        --LOG(self._UnitName .. "(" .. self.Sync.id .. "):" .. msg)
   ---end,

	OnCreate = function(self)
		local bp = self:GetBlueprint()
        --self._UnitName = bp.General.UnitName
        ---self:LOGDBG('TAUnit.OnCreate')
        Unit.OnCreate(self)
		self:SetFireState(FireState.GROUND_FIRE)
        end,

	OnStopBeingBuilt = function(self,builder,layer)
        ---self:LOGDBG('TAUnit.OnStopBeingBuilt')
		Unit.OnStopBeingBuilt(self,builder,layer)
		self:SetDeathWeaponEnabled(true)
		---self:SetConsumptionActive(true)	
	end,

	OnDamage = function(self, instigator, amount, vector, damageType)
		Unit.OnDamage(self, instigator, amount * (self.Pack or 1), vector, damageType)
	end,

	OnIntelDisabled = function(self)
		Unit.OnIntelDisabled()
		if not self:IsIntelEnabled('Cloak') then
		self.CloakOn = nil
		self:PlayUnitSound('Uncloak')
		self:SetMesh(self:GetBlueprint().Display.MeshBlueprint, true)
		end
	end,

	OnIntelEnabled = function(self)
		Unit.OnIntelEnabled()
		if not IsDestroyed(self) then
			self.CloakOn = true
			if self:IsIntelEnabled('Cloak') then
			self:PlayUnitSound('Cloak')
			self:SetMesh(self:GetBlueprint().Display.CloakMeshBlueprint, true)
			ForkThread(self.CloakDetection, self)
			end
		end
	end,

	TAIntelMotion = function(self) 
		while not self.Dead do
            coroutine.yield(11)
            if self.TAIntelOn and self:IsUnitState('Moving') then
                self:SetConsumptionPerSecondEnergy(self:GetBlueprint().Economy.TAConsumptionPerSecondEnergy)
			elseif self.TAIntelOn then
                self:SetConsumptionPerSecondEnergy(self:GetBlueprint().Economy.MaintenanceConsumptionPerSecondEnergy)
            end
		end
    end,

	CloakDetection = function(self)
		local GetUnitsAroundPoint = moho.aibrain_methods.GetUnitsAroundPoint
		local brain = moho.entity_methods.GetAIBrain(self)
		local cat = categories.SELECTABLE * categories.MOBILE
		local getpos = moho.entity_methods.GetPosition
		while not self.Dead do
			coroutine.yield(11)
			local dudes = GetUnitsAroundPoint(brain, cat, getpos(self), 4, 'Enemy')
			if dudes[1] and self.CloakOn then
				self:DisableIntel('Cloak')
				self:SetMesh(self:GetBlueprint().Display.MeshBlueprint, true)
			elseif not dudes[1] and self.CloakOn then
				self:EnableIntel('Cloak')
				---self:UpdateConsumptionValues()
				self:SetMesh(self:GetBlueprint().Display.CloakMeshBlueprint, true)
			end
		end
	end,

	OnScriptBitSet = function(self, bit)
		if bit == 8 then
			self:DisableUnitIntel('ToggleBit8', 'Cloak')
			if self.CloakThread then KillThread(self.CloakThread) end
			self.CloakThread = self:ForkThread(self.CloakDetection)	
		end
		Unit.OnScriptBitSet(self, bit)
	end,

	OnScriptBitClear = function(self, bit)
		if bit == 8 then
			if self.CloakThread then
				KillThread(self.CloakThread)
				self.CloakOn = nil
			end
		end
		Unit.OnScriptBitClear(self, bit)
	end,
}
