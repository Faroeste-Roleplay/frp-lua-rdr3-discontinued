local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

-- local plants = {
-- "CRP_ARTICHOKE_AA_SIM",
-- "CRP_BROCCOLI_AA_SIM",
-- "CRP_CARROTS_AA_SIM",
-- "CRP_CORNSTALKS_AA_SIM",
-- "CRP_CORNSTALKS_AB_SIM",
-- "CRP_CORNSTALKS_AC_SIM",
-- "CRP_CORNSTALKS_BA_SIM",
-- "CRP_CORNSTALKS_BB_SIM",
-- "CRP_CORNSTALKS_BC_SIM",
-- "CRP_CORNSTALKS_BD_SIM",
-- "CRP_CORNSTALKS_CA_SIM",
-- "CRP_CORNSTALKS_CB_SIM",
-- "CRP_CORNSTALKS_CC_SIM",
-- "CRP_CORNSTALKS_CD",
-- "CRP_COTTON_AD_SIM",
-- "CRP_COTTON_BA_SIM",
-- "CRP_COTTON_BB_SIM",
-- "CRP_COTTON_BC_SIM",
-- "CRP_COTTON_BD_SIM",
-- "CRP_COTTON_BE_SIM",
-- "CRP_COTTON_PLANT_AF_P",
-- "CRP_SUGARCANE_AE_P",
-- "CRP_SUGARCANE_AF_P",
-- "CRP_TOBACCOPLANT_AA_SIM",
-- "CRP_TOBACCOPLANT_AB_SIM",
-- "CRP_TOBACCOPLANT_AC_SIM"
-- "CRP_TOBACCOPLANT_BA_SIM",
-- "CRP_TOBACCOPLANT_BB_SIM",
-- "CRP_TOBACCOPLANT_BC_SIM",
-- "CRP_WHEAT_STK_AB_SIM"
-- }

local spotsData = {}

local registeredFarmAreas = {}
local spotsToDraw = {}
local drawnObjects = {}

local computedSpots = {}

local tempPlacementObject
local tempPlacementSeedType
local insideFarmAreaId

AddEventHandler(
    "FRP:AREA:PlayerEnteredArea",
    function(areaId)
        -- print("Entrou " .. areaId)
        if areaId == "tobacco" or areaId == "corn" or areaId == "sugarcane" then
            insideFarmAreaId = areaId
            TriggerServerEvent("FRP:FARM:AskForFarmsInfo", areaId)
        end
    end
)

AddEventHandler(
    "FRP:AREA:PlayerLeftArea",
    function(areaId)
        -- print("Saiu " .. areaId)
        if areaId == "tobacco" or areaId == "corn" or areaId == "sugarcane" then
            insideFarmAreaId = nil
            spotsData[areaId] = nil

            if drawnObjects[areaId] ~= nil then
                for _, object in pairs(drawnObjects[areaId]) do
                    SetEntityAsMissionEntity(object, true, true)
                    DeleteObject(object)
                end
                drawnObjects[areaId] = nil
            end
        end
    end
)

RegisterNetEvent("FRP:FARM:SetFarmsInfo")
AddEventHandler(
    "FRP:FARM:SetFarmsInfo",
    function(farmAreaId, info)
        spotsData[farmAreaId] = info
        renderSpots(farmAreaId)
    end
)

