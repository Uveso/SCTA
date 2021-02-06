local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'

BuilderGroup {
    BuilderGroupName = 'SCTAAIDefenseBuilder',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'SCTAMissileTower',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 50,
        BuilderConditions = {
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.5, 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1AADefense',
                },
            }
        }
    },
    Builder {
        BuilderName = 'SCTALaserTower',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 50,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {480} }, -- Don't make tanks if we have lots of them.
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.5, 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1GroundDefense',
                },
            }
        }
    },
    Builder {
        BuilderName = 'SCTAMissileDefense',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 50,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.ANTIMISSILE} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1 }}, 
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2MissileDefense',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'SCTALaser2Tower',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 60,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.LASER * categories.LEVEL2 } }, 
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1 }}, 
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2GroundDefense',
                },
            }
        }
    },
}