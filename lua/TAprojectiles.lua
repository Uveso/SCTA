local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local SinglePolyTrailProjectile = DefaultProjectileFile.SinglePolyTrailProjectile
local NukeProjectile = DefaultProjectileFile.NukeProjectile
local OnWaterEntryEmitterProjectile = DefaultProjectileFile.OnWaterEntryEmitterProjectile

TAProjectile = Class(SinglePolyTrailProjectile) {
	PolyTrail = '',
}

TANuclearProjectile = Class(NukeProjectile) {
	FxSmoke = '/mods/SCTA-master/effects/emitters/smoke_emit.bp',
	FxSmokeScale = 1,

	OnCreate = function(self)
	NukeProjectile.OnCreate(self)
	self.Trash:Add(CreateAttachedEmitter(self, 0, self:GetArmy(), self.FxSmoke):ScaleEmitter(self.FxSmokeScale))
	end,

	FxImpactAirUnit = {
		'/mods/SCTA-master/effects/emitters/COMBOOM_emit.bp',
	},
	FxAirUnitHitScale = 15,
	FxImpactShield = {
		'/mods/SCTA-master/effects/emitters/COMBOOM_emit.bp',
	},
	FxShieldHitScale = 15,
	FxImpactUnit = {
		'/mods/SCTA-master/effects/emitters/COMBOOM_emit.bp',
	},
	FxUnitHitScale = 15,
	FxImpactProp = {
		'/mods/SCTA-master/effects/emitters/COMBOOM_emit.bp',
	},
	FxPropHitScale = 15,
	FxImpactLand = {
		'/mods/SCTA-master/effects/emitters/COMBOOM_emit.bp',
	},
	FxLandHitScale = 15,
	FxImpactWater = {
		'/effects/emitters/destruction_water_splash_ripples_01_emit.bp',
		'/effects/emitters/destruction_water_splash_wash_01_emit.bp',
		'/effects/emitters/destruction_water_splash_plume_01_emit.bp',
	},
    	FxWaterHitScale = 15,
	    FxImpactProjectile = {
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_01_emit.bp',
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_03_emit.bp',
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_04_emit.bp',
	},
	FxProjectileHitScale = 1.5,
    
    FxImpactTrajectoryAligned = false,

}

TAEMPNuclearProjectile = Class(NukeProjectile) {
		FxSmoke = '/mods/SCTA-master/effects/emitters/smoke_emit.bp',
		FxSmokeScale = 1,
	
		OnCreate = function(self)
		NukeProjectile.OnCreate(self)
		self.Trash:Add(CreateAttachedEmitter(self, 0, self:GetArmy(), self.FxSmoke):ScaleEmitter(self.FxSmokeScale))
	end,

	FxImpactAirUnit = {
		'/mods/SCTA-master/effects/emitters/EMPBOOM_emit.bp',
	},
	FxAirUnitHitScale = 15,
	FxImpactShield = {
		'/mods/SCTA-master/effects/emitters/EMPBOOM_emit.bp',
	},
	FxShieldHitScale = 15,
	FxImpactUnit = {
		'/mods/SCTA-master/effects/emitters/EMPBOOM_emit.bp',
	},
	FxUnitHitScale = 15,
	FxImpactProp = {
		'/mods/SCTA-master/effects/emitters/EMPBOOM_emit.bp',
	},
	FxPropHitScale = 15,
	FxImpactLand = {
		'/mods/SCTA-master/effects/emitters/EMPBOOM_emit.bp',
	},
	FxLandHitScale = 15,
	FxImpactWater = {
		'/effects/emitters/destruction_water_splash_ripples_01_emit.bp',
		'/effects/emitters/destruction_water_splash_wash_01_emit.bp',
		'/effects/emitters/destruction_water_splash_plume_01_emit.bp',
	},
    	FxWaterHitScale = 15,
	    FxImpactProjectile = {
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_01_emit.bp',
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_03_emit.bp',
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_04_emit.bp',
	},
	FxProjectileHitScale = 1.5,
    
    FxImpactTrajectoryAligned = false,

}