RegisterNetEvent("FRP:FARM:SetSpot")
AddEventHandler(
    "FRP:FARM:SetSpot",
    function(farmAreaId, spotId, percentGrown)
        if drawnObjects[farmAreaId] then
            if drawnObjects[farmAreaId][spotId] then
                SetEntityAsMissionEntity(drawnObjects[farmAreaId][spotId], true, true)
                DeleteObject(drawnObjects[farmAreaId][spotId])
                drawnObjects[farmAreaId][spotId] = nil
            end
        end

        if percentGrown ~= nil then
            spotsData[farmAreaId][spotId] = {percentGrown}

            if percentGrown > 0 then
                if drawnObjects[farmAreaId] then
                    local type = getFarmAreaType(farmAreaId)
                    local model = getRightCropModel(type, percentGrown)

                    if not HasModelLoaded(model) then
                        RequestModel(model)
                        while not HasModelLoaded(model) do
                            Citizen.Wait(10)
                        end
                    end

                    local object = CreateObject(model, spotsToDraw[farmAreaId][spotId], false, true, false, false, true)
                    drawnObjects[farmAreaId][spotId] = object

                    -- SetModelAsNoLongerNeeded(model)
                end
            end
        else
            if spotsData[farmAreaId] ~= nil and spotsData[farmAreaId][spotId] ~= nil then
                spotsData[farmAreaId][spotId] = nil
            end
        end
    end
)

RegisterNetEvent("FRP:FARM:StartPlacingSeed")
AddEventHandler(
    "FRP:FARM:StartPlacingSeed",
    function(seedType)
        -- TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_BUCKET_POUR_LOW'), 3000, true, false, false, false)

        if tempPlacementObject ~= nil then
            DeleteObject(tempPlacementObject)
        end

        tempPlacementSeedType = seedType

        local model = getRightCropModel(seedType, nil)
        if not HasModelLoaded(model) then
            RequestModel(model)
            while not HasModelLoaded(model) do
                Citizen.Wait(10)
            end
        end

        tempPlacementObject = CreateObject(model, GetEntityCoords(PlayerPedId()), false, true, false)

        -- SetModelAsNoLongerNeeded(model)
    end
)

