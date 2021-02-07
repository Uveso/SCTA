local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'

BuilderGroup {
    BuilderGroupName = 'SCTAAIEngineerMassBuilder',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'SCTAAI T1Engineer Mex',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 100,
        InstanceCount = 2, -- The max number concurrent instances of this builder.
        BuilderConditions = { },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer MetalMaker',
        PlatoonTemplate = 'EngineerBuilderSCTAEco',
        Priority = 90,
        InstanceCount = 1,
        BuilderConditions = {
                { UCBC, 'HaveLessThanUnitsWithCategory', { 5, categories.MASSFABRICATION} },
                { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.05 }},
                { MIBC, 'GreaterThanGameTime', {1800} }, -- Don't make tanks if we have lots of them.
            },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                DesiresAssist = true,
                NumAssistees = 2,
                BuildClose = true,
                BuildStructures = {
                    'T1MassCreation',
                    'T1EnergyProduction',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T2Engineer Mex',
        PlatoonTemplate = 'EngineerBuilderSCTA23',
        Priority = 100,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        BuilderConditions = { },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T2Resource',
                }
            }
        }
    },
}