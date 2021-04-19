#CORE Warlord - Battleship
#CORBATS
#
#Script created by Raevn

local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORBATS = Class(TASea) {

	OnCreate = function(self)
		TASea.OnCreate(self)
		self.Spinners = {
			guna = CreateRotator(self, 'guna', 'z', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		self.currentBarrel = 0
	end,

	Weapons = {
		COR_BATS = Class(TAweapon) {

		},
		COR_BATSLASER = Class(TAweapon) {
			OnWeaponFired = function(self)
				TAweapon.OnWeaponFired(self)
				self.unit.currentBarrel = self.unit.currentBarrel + 1
				if self.unit.currentBarrel == 3 then
					self.unit.currentBarrel = 0
				end

				--TURN barrel to z-axis <119.99> SPEED <400.09>; (for each turn)
				self.unit.Spinners.guna:SetGoal(-120 * self.unit.currentBarrel)
				self.unit.Spinners.guna:SetSpeed(400)
			end,
		},

	},
}

TypeClass = CORBATS