function renderSpots(areaId)
    local numSpots = farmsRows[areaId].numSpots
    local type = getFarmAreaType(areaId)

    local dObjects = drawnObjects[areaId] or {}
    local newSpots = {}

    if computedSpots[areaId] == nil then
        local atSpotId = 1
        for _, v in pairs(farmsRows[areaId]) do
            if tonumber(_) ~= nil then
                local a = v[1]
                local b = v[2]

                local d = math.sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y)) / numSpots
                local fi = math.atan2(b.y - a.y, b.x - a.x)

                for i = 0, numSpots do
                    local x = a.x + i * d * math.cos(fi)
                    local y = a.y + i * d * math.sin(fi)
                    local _, z, _ = GetGroundZAndNormalFor_3dCoord(x, y, a.z)

                    local vec = vec3(x, y, z)

                    newSpots[atSpotId] = vec
                    atSpotId = atSpotId + 1
                end
            end
        end
        computedSpots[areaId] = newSpots
    else
        newSpots = computedSpots[areaId]
    end

    local loadedModels = {}

    for spotId, vec in pairs(newSpots) do
        if spotsData[areaId] ~= nil and spotsData[areaId][spotId] ~= nil then
            local percentGrown = spotsData[areaId][spotId][1]
            if percentGrown > 0 then

                local model = getRightCropModel(type, percentGrown)
                if not HasModelLoaded(model) then
                    RequestModel(model)
                    table.insert(loadedModels, model)
                    while not HasModelLoaded(model) do
                        Citizen.Wait(10)
                    end
                end

                local object = CreateObject(model, vec, false, true, false, false, true)
                dObjects[spotId] = object
            end
        end
    end

    for _, model in pairs(loadedModels) do
        -- SetModelAsNoLongerNeeded(model)
    end

    loadedModels = nil

    -- print("rows: " .. #farmsRows[areaId], "per row: " .. numSpots, "total: " .. #farmsRows[areaId] * numSpots)

    spotsToDraw[areaId] = newSpots
    drawnObjects[areaId] = dObjects
end

Citizen.CreateThread(
    function()
        registerFarmAreas()

        local aimMaxDistance = 7
        local upVector = vec3(0, 0, 0.5)

        local aimingAtSpotId

        while true do
            Citizen.Wait(0)

            -- if #spotsData > 0 then
            if insideFarmAreaId ~= nil then
                local ped = PlayerPedId()

                local pedVector = GetEntityCoords(ped)

                local cameraRotation = GetGameplayCamRot()
                local cameraCoord = GetGameplayCamCoord()
                local direction = RotationToDirection(cameraRotation)
                local aimingAtVector = vec3(cameraCoord.x + direction.x * aimMaxDistance, cameraCoord.y + direction.y * aimMaxDistance, cameraCoord.z + direction.z * aimMaxDistance)

                local rayHandle = StartShapeTestRay(pedVector, aimingAtVector, 1, ped, 0)
                local _, hit, endCoords, _, _ = GetShapeTestResult(rayHandle)

                if hit == 1 then
                    aimingAtVector = endCoords
                end

                local placeFakeEntityAt = aimingAtVector

                aimingAtSpotId = nil

                for areaId, spots in pairs(spotsToDraw) do
                    for spotId, spotVector in pairs(spots) do
                        local dist = #(aimingAtVector - spotVector)
                        if dist <= 10.0 then
                            if dist <= 0.5 then
                                placeFakeEntityAt = spotVector
                                aimingAtSpotId = spotId
                            end

                            -- if tempPlacementObject ~= nil then
                                if spotsData[areaId] == nil or spotsData[areaId][spotId] == nil then
                                    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, spotVector, spotVector + upVector, 153, 153, 153, 255)
                                else
                                -- if spotsData[areaId] ~= nil and spotsData[areaId][spotId] ~= nil and spotsData[areaId][spotId][1] == 0 then
                                    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, spotVector, spotVector + upVector, 230, 122, 122, 255)
                                -- end
                                end
                            -- end
                        end
                    end
                end

                if aimingAtSpotId ~= nil then
                    if spotsData[insideFarmAreaId] ~= nil and spotsData[insideFarmAreaId][aimingAtSpotId] ~= nil then
                        local growPercentage = spotsData[insideFarmAreaId][aimingAtSpotId][1]
                        if growPercentage < 99 then
                            -- DisplayText("Crescimento " .. growPercentage .. "%", 0.5, 0.5)
                            -- PromptSetActiveGroupThisFrame(1, CreateVarString(10, "LITERAL_STRING", growPercentage.. "%"))
                        else
                            -- if growPercentage <= 100 then
                                DisplayText("Pronto para colher", 0.5, 0.5)
                            -- end
                        end
                        if tempPlacementObject == nil and IsControlJustPressed(1, 0xF84FA74F) then
                            if growPercentage < 99 then

                                local offset = GetObjectOffsetFromCoords(placeFakeEntityAt, 180.0, 0.5, 0.0, 0.0)
                                local hasCollision, groundZ, normal = GetGroundZAndNormalFor_3dCoord(offset.x, offset.y, offset.z)

                                if hasCollision then
                                    offset = vec3(offset.xy, groundZ)
                                end

                                if NativeFindClosestActiveScenarioPointOfType(offset,GetHashKey("WORLD_PLAYER_CHORES_BUCKET_PICKUP_FULL"), 1.0) == 0 then
                                local scenario_pickup = NativeCreateScenarioPoint(GetHashKey("WORLD_PLAYER_CHORES_BUCKET_PICKUP_FULL"), offset)

                                Citizen.CreateThread(function()
                                    local canPour = false
                                    local isPouring = false
                                    local scenario_pour 
                                    while true do
                                        Citizen.Wait(0)
                                        
                                        if canPour == false then
                                            if  NativeGetScenarioPointPedIsUsing(ped) == scenario_pickup then
                                                scenario_pour = NativeCreateScenarioPoint(GetHashKey("WORLD_PLAYER_CHORES_BUCKET_POUR_LOW"), placeFakeEntityAt)
                                                canPour = true
                                            end
                                        else
                                        if isPouring == false then
                                            if  NativeGetScenarioPointPedIsUsing(ped) == scenario_pour then
                                                isPouring = true
                                            end
                                        else
                                            if  NativeGetScenarioPointPedIsUsing(ped) ~= scenario_pour then
                                                    ClearPedTasks(ped)
                                                    SetCurrentPedWeapon(ped, GetHashKey('weapon_unarmed'), true)
                                                    TriggerServerEvent("FRP:FARM:TryToWaterCrop", insideFarmAreaId, aimingAtSpotId)
                                                break
                                            end
                                        end
                                    end
                                    end
                                end)

                                Citizen.CreateThread(function()
                                    Citizen.Wait(60000)
                                    if NativeDoesScenarioPointExist(scenario) or  NativeDoesScenarioPointExist(scenario2) then
                                        NativeDeleteScenarioPoint(scenario)
                                        NativeDeleteScenarioPoint(scenario2)
                                    end
                                end)

                            end
                            else
                                -- if growPercentage <= 100 then
                                    TriggerServerEvent("FRP:FARM:TryToHarvestCrop", insideFarmAreaId, aimingAtSpotId)
                                -- end
                            end
                        end
                    else
                        Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, placeFakeEntityAt, placeFakeEntityAt + upVector, 252, 180, 131, 255)
                    end
                end

                if tempPlacementObject ~= nil then
                    SetEntityCoords(tempPlacementObject, placeFakeEntityAt, 0, 0, 0, 0)
                end

                Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, pedVector, placeFakeEntityAt, 255, 255, 255, 35)

                if tempPlacementObject ~= nil then
                    if IsControlJustPressed(1, 0x07CE1E61) then -- LMB
                        if aimingAtSpotId ~= nil and (spotsData[insideFarmAreaId] == nil or spotsData[insideFarmAreaId][aimingAtSpotId] == nil) then
                            SetEntityAsMissionEntity(tempPlacementObject, true, true)
                            DeleteObject(tempPlacementObject)
                            tempPlacementObject = nil

                            TaskStartScenarioAtPosition(ped, GetHashKey("WORLD_HUMAN_FARMER_WEEDING"), placeFakeEntityAt, GetEntityHeading(ped), 0, 1, 0, 0, 0)

                            Citizen.Wait(5000)

                            ClearPedTasks(ped)
                            SetCurrentPedWeapon(ped, GetHashKey('weapon_unarmed'), true)

                            TriggerServerEvent("FRP:FARM:TryToPlantSeed", tempPlacementSeedType, insideFarmAreaId, aimingAtSpotId)
                        end
                    else
                        if IsControlJustPressed(1, 0xF84FA74F) then -- RMB
                            SetEntityAsMissionEntity(tempPlacementObject, true, true)
                            DeleteObject(tempPlacementObject)
                            tempPlacementObject = nil
                        end
                    end
                end
            end
        end
    end
)

