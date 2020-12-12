#ARM Adv. Shipyard - Produces Ships
#ARMASY
#
#Script created by Raevn

local TAFactory = import('/mods/SCTA-master/lua/TAFactory.lua').TAFactory

ARMASY = Class(TAFactory) {
	OnCreate = function(self)
		TAFactory.OnCreate(self)
		self.Spinners = {
			piling1 = CreateRotator(self, 'Turret_01', 'y', nil, 0, 0, 0),
			piling2 = CreateRotator(self, 'Turret_02', 'y', nil, 0, 0, 0),
			nano1 = CreateRotator(self, 'Build_Nozzle_01', 'x', nil, 0, 0, 0),
			nano2 = CreateRotator(self, 'Build_Nozzle_02', 'x', nil, 0, 0, 0),
		}
		self.Sliders = {
			nano1 = CreateSlider(self, 'Build_Nozzle_01'),
			nano2 = CreateSlider(self, 'Build_Nozzle_02'),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end
	end,

	Open = function(self)
		--MOVE nano2 to y-axis <7.80> SPEED <15.00>;
		self.Sliders.nano2:SetGoal(0,7.8,0)
		self.Sliders.nano2:SetSpeed(15)

		--MOVE nano1 to y-axis <7.65> SPEED <14.00>;
		self.Sliders.nano1:SetGoal(0,7.8,0)
		self.Sliders.nano1:SetSpeed(15)

		self.Spinners.nano2:SetGoal(75.04)
		self.Spinners.nano2:SetSpeed(112.08)

		--TURN nano1 to x-axis <58.04> SPEED <112.08>
		self.Spinners.nano1:SetGoal(75.04)
		self.Spinners.nano1:SetSpeed(112.08)
		--TURN piling1 to y-axis <-52.64> SPEED <101.46>;
		self.Spinners.piling1:SetGoal(-45)
		self.Spinners.piling1:SetSpeed(95)

		--TURN piling2 to y-axis <47.69> SPEED <91.92>;
		self.Spinners.piling2:SetGoal(45)
		self.Spinners.piling2:SetSpeed(95)

		TAFactory.Open(self)
	end,

	Close = function(self)


		--TURN piling1 to y-axis <0> SPEED <102.45>;
		self.Spinners.piling1:SetGoal(0)
		self.Spinners.piling1:SetSpeed(95)

		--TURN piling2 to y-axis <0> SPEED <92.82>;
		self.Spinners.piling2:SetGoal(0)
		self.Spinners.piling2:SetSpeed(95)

		--TURN nano2 to x-axis <0> SPEED <112.08>;
		self.Spinners.nano2:SetGoal(0)
		self.Spinners.nano2:SetSpeed(112.08)

		--TURN nano1 to x-axis <0> SPEED <112.08>;
		self.Spinners.nano1:SetGoal(0)
		self.Spinners.nano1:SetSpeed(112.08)

		--MOVE nano2 to y-axis <0> SPEED <15.00>;
		self.Sliders.nano2:SetGoal(0,0,0)
		self.Sliders.nano2:SetSpeed(15)

		--MOVE nano1 to y-axis <0> SPEED <14.00>;
		self.Sliders.nano1:SetGoal(0,0,0)
		self.Sliders.nano1:SetSpeed(15)
		TAFactory.Close(self)
	end,
}

TypeClass = ARMASY