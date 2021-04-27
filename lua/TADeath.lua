local Wreckage = import('/lua/wreckage.lua').Wreckage

SCTAWreckage = Class(Wreckage) {

    OnCreate = function(self)
        Wreckage.OnCreate(self)
        self.Scale = self:GetBlueprint().BlueprintId
        LOG('*Scale', self.Scale)
    end,

    OnDestroy = function(self)
        Wreckage.OnDestroy(self)
        CreateHeapProp(self, 0)
    end,
        --- Create and return an identical wreckage prop. Useful for replacing this one when something
        -- (a stupid engine bug) deleted it when we don't want it to.
        -- This function has the handle the case when *this* unit has already been destroyed. Notably,
        -- this means we have to calculate the health from the reclaim values, instead of going the
        -- other way.
    }

CreateHeapProp = function(self, overkillRatio)
    local bp = self:GetBlueprint()
    local wreck = bp.Wreckage.Blueprint
    if not wreck then
        return nil
    end
    --local RecBP = bp.Display.UniformScale
    --LOG('*MassWreck', mass)
    local mass = (bp.Economy.BuildCostMass * (bp.Wreckage.MassMult or 0))
    local energy = (bp.Economy.BuildCostEnergy * (bp.Wreckage.EnergyMult or 0))
    local time = (bp.Wreckage.ReclaimTimeMultiplier or 1)
    --LOG('*MassWreck2', mass)
    --LOG('*Associate', RecBP)
    --LOG('*WreckBP', bp)
    local pos = self:GetPosition()

    time = time * 1
    local overkillMultiplier = 1 - (overkillRatio or 0.5)
    mass = mass * overkillMultiplier
    energy = energy * overkillMultiplier
    time = time * overkillMultiplier
    -- Now we adjust the global multiplier. This is used for balance purposes to adjust global reclaim rate.
    local time  = time * 2

    local prop = CreateHeap(bp, pos, self:GetOrientation(), mass, energy, time, self.DeathHitBox)
    CreateAttachedEmitter(self, 0, -1, '/mods/SCTA-master/effects/emitters/wreckage_smoke_emit.bp' )

    return prop
end


CreateHeap = function(bp, position, orientation, mass, energy, time, deathHitBox)
    local prop = CreateProp(position, '/mods/SCTA-master/meshes/rockteeth/rockteeth_prop.bp')
    CreateAttachedEmitter(prop, 0, -1, '/mods/SCTA-master/effects/emitters/fire_smoke_emit.bp' )
    prop:SetOrientation(orientation, true)
    prop:SetScale(bp.Display.UniformScale)
    LOG('*Scale', bp.Display.UniformScale)
    -- take the default center (cx, cy, cz) and size (sx, sy, sz)
    local cx, cy, cz, sx, sz;
    cx = bp.CollisionOffsetX
    cy = bp.CollisionOffsetY
    cz = bp.CollisionOffsetZ
    sx = bp.SizeX * 0.5
    sy = 0.2
    sz = bp.SizeZ * 0.5

    -- if a death animation is played the wreck hitbox may need some changes
    if deathHitBox then 
        cx = deathHitBox.CollisionOffsetX or cx 
        cy = deathHitBox.CollisionOffsetY or cy 
        cz = deathHitBox.CollisionOffsetZ or cz 
        sx = deathHitBox.SizeX or sx 
        sy = deathHitBox.SizeY or sy 
        sz = deathHitBox.SizeZ or sz 
    end

    -- adjust the size, these dimensions are in both directions based on the center
    sx = sx * 0.5
    sy = sy * 0.5
    sz = sz * 0.5

    -- create the collision box
    prop:SetPropCollision('Box', cx, cy, cz, sx, sy, sz)

    prop:SetMaxHealth(bp.Defense.Health)
    prop:SetHealth(nil, bp.Defense.Health * (bp.Wreckage.HealthMult or 1))
    prop:SetMaxReclaimValues(time, mass, energy)

    --FIXME: SetVizToNeurals('Intel') is correct here, so you can't see enemy wreckage appearing
    -- under the fog. However the engine has a bug with prop intel that makes the wreckage
    -- never appear at all, even when you drive up to it, so this is disabled for now.
    --prop:SetVizToNeutrals('Intel')
        prop:SetMesh(prop:GetBlueprint().Display.MeshBlueprint)

    -- This field cannot be renamed or the magical native code that detects rebuild bonuses breaks.
    prop.AssociatedBP = bp.Wreckage.IdHook or bp.BlueprintId
    return prop
end