function registerFarmAreas()
    local tobbaco =
        cAPI.RegisterArea(
        "tobacco",
        {
            height = 4.0,
            color = {255, 0, 0, 60},
            -- threshold = 3.25,
            vec3(1226.5939941406, -1946.9085693359, 53.168365478516),
            vec3(1169.5446777344, -1945.1711425781, 47.385631561279),
            vec3(1165.0754394531, -1853.7674560547, 47.359714508057),
            vec3(1227.9428710938, -1851.642578125, 53.084655761719)
        }
    )

    local corn =
        cAPI.RegisterArea(
        "corn",
        {
            height = 3.5,
            color = {255, 0, 0, 60},
            vec3(933.54016113281, -2022.3217773438, 43.973258972168),
            vec3(1005.2134399414, -2008.4283447266, 46.51021194458),
            vec3(1017.6409912109, -1870.9841308594, 43.688522338867),
            vec3(939.23114013672, -1859.7126464844, 44.988395690918)
        }
    )

    local sugarcane =
        cAPI.RegisterArea(
        "sugarcane",
        {
            height = 3.5,
            color = {255, 0, 0, 60},
            vec3(1126.8572998047, -1475.6580810547, 52.427513122559),
            vec3(1007.4481201172, -1478.3896484375, 47.936859130859),
            vec3(1012.4561767578, -1556.0417480469, 46.178905487061),
            vec3(1133.5802001953, -1543.4616699219, 50.969917297363)
        }
    )

    registeredFarmAreas["tobacco"] = tobacco
    registeredFarmAreas["corn"] = corn
    registeredFarmAreas["sugarcane"] = sugarcane

    -- Citizen.CreateThread(
    --     function()
    --         while true do
    --             Citizen.Wait(0)
    --             tobacco.draw()
    --             corn.draw()
    --             sugarcane.draw()
    --         end
    --     end
    -- )