TAHeavyCannonProjectile = Class(TAProjectile) {
	FxImpactAirUnit = {
		'/effects/emitters/napalm_fire_emit_2.bp',
		'/effects/emitters/napalm_03_emit.bp',
		'/effects/emitters/napalm_03_emit.bp',
		'/effects/emitters/napalm_03_emit.bp',
    	'/mods/SCTA-master/effects/emitters/ta_missile_hit_01_emit.bp',
	},
	FxAirUnitHitScale = 2,
	FxImpactShield = {
		'/effects/emitters/napalm_fire_emit_2.bp',
		'/effects/emitters/napalm_03_emit.bp',
		'/effects/emitters/napalm_03_emit.bp',
		'/effects/emitters/napalm_03_emit.bp',
    	'/mods/SCTA-master/effects/emitters/ta_missile_hit_01_emit.bp',
	},
	FxShieldHitScale = 2,
	FxImpactUnit = {
		'/effects/emitters/napalm_fire_emit_2.bp',
		'/effects/emitters/napalm_03_emit.bp',
		'/effects/emitters/napalm_03_emit.bp',
		'/effects/emitters/napalm_03_emit.bp',
    	'/mods/SCTA-master/effects/emitters/ta_missile_hit_01_emit.bp',
	},
	FxUnitHitScale = 2,
	FxImpactProp = {
		'/effects/emitters/napalm_fire_emit_2.bp',
		'/effects/emitters/napalm_03_emit.bp',
		'/effects/emitters/napalm_03_emit.bp',
		'/effects/emitters/napalm_03_emit.bp',
    	'/mods/SCTA-master/effects/emitters/ta_missile_hit_01_emit.bp',
	},
	FxPropHitScale = 2,
	FxImpactLand = {
		'/effects/emitters/napalm_fire_emit_2.bp',
		'/effects/emitters/napalm_03_emit.bp',
		'/effects/emitters/napalm_03_emit.bp',
		'/effects/emitters/napalm_03_emit.bp',
    	'/mods/SCTA-master/effects/emitters/ta_missile_hit_01_emit.bp',
	},
	FxLandHitScale = 2,
	FxImpactWater = {
		'/effects/emitters/destruction_water_splash_ripples_01_emit.bp',
		'/effects/emitters/destruction_water_splash_wash_01_emit.bp',
		'/effects/emitters/destruction_water_splash_plume_01_emit.bp',
	},
    	FxWaterHitScale = 1.5,
}

TACannonProjectile = Class(TAProjectile) {
	FxImpactAirUnit = {
		'/effects/emitters/napalm_fire_emit_2.bp',
	},
	FxAirUnitHitScale = 1.25,
	FxImpactShield = {
		'/effects/emitters/napalm_fire_emit_2.bp',
	},
	FxShieldHitScale = 1.25,
	FxImpactUnit = {
		'/effects/emitters/napalm_fire_emit_2.bp',
	},
	FxUnitHitScale = 1.25,
	FxImpactProp = {
		'/effects/emitters/napalm_fire_emit_2.bp',
	},
	FxPropHitScale = 1.25,
	FxImpactLand = {
		'/effects/emitters/napalm_fire_emit_2.bp',
	},
	FxLandHitScale = 1.25,
	FxImpactWater = {
		'/effects/emitters/destruction_water_splash_ripples_01_emit.bp',
		'/effects/emitters/destruction_water_splash_wash_01_emit.bp',
		'/effects/emitters/destruction_water_splash_plume_01_emit.bp',
	},
    	FxWaterHitScale = 0.75,
}

TAMediumCannonProjectile = Class(TAProjectile) {
	FxImpactNone = {
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_01_emit.bp',
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_03_emit.bp',
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_04_emit.bp',
	},
	FxNoneHitScale = 0.35,
	FxImpactShield = {
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_01_emit.bp',
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_03_emit.bp',
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_04_emit.bp',
	},
	FxShieldHitScale = 0.35,
	FxImpactUnit = {
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_01_emit.bp',
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_03_emit.bp',
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_04_emit.bp',
	},
	FxUnitHitScale = 0.35,
	FxImpactAirUnit = {
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_01_emit.bp',
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_03_emit.bp',
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_04_emit.bp',
	},
	FxAirUnitHitScale = 0.35,
	FxImpactProp = {
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_01_emit.bp',
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_03_emit.bp',
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_04_emit.bp',
	},
	FxPropHitScale = 0.35,
	FxImpactLand = {
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_01_emit.bp',
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_03_emit.bp',
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_04_emit.bp',
	},
	FxLandHitScale = 0.35,
	FxImpactWater = {
		'/effects/emitters/destruction_water_splash_ripples_01_emit.bp',
		'/effects/emitters/destruction_water_splash_wash_01_emit.bp',
		'/effects/emitters/destruction_water_splash_plume_01_emit.bp',
	},
    	FxWaterHitScale = 0.5,
}

