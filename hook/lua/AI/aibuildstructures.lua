WARN('['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] * SCTAAI: offset aibuildstructures.lua' )

TAAIBuildAdjacency = AIBuildAdjacency
TAAIMaintainBuildList = AIMaintainBuildList

function AIExecuteBuildStructureSCTAAI(aiBrain, builder, buildingType, closeToBuilder, relative, buildingTemplate, baseTemplate, reference, NearMarkerType)
    local factionIndex = aiBrain:GetFactionIndex()
    local whatToBuild = aiBrain:DecideWhatToBuild( builder, buildingType, buildingTemplate)
    if not whatToBuild then
        return
    end
    local relativeTo
    if closeToBuilder then
        relativeTo = closeToBuilder:GetPosition()
    elseif builder.BuilderManagerData and builder.BuilderManagerData.EngineerManager then
        relativeTo = builder.BuilderManagerData.EngineerManager:GetLocationCoords()
    else
        local startPosX, startPosZ = aiBrain:GetArmyStartPos()
        relativeTo = {startPosX, 0, startPosZ}
    end
    local location = false
    if IsResource(buildingType) then
        location = aiBrain:FindPlaceToBuild(buildingType, whatToBuild, baseTemplate, relative, closeToBuilder, 'Enemy', relativeTo[1], relativeTo[3], 5)
    else
        location = aiBrain:FindPlaceToBuild(buildingType, whatToBuild, baseTemplate, relative, closeToBuilder, nil, relativeTo[1], relativeTo[3])
    end
    if not location and reference then
        for num,offsetCheck in RandomIter({1,2,3,4,5,6,7,8}) do
            location = aiBrain:FindPlaceToBuild( buildingType, whatToBuild, BaseTmplFile['MovedTemplates'..offsetCheck][factionIndex], relative, closeToBuilder, nil, relativeTo[1], relativeTo[3])
            if location then
                break
            end
        end
    end
    if location then
        local relativeLoc = BuildToNormalLocation(location)
        if relative then
            relativeLoc = {relativeLoc[1] + relativeTo[1], relativeLoc[2] + relativeTo[2], relativeLoc[3] + relativeTo[3]}
        end
        AddToBuildQueue(aiBrain, builder, whatToBuild, NormalToBuildLocation(relativeLoc), false)
        return
    end
end

function AIBuildBaseTemplateSCTAAI(aiBrain, builder, buildingType , closeToBuilder, relative, buildingTemplate, baseTemplate, reference, NearMarkerType)
    local whatToBuild = aiBrain:DecideWhatToBuild(builder, buildingType, buildingTemplate)
    if whatToBuild then
        for _,bType in baseTemplate do
            for n,bString in bType[1] do
                AIExecuteBuildStructureSCTAAI(aiBrain, builder, buildingType , closeToBuilder, relative, buildingTemplate, baseTemplate, reference)

                return DoHackyLogic(buildingType, builder)
            end
        end
    end
end

function AIBuildAdjacency( aiBrain, builder, buildingType , closeToBuilder, relative, buildingTemplate, baseTemplate, reference, NearMarkerType)
    if not aiBrain.SCTAAI then
        return TAAIBuildAdjacency( aiBrain, builder, buildingType , closeToBuilder, relative, buildingTemplate, baseTemplate, reference, NearMarkerType)
    end
    AIExecuteBuildStructureSCTAAI( aiBrain, builder, buildingType, builder, false,  buildingTemplate, baseTemplate )
end


function AIBuildBaseTemplateOrderedSCTAAI(aiBrain, builder, buildingType , closeToBuilder, relative, buildingTemplate, baseTemplate, reference, NearMarkerType)
    local factionIndex = aiBrain:GetFactionIndex()
    local whatToBuild = aiBrain:DecideWhatToBuild(builder, buildingType, buildingTemplate)
    if whatToBuild then
        if IsResource(buildingType) then
            return AIExecuteBuildStructureSCTAAI(aiBrain, builder, buildingType , closeToBuilder, relative, buildingTemplate, baseTemplate, reference)
        else
            for l,bType in baseTemplate do
                for m,bString in bType[1] do
                    if bString == buildingType then
                        for n,position in bType do
                            if n > 1 and aiBrain:CanBuildStructureAt(whatToBuild, BuildToNormalLocation(position)) then
                                 AddToBuildQueue(aiBrain, builder, whatToBuild, position, false)
                                 return DoHackyLogic(buildingType, builder)
                            end 
                        end 
                        break
                    end
                end 
            end 
        end 
    end
    return 
