local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local PLANT = categories.FACTORY * categories.TECH1
local LAB = categories.FACTORY * categories.TECH2
local PLATFORM = categories.FACTORY * categories.TECH3

BuilderGroup {
    BuilderGroupName = 'SCTAAIAirBuilder',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'SCTAAI Factory Bomber',
        PlatoonTemplate = 'T1AirBomberSCTA',
        Priority = 85,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 10, categories.BOMBER } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.5}},
        },
        BuilderType = 'Air',
    },
    Builder {
        BuilderName = 'SCTAAI Factory Strategic',
        PlatoonTemplate = 'T2AirBomberSCTA',
        Priority = 100,
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.5}},
        },
        BuilderType = 'Air',
    },
    Builder {
        BuilderName = 'SCTAAI Factory Intie',
        PlatoonTemplate = 'T1AirFighterSCTA',
        Priority = 95,
        BuilderConditions = { -- Only make inties if the enemy air is strong.
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, LAB * categories.AIR } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.7}},
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.2, 0.5 }},
        },
        BuilderType = 'Air',
    },       
    Builder {
        BuilderName = 'SCTAAI T1 Scouts',
        PlatoonTemplate = 'T1AirScoutSCTA',
        Priority = 200,
        BuilderConditions = {
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.MOBILE * categories.AIR * categories.SCOUT } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, LAB * categories.AIR} },
        },
        BuilderType = 'Air',
    }, 
    Builder {
        BuilderName = 'SCTAAI T2 Scouts',
        PlatoonTemplate = 'T2AirScoutSCTA',
        Priority = 105,
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.3}},
        },
        BuilderType = 'Air',
    },
    Builder {
        BuilderName = 'SCTAAI Factory Stealth',
        PlatoonTemplate = 'T2AirFighterSCTA',
        Priority = 115,
        BuilderConditions = { -- Only make inties if the enemy air is strong.
        { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.FUSION} },
        { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
    },
        BuilderType = 'Air',
    },
    Builder {
        BuilderName = 'SCTAAirTransport',
        PlatoonTemplate = 'SCTATransport',
        Priority = 50,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {900} },
            { MIBC, 'ArmyNeedsTransports', {} },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 2, 'TRANSPORTATION' } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, 'TRANSPORTATION' } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'TRANSPORTATION' } },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.05 }},
        },
        BuilderType = 'Air',
    },     
}