TALightCannonProjectile = Class(TAProjectile) {
	FxImpactAirUnit = {
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_04_emit.bp',
	},
	FxAirUnitHitScale = 0.25,
	FxImpactShield = {
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_04_emit.bp',
	},
	FxShieldHitScale = 0.25,
	FxImpactUnit = {
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_04_emit.bp',
	},
	FxUnitHitScale = 0.25,
	FxImpactProp = {
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_04_emit.bp',
	},
	FxPropHitScale = 0.25,
	FxImpactLand = {
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_04_emit.bp',
	},
	FxLandHitScale = 0.25,
	FxImpactWater = {
		'/effects/emitters/destruction_water_splash_ripples_01_emit.bp',
		'/effects/emitters/destruction_water_splash_wash_01_emit.bp',
	},
    	FxWaterHitScale = 0.5,
}

Disintegrator = Class(TALightCannonProjectile) {
	OnCreate = function(self)
		TALightCannonProjectile.OnCreate(self)
		self.launcher = self:GetLauncher()
		ForkThread(self.MovementThread, self)
	end,

	MovementThread = function(self)
		while not IsDestroyed(self) do
			local pos = self:GetPosition()
		if pos.y < GetTerrainHeight(pos.x, pos.z) then
			self:SetTurnRate(0)
			pos.y = GetTerrainHeight(pos.x, pos.z)
			DamageArea( self.launcher, pos, self.DamageData.DamageRadius, self.DamageData.DamageAmount, self.DamageData.DamageType, self.DamageData.DamageFriendly)
				self:SetPosition(pos, true)
				self:PlaySound(Sound({Cue = 'XPLOMAS2', Bank = 'TA_Sound', LodCutoff = 'Weapon_LodCutoff'}))
				CreateEmitterAtEntity(self, self:GetArmy(), '/mods/SCTA-master/effects/emitters/ta_missile_hit_04_emit.bp' ):ScaleEmitter(0.5)
			end
			WaitSeconds(0.1)
		end
	end,
}

FlameProjectile = Class(TALightCannonProjectile) {
	FxFlame = '/mods/SCTA-master/effects/emitters/TAFlamethrower_emit.bp',
	FxFlameScale = 1,

	OnCreate = function(self)
		TALightCannonProjectile.OnCreate(self)
		ForkThread(self.MovementThread,self)
		self.Trash:Add(CreateAttachedEmitter(self, 0, self:GetArmy(), self.FxFlame):ScaleEmitter(self.FxFlameScale))
	end,

	MovementThread = function(self)
		while not IsDestroyed(self) do
			local pos = self:GetPosition()
			DamageArea(self, pos, 1, 5, 'Normal', false)
			WaitSeconds(0.1)
		end
	end,

	FxImpactAirUnit = {},
	FxImpactShield = {},
	FxImpactUnit = {},
	FxImpactProp = {},
	FxImpactLand = {},
	FxImpactWater = {},
}

TAAntiRocketProjectile = Class(TAMediumCannonProjectile) {
	FxSmoke = '/mods/SCTA-master/effects/emitters/smoke_emit.bp',
	FxSmokeScale = 1,

	OnCreate = function(self)
	TAMediumCannonProjectile.OnCreate(self)
	self.Trash:Add(CreateAttachedEmitter(self, 0, self:GetArmy(), self.FxSmoke):ScaleEmitter(self.FxSmokeScale))
	end,
}

TARocketProjectile = Class(TAAntiRocketProjectile) {
	OnCreate = function(self)
	TAAntiRocketProjectile.OnCreate(self)
	self.TrackTime = self:GetBlueprint().Physics.TrackTime
	self:ForkThread( self.TrackingThread, self )
end,

TrackingThread = function(self)
	WaitSeconds(self.TrackTime)
	self:TrackTarget(false)
end,
}

