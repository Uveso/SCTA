local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local TAutils = '/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MABC = '/lua/editor/MarkerBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local FUSION = (categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)) * categories.STRUCTURE

BuilderGroup {
    BuilderGroupName = 'SCTAAIEngineerEcoBuilder',
    BuildersType = 'EngineerBuilder',
    ---LandEco
    Builder {
        BuilderName = 'SCTAAI T1Engineer Mex 25',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 108,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        DelayEqualBuildPlattons = {'MexLand2', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'MexLand2' }},
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 25, -500, 100, 0, 'AntiSurface', 1 }},
        },
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
        BuilderName = 'SCTAAI T1Engineer Mex 150',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 99,
        InstanceCount = 2, -- The max number concurrent instances of this builder.
        DelayEqualBuildPlattons = {'MexLand2', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'MexLand2' }},
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 150, -500, 100, 0, 'AntiSurface', 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = true,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer 300 Mex',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 82,
        InstanceCount = 2,
        DelayEqualBuildPlattons = {'MexLand2', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'MexLand2' }},
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 300, -500, 150, 0, 'AntiSurface', 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = true,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer 450 Mex',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 81,
        InstanceCount = 2,
        DelayEqualBuildPlattons = {'MexLand2', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'MexLand2' }},
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 450, -500, 200, 0, 'AntiSurface', 1 }},         
            },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = true,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },  
    Builder {
        BuilderName = 'SCTAAI T2Engineer Mex',
        PlatoonTemplate = 'EngineerBuilderSCTA23All',
        Priority = 103,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        DelayEqualBuildPlattons = {'Mex2', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Mex2' }},
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 100, -500, 100, 0, 'AntiSurface', 1 }},
        },
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
    Builder {
        BuilderName = 'SCTAAI T2Engineer 250 Mex',
        PlatoonTemplate = 'EngineerBuilderSCTA23All',
        Priority = 101,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        DelayEqualBuildPlattons = {'Mex2', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Mex2' }},
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 250, -500, 100, 0, 'AntiSurface', 1 }},
        },
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
    Builder {
        BuilderName = 'SCTAAI T1Engineer Hydro',
        PlatoonTemplate = 'EngineerBuilderSCTAALL',
        Priority = 171,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        DelayEqualBuildPlattons = {'Hydro', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Hydro' }},
            { MIBC, 'LessThanGameTime', {360} }, 
            { MABC, 'MarkerLessThanDistance',  { 'Hydrocarbon', 25}},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildStructures = {
                    'T1HydroCarbon',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer Hydro2',
        PlatoonTemplate = 'EngineerBuilderSCTAALL',
        Priority = 99,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        DelayEqualBuildPlattons = {'Hydro', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Hydro' }},
            { MABC, 'MarkerLessThanDistance',  { 'Hydrocarbon', 150}},
            { TAutils , 'LessThanEconEnergyTAEfficiency', {1.05 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            NumAssistees = 2,
            DesiresAssist = true,
            Construction = {
                BuildStructures = {
                    'T1HydroCarbon',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer Pgen',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 98,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, FUSION} },
            { TAutils , 'LessThanEconEnergyTAEfficiency', {0.9}},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1EnergyProduction',
                }
            }
        }
    },  
    Builder {
        BuilderName = 'SCTAAI T1Engineer Pgen2',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 102,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, FUSION} },
            { TAutils , 'LessThanEconEnergyTAEfficiency', {0.9 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1EnergyProduction2',
                }
            }
        }
    },  
    Builder {
        BuilderName = 'SCTAAI T2Engineer Pgen',
        PlatoonTemplate = 'EngineerBuilderSCTA23All',
        Priority = 131,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, FUSION} },
            { EBC, 'GreaterThanEconStorageCurrent', { 500, 1000 } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, FUSION} },
        },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = true,
            NumAssistees = 2,
            NeedGuard = false,
            Construction = {
                BuildStructures = {
                    'T2EnergyProduction',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T2Engineer2 Pgen',
        PlatoonTemplate = 'EngineerBuilderSCTA23All',
        Priority = 127,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.TECH3 * categories.ENERGYPRODUCTION * categories.STRUCTURE} },
            { TAutils , 'LessThanEconEnergyTAEfficiency', {1.05 }},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, FUSION} },
        },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = true,
            NumAssistees = 2,
            NeedGuard = false,
            Construction = {
                BuildStructures = {
                    'T2EnergyProduction',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T3Engineer Pgen',
        PlatoonTemplate = 'EngineerBuilderSCTA3',
        Priority = 175,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, FUSION} },
            { TAutils , 'LessThanEconEnergyTAEfficiency', {1.05 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildStructures = {
                    'T3EnergyProduction',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI MetalMaker',
        PlatoonTemplate = 'EngineerBuilderSCTAALL',
        Priority = 127,
        InstanceCount = 3,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1,  FUSION} }, 
            { TAutils, 'GreaterThanEconEnergyTAEfficiency', {0.9 }},
            { TAutils, 'LessMassStorageMaxTA',  { 0.3}},
        },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2MassCreation',
                }
            }
        }
    },
    ---AIREco
    Builder {
        BuilderName = 'SCTAAI T1Engineer Air 850 Mex',
        PlatoonTemplate = 'EngineerBuilderSCTAEco',
        Priority = 94,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'MexLand2', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'MexLand2' }},
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 250, -500, 200, 0, 'AntiAir', 1 }},
            },
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
        BuilderName = 'SCTAAI T1Engineer Air Pgen',
        PlatoonTemplate = 'EngineerBuilderSCTAEco',
        Priority = 125,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, FUSION} },
            { TAutils , 'LessThanEconEnergyTAEfficiency', {1.05 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1EnergyProduction2',
                }
            }
        }
    },
}