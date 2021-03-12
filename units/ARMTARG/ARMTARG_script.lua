#ARM Targeting Facility - Automatic Radar Targeting
#ARMTARG
#
#Script created by Raevn

local TACloser = import('/mods/SCTA-master/lua/TAStructure.lua').TACloser

ARMTARG = Class(TACloser) {
	OnCreate = function(self)
		TACloser.OnCreate(self)
		self.Spinners = {
			post1 = CreateRotator(self, 'post1', 'x', nil, 0, 0, 0),
			post2 = CreateRotator(self, 'post2', 'x', nil, 0, 0, 0),
			post3 = CreateRotator(self, 'post3', 'z', nil, 0, 0, 0),
			post4 = CreateRotator(self, 'post4', 'z', nil, 0, 0, 0),
		}
		self.Sliders = {
			light1 = CreateSlider(self, 'light1'),
			light2 = CreateSlider(self, 'light2'),
			light3 = CreateSlider(self, 'light3'),
			light4 = CreateSlider(self, 'light4'),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TACloser.OnStopBeingBuilt(self,builder,layer)
		ForkThread(self.Unfold, self)
	end,

	OpeningState = State {
		Main = function(self)
			TACloser.Unfold(self)
			self:EnableIntel('Radar')
			self:PlayUnitSound('Activate')
			self.intelIsActive = true
		--TURN post1 to x-axis <-90.21> SPEED <82.32>;
		self.Spinners.post1:SetGoal(-90)
		self.Spinners.post1:SetSpeed(82)

		--TURN post2 to x-axis <89.78> SPEED <81.93>;
		self.Spinners.post2:SetGoal(90)
		self.Spinners.post2:SetSpeed(82)

		--TURN post3 to z-axis <-90.21> SPEED <82.32>;
		self.Spinners.post3:SetGoal(90)
		self.Spinners.post3:SetSpeed(82)

		--TURN post4 to z-axis <90.21> SPEED <82.32>;
		self.Spinners.post4:SetGoal(-90)
		self.Spinners.post4:SetSpeed(82)

		--SLEEP <1096>;
                WaitSeconds(1.1)

		--MOVE light4 to x-axis <1.90> SPEED <1.00>;
		self.Sliders.light4:SetGoal(-1.9,0,0)
		self.Sliders.light4:SetSpeed(1)

		--MOVE light3 to x-axis <-2.05> SPEED <1.00>;
		self.Sliders.light3:SetGoal(2.05,0,0)
		self.Sliders.light3:SetSpeed(1)

		--MOVE light2 to z-axis <-2.00> SPEED <1.00>;
		self.Sliders.light2:SetGoal(0,0,-2)
		self.Sliders.light2:SetSpeed(1)

		--MOVE light1 to z-axis <2.00> SPEED <1.00>;
		self.Sliders.light1:SetGoal(0,0,2)
		self.Sliders.light1:SetSpeed(1)

		--SLEEP <1109>;
		--SLEEP <53>;
		ChangeState(self, self.IdleOpenState)
	end,
},

ClosingState = State {
	Main = function(self)
		self:DisableIntel('Radar')
		TACloser.Fold(self)
		self:PlayUnitSound('Deactivate')
		--MOVE light4 to x-axis <0> SPEED <1.00>;
		self.Sliders.light4:SetGoal(0,0,0)
		self.Sliders.light4:SetSpeed(1)

		--MOVE light3 to x-axis <0> SPEED <1.00>;
		self.Sliders.light3:SetGoal(0,0,0)
		self.Sliders.light3:SetSpeed(1)

		--MOVE light2 to z-axis <0> SPEED <1.00>;
		self.Sliders.light2:SetGoal(0,0,0)
		self.Sliders.light2:SetSpeed(1)

		--MOVE light1 to z-axis <0> SPEED <1.00>;
		self.Sliders.light1:SetGoal(0,0,0)
		self.Sliders.light1:SetSpeed(1)

		--SLEEP <1206>;
                WaitSeconds(1.2)

		--TURN post1 to x-axis <0> SPEED <73.96>;
		self.Spinners.post1:SetGoal(0)
		self.Spinners.post1:SetSpeed(74)

		--TURN post2 to x-axis <0> SPEED <73.60>;
		self.Spinners.post2:SetGoal(0)
		self.Spinners.post2:SetSpeed(74)

		--TURN post3 to z-axis <0> SPEED <73.96>;
		self.Spinners.post3:SetGoal(0)
		self.Spinners.post3:SetSpeed(74)

		--TURN post4 to z-axis <0> SPEED <73.96>;
		self.Spinners.post4:SetGoal(0)
		self.Spinners.post4:SetSpeed(74)
		ChangeState(self, self.IdleClosedState)
	end,
	},
}
TypeClass = ARMTARG