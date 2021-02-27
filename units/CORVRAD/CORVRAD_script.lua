#CORE Informer - Mobile Radar
#CORVRAD
#
#Script created by Raevn
local TACloaker = import('/mods/SCTA-master/lua/TAMotion.lua').TACloaker

CORVRAD = Class(TACloaker) {
	OnCreate = function(self)
		TACloaker.OnCreate(self)
		self.Spinners = {
			dish = CreateRotator(self, 'dish', 'y', nil, 0, 100, 0),
		}
		self.Trash:Add(self.Spinners.dish)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TACloaker.OnStopBeingBuilt(self,builder,layer)
		--spin dish around y-axis speed <100>;
		self.Spinners.dish:SetTargetSpeed(100)
	end,
}
TypeClass = CORVRAD