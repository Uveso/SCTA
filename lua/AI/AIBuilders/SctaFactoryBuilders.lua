
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local TAutils = '/mods/SCTA-master/lua/TAAIutils.lua'
local TASlow = '/mods/SCTA-master/lua/TAAISlow.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local PLANT = (categories.FACTORY * categories.TECH1)
local LAB = (categories.FACTORY * categories.TECH2)
local PLATFORM = (categories.FACTORY * categories.TECH3)
local FUSION = (categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)) * categories.STRUCTURE

BuilderGroup {
    BuilderGroupName = 'SCTAAIFactoryBuilders',
    BuildersType = 'EngineerBuilder',
    ----BotsFacts
    Builder {
        BuilderName = 'SCTAAI T1Engineer LandFac',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 102,
        InstanceCount = 2,
        DelayEqualBuildPlattons = {'Factories', 3},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Factories' }},
            { TASlow, 'TAFactoryCapCheck', { 'LocationType'} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1,  LAB} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 0.5 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 300 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1LandFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T2LAND Factory',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        Priority = 111,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'Factories', 3},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Factories' }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 10,  LAB} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 300 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2LandFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI Gantry Factory',
        PlatoonTemplate = 'EngineerBuilderSCTA23',
        Priority = 152,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'Factories', 3},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Factories' }},
            { MIBC, 'GreaterThanGameTime', {1500} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.GATE} }, -- Stop after 10 facs have been built.
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.GATE} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildStructures = {
                    'T3QuantumGate',
                }
            }
        }
    },
    ---VEHICLEFacts
    Builder {
        BuilderName = 'SCTAAI T1Engineer LandFac2',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 96,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'Factories', 3},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Factories' }},
            { MIBC, 'GreaterThanGameTime', { 120 } },
            { TASlow, 'TAFactoryCapCheck', { 'LocationType'} }, -- Stop after 10 facs have been built. -- Stop after 10 facs have been built.
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1,  LAB} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 300 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1LandFactory2',
                    'T1EnergyProduction',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T2LAND2 Factory',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        Priority = 108,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'Factories', 3},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Factories' }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 10, LAB} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 300 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2LandFactory2',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T3LAND Hover Factory',
        PlatoonTemplate = 'EngineerBuilderSCTA3',
        Priority = 143,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'Factories', 3},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Factories' }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 6, PLATFORM} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 300 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T3LandFactory',
                }
            }
        }
    },
    ---AirFacts
    Builder {
        BuilderName = 'SCTAAI T1Engineer AirFac Early',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 128,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'Factories', 3},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Factories' }},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, PLANT } }, -- Don't build air fac immediately.
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.FACTORY * categories.AIR} },
            { MIBC, 'LessThanGameTime', {600} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.6, 0.6 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1EnergyProduction',
                    'T1AirFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer AirFac',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 103,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 4,  PLANT } }, -- Don't build air fac immediately.
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4,  categories.FACTORY * categories.AIR} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1,  LAB * categories.AIR} }, -- Stop after 5 facs have been built.
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.5, 0.9 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 1000 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1AirFactory',
                    'T1EnergyProduction2',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T2AirFactory',
        PlatoonTemplate = 'EngineerBuilderSCTAEco12',
        Priority = 136,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'Factories', 3},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Factories' }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, LAB * categories.AIR } }, -- Stop after 10 facs have been built.
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.5, 0.9 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 300 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildStructures = {
                    'T2AirFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T2AirFactory2',
        PlatoonTemplate = 'EngineerBuilderSCTAEco123',
        Priority = 119,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'Factories', 3},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Factories' }},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, FUSION} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, LAB * categories.AIR } }, -- Stop after 10 facs have been built.
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.5, 0.9 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 300 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildStructures = {
                    'T2AirFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T3AirFactory',
        PlatoonTemplate = 'EngineerBuilderSCTAEco23',
        Priority = 128,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'Factories', 3},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Factories' }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.AIR * PLATFORM} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.5, 0.9 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 300 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildStructures = {
                    'T3AirFactory',
                }
            }
        }
    },
    ---EmergencyFacts
    Builder {
        BuilderName = 'SCTAAI LandFac Emergency',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 53,
        InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {300} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.75, 0.5}},
            { MIBC, 'LessThanGameTime', {1200} },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1LandFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI LandFac Emergency2',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 51,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {300} },
            { MIBC, 'LessThanGameTime', {1200} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.75, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1LandFactory2',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI LandFacT2 Emergency',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        Priority = 44,
        InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {750} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.85, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2LandFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI LandFacT2 Emergency2',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        Priority = 31,
        InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {750} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.75, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2LandFactory2',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI Hover Emergency Factory',
        PlatoonTemplate = 'EngineerBuilderSCTA3',
        Priority = 27,
        InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1500} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.75, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T3LandFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Excess Early',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        PlatoonAIPlan = 'SCTAReclaimAI',
        Priority = 99,
        InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 120 } },
            { MIBC, 'LessThanGameTime', {480} }, 
            { TAutils, 'LessMassStorageMaxTA',  { 0.3}},   
            { TAutils, 'TAReclaimablesInArea', { 'LocationType', }},
        },
        BuilderData = {
            Terrain = true,
            LocationType = 'LocationType',
            ReclaimTime = 30,
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTAGameEnder',
        PlatoonTemplate = 'EngineerBuilderSCTA3',
        Priority = 160,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {2400} }, 
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.EXPERIMENTAL * categories.ARTILLERY} },        
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 10,
            Construction = {
                BuildStructures = {
                    'T4Artillery',
                },
            }
        }
    },
}