TAMissileProjectile = Class(TARocketProjectile) {
	OnCreate = function(self)
	TARocketProjectile.OnCreate(self)
	self:SetCollisionShape('Sphere', 0, 0, 0, 1)
end,

TrackingThread = function(self)
	self:TrackTarget(false)
	WaitSeconds(self.TrackTime/2)
	self:TrackTarget(true)
	WaitSeconds(self.TrackTime)
	self:TrackTarget(false)
end,
}


TAAntiNukeProjectile = Class(SinglePolyTrailProjectile) {
	FxImpactProjectile = {
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_01_emit.bp',
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_03_emit.bp',
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_04_emit.bp',
	},
	FxProjectileHitScale = 1.5,

	FxSmoke = '/mods/SCTA-master/effects/emitters/smoke_emit.bp',
	FxSmokeScale = 1,

	OnCreate = function(self)
	SinglePolyTrailProjectile.OnCreate(self)
	self.Trash:Add(CreateAttachedEmitter(self, 0, self:GetArmy(), self.FxSmoke):ScaleEmitter(self.FxSmokeScale))
end,
}

TALaserProjectile = Class(TAProjectile) {

	FxImpactAirUnit = {
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_01_emit.bp',
	},
	FxAirUnitHitScale = 0.25,
	FxImpactShield = {
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_01_emit.bp',
	},
	FxShieldHitScale = 0.25,
	FxImpactUnit = {
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_01_emit.bp',
	},
	FxUnitHitScale = 0.25,
	FxImpactProp = {
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_01_emit.bp',
	},
	FxPropHitScale = 0.25,
	FxImpactLand = {
    		'/mods/SCTA-master/effects/emitters/ta_missile_hit_01_emit.bp',
	},
	FxLandHitScale = 0.25,
	FxImpactWater = {
		'/effects/emitters/destruction_water_splash_ripples_01_emit.bp',
		'/effects/emitters/destruction_water_splash_wash_01_emit.bp',
	},
    	FxWaterHitScale = 0.5,
}

TAEMGProjectile = Class(TALaserProjectile ) {
}

TADepthCharges = Class(OnWaterEntryEmitterProjectile) {
    OnEnterWater = function(self)
        OnWaterEntryEmitterProjectile.OnEnterWater(self)
		for k,v in self.FxImpactWater do
			CreateEmitterAtEntity(self, self:GetArmy(), v):ScaleEmitter(self.FxWaterHitScale)
		end
    end,

	OnExitWater = function(self)
		OnWaterEntryEmitterProjectile.OnExitWater(self)
		for k,v in self.FxImpactWater do
			CreateEmitterAtEntity(self, self:GetArmy(), v):ScaleEmitter(self.FxWaterHitScale)
		end
	end,

	FxImpactLand = {
		'/effects/emitters/destruction_water_splash_ripples_01_emit.bp',
		'/effects/emitters/destruction_water_splash_wash_01_emit.bp',
		'/effects/emitters/destruction_water_splash_plume_01_emit.bp',
	},

	FxImpactUnderWater = {
		'/mods/SCTA-master/effects/emitters/ta_missile_hit_01_emit.bp',
		'/mods/SCTA-master/effects/emitters/ta_missile_hit_03_emit.bp',
		'/mods/SCTA-master/effects/emitters/ta_missile_hit_04_emit.bp',
	},
	FxUnderWaterHitScale = 0.35,
	
	FxImpactWater = {
		'/effects/emitters/destruction_water_splash_ripples_01_emit.bp',
	},
		FxWaterHitScale = 0.35,
}

TAUnderWaterProjectile = Class(TADepthCharges) {

    OnCreate = function(self, inWater)
        TADepthCharges.OnCreate(self, inWater)
		self:SetCollisionShape('Sphere', 0, 0, 0, 1)
		self:ForkThread( self.TrackingThread, self )
	end,


	TrackingThread = function(self)
		self:TrackTarget(false)
		WaitSeconds(self.TrackTime/2)
		self:TrackTarget(true)
		WaitSeconds(self.TrackTime)
		self:TrackTarget(false)
	end,
}