end


function AIMaintainBuildList(aiBrain, builder, buildingTemplate, brainBaseTemplate)
    if not aiBrain.SCTAAI then
        return TAAIMaintainBuildList(aiBrain, builder, buildingTemplate, brainBaseTemplate)
    end
    if not buildingTemplate then
        buildingTemplate = BuildingTemplates[aiBrain:GetFactionIndex()]
    end
    for k,v in brainBaseTemplate.List do
        if builder:CanBuild(v.StructureCategory) then
            if v.StructureType == 'Resource' or v.StructureType == 'T1HydroCarbon' or v.StructureType == 'T1Resource'
                or v.StructureType == 'T2Resource' or v.StructureType == 'T3Resource' then
                for l,type in brainBaseTemplate.Template do
                    if type[1][1] == v.StructureType then
                        for m,location in type do
                            if m > 1 then
                                if aiBrain:CanBuildStructureAt(v.StructureCategory, BuildToNormalLocation(location)) then
                                    IssueStop({builder})
                                    IssueClearCommands({builder})
                                    aiBrain:BuildStructure(builder, v.StructureCategory, location, false)
                                    return true
                                end
                            end
                        end
                    end
                end
            elseif aiBrain:FindPlaceToBuild(v.StructureType, v.StructureCategory,  brainBaseTemplate.Template, false, v.CloseToBuilder) then
                IssueStop({builder})
                IssueClearCommands({builder})
                if AIExecuteBuildStructureSCTAAI(aiBrain, builder, v.StructureType , v.CloseToBuilder, false, buildingTemplate, brainBaseTemplate.Template) then
                    return true
                end
            end
        end
    end
    return false
end

