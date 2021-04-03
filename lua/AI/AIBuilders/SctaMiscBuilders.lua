local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local FUSION = (categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)) * categories.STRUCTURE

BuilderGroup {
    BuilderGroupName = 'SCTAAIEngineerMiscBuilder',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'SCTAMissileTower',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 51,
        InstanceCount = 3,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 10, categories.SILO - categories.MOBILE} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.33, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1AADefense',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTALaserTower',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 62,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {480} }, -- Don't make tanks if we have lots of them.
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.ANTISHIELD * categories.TECH1 - categories.MOBILE } }, 
            { EBC, 'GreaterThanEconStorageRatio', { 0.25, 0.7}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1GroundDefense',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAMissileDefense',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 73,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {900} }, 
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.ANTIMISSILE * categories.TECH2} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.7}},
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
        BuilderName = 'SCTAMissileDefense2',
        PlatoonTemplate = 'EngineerBuilderSCTA3',
        Priority = 74,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1500} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 4,  FUSION} },  
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.ANTIMISSILE * categories.TECH3} },
            { IBC, 'BrainNotLowPowerMode', {} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildStructures = {
                    'T3StrategicMissileDefense',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'SCTALaser2Tower',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        Priority = 76,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 8, categories.ANTISHIELD * categories.TECH2 - categories.MOBILE} }, 
            { EBC, 'GreaterThanEconStorageRatio', { 0.33, 0.75}}, 
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, FUSION} }, 
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2GroundDefense',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTALaser3Tower',
        PlatoonTemplate = 'EngineerBuilderSCTA23',
        Priority = 81,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.DEFENSE * categories.TECH3 - categories.MOBILE - categories.ANTIAIR} }, 
            { EBC, 'GreaterThanEconStorageRatio', { 0.4, 0.25}}, 
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T3GroundDefense',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAANTIAIR3Tower',
        PlatoonTemplate = 'EngineerBuilderSCTA23',
        Priority = 84,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 6, categories.ANTIAIR * categories.TECH2 - categories.MOBILE} }, 
            { EBC, 'GreaterThanEconStorageRatio', { 0.4, 0.25}}, 
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T3AADefense',
                }
            }
        }
    },
    Builder {
        BuilderName = 'PGen Emergency',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        Priority = 27,
        InstanceCount = 5,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {480} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.75, 0.75}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1EnergyProduction2',
                }
            }
        }
    }, 
    Builder {
        BuilderName = 'PGen Air Emergency',
        PlatoonTemplate = 'EngineerBuilderSCTAEco12',
        Priority = 30,
        InstanceCount = 5,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {480} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.75, 0.75}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1EnergyProduction2',
                }
            }
        }
    }, 
    Builder {
        BuilderName = 'SCTAMissileTower Emergency',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        Priority = 26,
        InstanceCount = 10,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {480} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.75, 0.75}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1AADefense',
                }
            }
        }
    },    
    Builder {
        BuilderName = 'SCTAMissileTower Air Emergency',
        PlatoonTemplate = 'EngineerBuilderSCTAEco12',
        Priority = 28,
        InstanceCount = 10,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {480} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.75, 0.75}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1AADefense',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAGameEnder',
        PlatoonTemplate = 'EngineerBuilderSCTA3',
        Priority = 160,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {2400} }, 
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.EXPERIMENTAL * categories.ARTILLERY} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.5, 0.5}},
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
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'SCTAStaging',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 57,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.AIRSTAGINGPLATFORM} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.1}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2AirStagingPlatform',
                }
            }
        }
    },
}