end

function RotationToDirection(rotation)
    local adjustedRotation = {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    local direction = {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }
    return direction
end

function getRightCropModel(type, percentGrown)
    local r

    if type == "tobacco" then
        r = "CRP_TOBACCOPLANT_AC_SIM"

        if percentGrown ~= nil then
            if percentGrown >= 25 then
                r = "CRP_TOBACCOPLANT_AA_SIM"
            end
            if percentGrown >= 50 then
                r = "CRP_TOBACCOPLANT_AB_SIM"
            end
            if percentGrown >= 70 then
                r = "CRP_TOBACCOPLANT_AC_SIM"
            end
        end
    end

    if type == "corn" then
        r = "CRP_CORNSTALKS_BC_SIM"
        if percentGrown ~= nil then
            if percentGrown >= 25 then
                r =  "CRP_CORNSTALKS_BB_SIM"
            end
            if percentGrown >= 50 then
                r =  "CRP_CORNSTALKS_BD_SIM"
            end
            if percentGrown >= 70 then
                r =  "CRP_CORNSTALKS_BC_SIM"
            end
        end
    end

    if type == "sugarcane" then
        r = "CRP_SUGARCANE_AD_SIM"
        if percentGrown ~= nil then
            if percentGrown >= 25 then
                r = "CRP_SUGARCANE_AB_SIM"
            end
            if percentGrown >= 50 then
                r = "CRP_SUGARCANE_AC_SIM"
            end
            if percentGrown >= 70 then
                r = "CRP_SUGARCANE_AD_SIM"
            end
            -- if percentGrown > 100 then
            --     r = "CRP_SUGARCANE_AE_P"
            -- end
        end
    end

    return r
end

function getFarmAreaType(farmAreaId)
    local farmtype = farmAreaId
    return farmtype
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            for _, objects in pairs(drawnObjects) do
                for _, object in pairs(objects) do
                    SetEntityAsMissionEntity(object, true, true)
                    DeleteObject(object)
                end
            end
            SetEntityAsMissionEntity(tempPlacementObject, true, true)
            DeleteObject(tempPlacementObject)
        end
    end
)



-- function spawnBuckets()

-- end

-- local ownedScenarios = {}


function NativeCreateScenarioPoint(scenarioType , position)
    local scenario = Citizen.InvokeNative(0x94B745CE41DB58A1, scenarioType, position, 180.0, 0.0, 0.0, 0)
    -- table.insert(ownedScenarios, scenario)
    return scenario
end

function NativeDeleteScenarioPoint(scenario)
    Citizen.InvokeNative(0x81948DFE4F5A0283, scenario)
end

function NativeDoesScenarioPointExist(scenario)
    return Citizen.InvokeNative(0x841475AC96E794D1 , scenario)
end

function NativeGetPedUsingScenarioPoint(scenario)
    return Citizen.InvokeNative(0x5BA659955369B0E2, scenario)
end

function NativeGetScenarioPointPedIsUsing(ped)
    return Citizen.InvokeNative(0xDF7993356F52359A, ped)
end

function NativeFindClosestActiveScenarioPointOfType(position, type, distance)
    return Citizen.InvokeNative(0xF533D68FF970D190 , position, type, distance, 0, 0, Citizen.ResultAsInteger())
end
-- AddEventHandler(
--     "onResourceStart",
--     function(resourceName)
--         if resourceName == GetCurrentResourceName() then
--             for _, scenario in pairs(ownedScenarios) do
--                 NativeDeleteScenarioPoint(scenario)
--             end
--         end
--     end
-- )