#CORE Titan - Torpedo Bomber
#ARMSEAP
#
#Script created by Raevn

local TAair = import('/mods/SCTA-master/lua/TAair.lua').TAair
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMSEAP = Class(TAair) {

	OnCreate = function(self)
		TAair.OnCreate(self)
		self.Spinners = {
			wing1 = CreateRotator(self, 'LWing', 'z', nil, 0, 0, 0),
			wing2 = CreateRotator(self, 'RWing', 'z', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
	end,

	OnMotionVertEventChange = function(self, new, old )
		if (new == 'Down' or new == 'Bottom') then
                	self:PlayUnitSound('Landing')
			self:CloseWings(self)
		elseif (new == 'Up' or new == 'Top') then
                	self:PlayUnitSound('TakeOff')
			self:OpenWings(self)
		end
	end,

	OpenWings = function(self)
		--TURN wing1 to z-axis <-90.00> SPEED <60.69>;
		self.Spinners.wing1:SetGoal(90)
		self.Spinners.wing1:SetSpeed(61)

		--TURN wing2 to z-axis <90.00> SPEED <60.69>;
		self.Spinners.wing2:SetGoal(-90)
		self.Spinners.wing2:SetSpeed(61)
	end,

	CloseWings = function(self)
		--TURN wing1 to z-axis <0> SPEED <60.69>;
		self.Spinners.wing1:SetGoal(0)
		self.Spinners.wing1:SetSpeed(61)

		--TURN wing2 to z-axis <0> SPEED <60.69>;
		self.Spinners.wing2:SetGoal(0)
		self.Spinners.wing2:SetSpeed(61)
	end,

	Weapons = {
		CORAIR_TORPEDO = Class(TAweapon) {},
		ARMVTOL_MISSILE = Class(TAweapon) {},
	},
}

TypeClass = ARMSEAP