--[[local factionIndex = aiBrain:GetFactionIndex()
local whatToBuild = aiBrain:DecideWhatToBuild(builder, buildingType, buildingTemplate)
local FactionIndexToName = {[1] = 'UEF', [2] = 'AEON', [3] = 'CYBRAN', [4] = 'SERAPHIM', [5] = 'NOMADS', [6] = 'ARM', [7] = 'CORE' }
local AIFactionName = FactionIndexToName[factionIndex] or 'Unknown'
-- If the c-engine can't decide what to build, then search the build template manually.
if not whatToBuild then
    if AntiSpamList[buildingType] then
        return false
    end
    SPEW('* SCTAAI: AIExecuteBuildStructureSCTAAI: c-function DecideWhatToBuild() failed! - AI-faction: index('..factionIndex..') '..AIFactionName..', Building Type: '..repr(buildingType)..', engineer-faction: '..repr(builder.factionCategory))
    -- Get the UnitId for the actual buildingType
    if not buildingTemplate then
        WARN('* SCTAAI: AIExecuteBuildStructureSCTAAI: Function was called without a buildingTemplate!')
    end
    local BuildUnitWithID
    for Key, Data in buildingTemplate do
        if Data[1] and Data[2] and Data[1] == buildingType then
            SPEW('* SCTAAI: AIExecuteBuildStructureSCTAAI: Found template: '..repr(Data[1])..' - Using UnitID: '..repr(Data[2]))
            BuildUnitWithID = Data[2]
            break
        end
    end
    -- If we can't find a template, then return
    if not BuildUnitWithID then
        AntiSpamList[buildingType] = true
        WARN('* SCTAAI: AIExecuteBuildStructureSCTAAI: No '..repr(builder.factionCategory)..' unit found for template: '..repr(buildingType)..'! ')
        return false
    end
    -- get the needed tech level to build buildingType
    -- get the actual tech level from the builder
    HasFaction = builder.factionCategory
    NeedFaction = string.upper(__blueprints[string.lower(BuildUnitWithID)].General.FactionName)
    if HasFaction ~= NeedFaction then
        WARN('* SCTAAI: AIExecuteBuildStructureSCTAAI: AI-faction: '..AIFactionName..', ('..HasFaction..') engineers can\'t build ('..NeedFaction..') structures!')
        return false
    else
        SPEW('* SCTAAI: AIExecuteBuildStructureSCTAAI: AI-faction: '..AIFactionName..', Engineer with faction ('..HasFaction..') can build faction ('..NeedFaction..') - BuildUnitWithID: '..repr(BuildUnitWithID))
    end
   
    local IsRestricted = import('/lua/game.lua').IsRestricted
    if IsRestricted(BuildUnitWithID, GetFocusArmy()) then
        WARN('* SCTAAI: AIExecuteBuildStructureSCTAAI: Unit is Restricted!!! Building Type: '..repr(buildingType)..', faction: '..repr(builder.factionCategory)..' - Unit:'..BuildUnitWithID)
        AntiSpamList[buildingType] = true
        return false
    end

    whatToBuild = BuildUnitWithID
    --return false
else
    -- Sometimes the AI is building a unit that is different from the buildingTemplate table. So we validate the unitID here.
    -- Looks like it never occurred, or i missed the warntext. For now, we don't need it
    for Key, Data in buildingTemplate do
        if Data[1] and Data[2] and Data[1] == buildingType then
            if whatToBuild ~= Data[2] then
                WARN('* SCTAAI: AIExecuteBuildStructureSCTAAI: Missmatch whatToBuild: '..whatToBuild..' ~= buildingTemplate.Data[2]: '..repr(Data[2]))
                whatToBuild = Data[2]
            end
            break
        end
    end
end
-- find a place to build it (ignore enemy locations if it's a resource)
-- build near the base the engineer is part of, rather than the engineer location
local relativeTo
if closeToBuilder then
    relativeTo = builder:GetPosition()
    --LOG('* SCTAAI: AIExecuteBuildStructureSCTAAI: Searching for Buildplace near Engineer'..repr(relativeTo))
else
    if builder.BuilderManagerData and builder.BuilderManagerData.EngineerManager then
        relativeTo = builder.BuilderManagerData.EngineerManager.Location
        --LOG('* SCTAAI: AIExecuteBuildStructureSCTAAI: Searching for Buildplace near BuilderManager ')
    else
        local startPosX, startPosZ = aiBrain:GetArmyStartPos()
        relativeTo = {startPosX, 0, startPosZ}
        --LOG('* SCTAAI: AIExecuteBuildStructureSCTAAI: Searching for Buildplace near ArmyStartPos ')
    end
end
local location = false
local buildingTypeReplace
local whatToBuildReplace


if IsResource(buildingType) then
    location = aiBrain:FindPlaceToBuild(buildingType, whatToBuild, baseTemplate, relative, closeToBuilder, 'Enemy', relativeTo[1], relativeTo[3], 5)
else
    location = aiBrain:FindPlaceToBuild(buildingTypeReplace or buildingType, whatToBuildReplace or whatToBuild, baseTemplate, relative, closeToBuilder, nil, relativeTo[1], relativeTo[3])
end

-- if it's a reference, look around with offsets
if not location and reference then
    for num,offsetCheck in RandomIter({1,2,3,4,5,6,7,8}) do
        location = aiBrain:FindPlaceToBuild(buildingTypeReplace or buildingType, whatToBuildReplace or whatToBuild, BaseTmplFile['MovedTemplates'..offsetCheck][factionIndex], relative, closeToBuilder, nil, relativeTo[1], relativeTo[3])
        if location then
            break
        end
    end
end

-- fallback in case we can't find a place to build with experimental template
if not location and not IsResource(buildingType) then
    location = aiBrain:FindPlaceToBuild(buildingType, whatToBuild, baseTemplate, relative, closeToBuilder, nil, relativeTo[1], relativeTo[3])
end

-- fallback in case we can't find a place to build with experimental template
if not location and not IsResource(buildingType) then
    for num,offsetCheck in RandomIter({1,2,3,4,5,6,7,8}) do
        location = aiBrain:FindPlaceToBuild(buildingType, whatToBuild, BaseTmplFile['MovedTemplates'..offsetCheck][factionIndex], relative, closeToBuilder, nil, relativeTo[1], relativeTo[3])
        if location then
            break
        end
    end
end
if location then
    local relativeLoc = BuildToNormalLocation(location)
    if relative then
        relativeLoc = {relativeLoc[1] + relativeTo[1], relativeLoc[2] + relativeTo[2], relativeLoc[3] + relativeTo[3]}
    end
    -- put in build queue.. but will be removed afterwards... just so that it can iteratively find new spots to build
    --LOG('* SCTAAI: AIExecuteBuildStructureSCTAAI: AI-faction: index('..factionIndex..') '..repr(AIFactionName)..', Building Type: '..repr(buildingType)..', engineer-faction: '..repr(builder.factionCategory))
    AddToBuildQueue(aiBrain, builder, whatToBuild, NormalToBuildLocation(relativeLoc), false)
    return true
end
-- At this point we're out of options, so move on to the next thing
WARN('* SCTAAI: AIExecuteBuildStructureSCTAAI: c-function FindPlaceToBuild() failed! AI-faction: index('..factionIndex..') '..repr(AIFactionName)..', Building Type: '..repr(buildingType)..', engineer-faction: '..repr(builder.factionCategory))
return false

function AINewExpansionBase(aiBrain, baseName, position, builder, constructionData)
    if not aiBrain.SCTAAI then
        return TAAINewExpansionBase(aiBrain, baseName, position, builder, constructionData)
    end
    local radius = constructionData.ExpansionRadius or 100
    if aiBrain.HasPlatoonList then
        local expansionTypes = constructionData.ExpansionTypes
    if not expansionTypes then
        expansionTypes = { 'Air', 'Land', 'Sea', 'Gate' }
    end

        for k,v in aiBrain.PBM.Locations do
            if v.LocationType == baseName then
                return
            end
        end
        aiBrain:PBMAddBuildLocation(position, radius, baseName, true)

        for num, typeString in expansionTypes do
            for bNum, builder in aiBrain.PBM.Platoons[typeString] do
                if builder.LocationType == 'MAIN' and CheckExpansionType(typeString, ScenarioInfo.BuilderTable[typeString][builder.BuilderName].ExpansionExclude)  then
                    local pltnTable = {}
                    for dField, data in builder do
                        if dField == 'LocationType' then
                            pltnTable[dField] = baseName
                        elseif dField == 'PlatoonHandle' then
                            pltnTable[dField] = false
                        elseif dField == 'PlatoonTimeOutThread' then
                            pltnTable[dField] = nil
                        else
                            pltnTable[dField] = data
                        end
                    end
                    table.insert(aiBrain.PBM.Platoons[typeString], pltnTable)
                    aiBrain.PBM.NeedSort[typeString] = true
                end
            end
        end

    else
        if not aiBrain.BuilderManagers or aiBrain.BuilderManagers[baseName] or not builder.BuilderManagerData then
            #LOG('*AI DEBUG: ARMY ' .. aiBrain:GetArmyIndex() .. ': New Engineer for expansion base - ' .. baseName)
            builder.BuilderManagerData.EngineerManager:RemoveUnit(builder)
            aiBrain.BuilderManagers[baseName].EngineerManager:AddUnit(builder, true)
            return
        end

        aiBrain:AddBuilderManagers(position, radius, baseName, true)

        builder.BuilderManagerData.EngineerManager:RemoveUnit(builder)
        aiBrain.BuilderManagers[baseName].EngineerManager:AddUnit(builder, true)
        local baseValues = {}
        local highPri = false
        for templateName, baseData in BaseBuilderTemplates do
            local baseValue = baseData.TAExpansionFunction(aiBrain, position, constructionData.NearMarkerType)
            table.insert(baseValues, { Base = templateName, Value = baseValue })
            --SPEW('*AI DEBUG: AINewExpansionBase(): Scann next Base. baseValue= ' .. repr(baseValue) .. ' ('..repr(templateName)..')')
            if not highPri or baseValue > highPri then
                --SPEW('*AI DEBUG: AINewExpansionBase(): Possible next Base. baseValue= ' .. repr(baseValue) .. ' ('..repr(templateName)..')')
                highPri = baseValue
            end
        end

        local validNames = {}
        for k,v in baseValues do
            if v.Value == highPri then
                table.insert(validNames, v.Base)
            end
        end
        --SPEW('*AI DEBUG: AINewExpansionBase(): validNames for Expansions ' .. repr(validNames))
        local pick = validNames[ Random(1, table.getn(validNames)) ]

        if not pick then
            LOG('*AI DEBUG: ARMY ' .. aiBrain:GetArmyIndex() .. ': Layer Preference - ' .. per .. ' - yielded no base types at - ' .. locationType)
        end

        --SPEW('*AI DEBUG: AINewExpansionBase(): ARMY ' .. aiBrain:GetArmyIndex() .. ': Expanding using - ' .. pick .. ' at location ' .. baseName)
        import('/lua/ai/AIAddBuilderTable.lua').AddGlobalBaseTemplate(aiBrain, baseName, pick)

        
    end
end]]