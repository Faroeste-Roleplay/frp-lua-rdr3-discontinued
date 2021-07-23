local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local entity

local entityIndex

local entities = {}

local xAxis, yAxis, zAxis = 0.0, 0.0, 0.0

local cJSON = {}

local SELECTION_DISTANCE_THRESHOLD = 1.0

Citizen.CreateThread(
    function()
        ReadFromInput()

        local l_lookingAtPosition = vec3(0, 0, 0)
        local l_entity

        while true do
            Citizen.Wait(0)

            DisableControlAction(0, GetHashKey("INPUT_ATTACK"), true)
            DisableControlAction(0, GetHashKey("INPUT_AIM"), true)
            DisableControlAction(0, 0xDB096B85, true)

            if entity then
                -- DrawDimension(entity)

                local newEntityPosition = GetLookingAtPosition(7.0)

                local entityPosition = GetEntityCoords(entity)
                local entityModel = GetEntityModel(entity)

                local groundZ = GetGroundZAt(vec3(newEntityPosition.xy, 999))
                local lowestPoint = GetEntityLowestPoint(entity)

                local distance = #(l_lookingAtPosition - newEntityPosition)
                local hasMovedAConsiderableLenght = (distance > 0.14)

                l_lookingAtPosition = newEntityPosition

                -- if hasMovedAConsiderableLenght then

                EnableEntityPhysics(entity, false)

                if IsControlPressed(0, 0x430593AA) then
                    local pedRot = GetEntityHeading(entity) - 10
                    SetEntityHeading(entity, pedRot % 360)
                end

                if IsControlPressed(0, 0x3076E97C) then
                    local pedRot = GetEntityHeading(entity) + 10
                    SetEntityHeading(entity, pedRot % 360)
                end

                if IsDisabledControlPressed(0, 0xDB096B85) then
                    local min, max = GetModelDimensions(entityModel)

                    local collisionPosition = GetCollisionBetweenCoords(newEntityPosition, vec3(newEntityPosition.xy, groundZ))

                    collisionPosition = vec3(collisionPosition.xy, collisionPosition.z - ((max.z - min.z) / 2))

                    newEntityPosition = collisionPosition
                end

                SetEntityCoords(entity, newEntityPosition + vec3(0, 0, 0.15), xAxis, yAxis, zAxis, 0)

                if IsDisabledControlJustPressed(0, GetHashKey("INPUT_ATTACK")) then
                    local string_model = GetHashName(entityModel)

                    EnableEntityPhysics(entity, true)

                    local x, y, z = table.unpack(entityPosition)
                    local heading = GetEntityHeading(entity)

                    local data = {
                        position = {x, y, z},
                        rotation = heading,
                        entity = entity
                    }

                    if not entityIndex then
                        if not cJSON[string_model] then
                            cJSON[string_model] = {}
                        end

                        -- table.insert(entities, entity)
                        table.insert(cJSON[string_model], data)
                    else
                        entityIndex = nil
                    end

                    Citizen.InvokeNative(0x7DFB49BCDB73089A, entity, false)

                    CreateMyEntity(entityModel, lookingAtPosition)
                end

                if IsDisabledControlJustPressed(0, GetHashKey("INPUT_AIM")) then
                    if not entityIndex then
                    else
                        local string_model = GetHashName(entityModel)

                        if cJSON[string_model] then
                            table.remove(cJSON[string_model], entityIndex)
                        end

                        cAPI.notify("success", "Entidade removida!")
                    end

                    DeleteMyEntity()
                end
            else
                local lookingAtPosition = GetLookingAtPosition(7.0)

                local closestIndex
                local closestEntity
                local closestDistance

                for model, values in pairs(cJSON) do
                    for index, d in pairs(values) do
                        local ent = d.entity

                        if ent then
                            local distance = #(GetEntityCoords(ent) - lookingAtPosition)

                            if distance and distance <= SELECTION_DISTANCE_THRESHOLD then
                                if not closestDistance or distance < closestDistance then
                                    closestIndex = index
                                    closestEntity = ent
                                    closestDistance = distance
                                end
                            end
                        end
                    end
                end

                if closestIndex then
                    if l_entity and l_entity ~= closestEntity then
                        Citizen.InvokeNative(0x7DFB49BCDB73089A, l_entity, false)
                    end

                    l_entity = closestEntity
                    Citizen.InvokeNative(0x7DFB49BCDB73089A, l_entity, true)

                    if IsDisabledControlJustPressed(0, GetHashKey("INPUT_AIM")) then
                        Citizen.InvokeNative(0x7DFB49BCDB73089A, l_entity, false)
                        l_entity = nil

                        entity = closestEntity
                        entityIndex = closestIndex

                        Citizen.InvokeNative(0x7DFB49BCDB73089A, entity, true)

                        EnableEntityPhysics(entity, false)
                    end
                else
                    if l_entity then
                        Citizen.InvokeNative(0x7DFB49BCDB73089A, l_entity, false)
                        l_entity = nil
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            local playerPed = PlayerPedId()
            local playerPosition = GetEntityCoords(playerPed)

            for model, values in pairs(cJSON) do
                for index, d in pairs(values) do
                    local ent = d.entity
                    local x, y, z = table.unpack(d.position)

                    if #(playerPosition - vec3(x, y, z)) <= 50.0 then
                        if not DoesEntityExist(ent) then
                            local t_ent = CreateObject(model, x, y, z, true, true, true)
                            SetEntityHeading(t_ent, rotation)

                            cJSON[model][index].entity = t_ent
                            d.entity = t_ent
                        end
                    else
                        if ent then
                            if DoesEntityExist(ent) then
                                SetEntityAsMissionEntity(ent, true, true)
                                DeleteEntity(ent)
                            end

                            -- cJSON[model][index].entity = nil
                            d.entity = nil
                        end
                    end
                end
            end
        end
    end
)

RegisterCommand(
    "lpset",
    function(source, args, raw)
        local model = args[1]
        local modelHash = tonumber(model) == nil and model or tonumber(model)

        if not IsModelValid(modelHash) then
            cAPI.notify("error", "LootPlace: Model invalido!")
            return
        end

        local lookingAtPosition = GetLookingAtPosition(10.0)

        DeleteMyEntity()

        CreateMyEntity(modelHash, lookingAtPosition)
    end,
    false
)

RegisterCommand(
    "saveloot",
    function(source, args, raw)
        WriteToOutput()

        cAPI.notify("success", "LootPlace: Novos items salvos!")
    end,
    false
)

function CreateMyEntity(modelHash, position)
    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Citizen.Wait(0)
        end
    end

    entity = CreateObject(modelHash, position, true, true, true)

    EnableEntityPhysics(entity, false)

    Citizen.InvokeNative(0x7DFB49BCDB73089A, entity, true)
end

function DeleteMyEntity()
    if entity then
        SetEntityAsMissionEntity(entity, true, true)
        DeleteEntity(entity)

        entity = nil
    end
end

function GetLookingAtPosition(maxDistance)
    local ped = PlayerPedId()
    local pedVector = GetEntityCoords(ped)

    local cameraRotation = GetGameplayCamRot()
    local cameraCoord = GetGameplayCamCoord()

    local adjustedRotation = {
        x = (math.pi / 180) * cameraRotation.x,
        y = (math.pi / 180) * cameraRotation.y,
        z = (math.pi / 180) * cameraRotation.z
    }

    local direction = {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }

    local lastCoords = vec3(cameraCoord.x + direction.x * maxDistance, cameraCoord.y + direction.y * maxDistance, cameraCoord.z + direction.z * maxDistance)

    local rayHandle = StartShapeTestRay(cameraCoord, lastCoords, -1, ped, 0)
    local _, hit, endCoords, _, entityHit = GetShapeTestResult(rayHandle)

    if hit == 1 and entityHit ~= entity then
        lastCoords = endCoords
    end

    return lastCoords
end

function GetCollisionBetweenCoords(a, b)
    local rayHandle = StartShapeTestRay(a, b, -1, PlayerPedId(), 0)
    local _, hit, endCoords, _, entityHit = GetShapeTestResult(rayHandle)

    if hit == 1 then
        b = endCoords
    end

    return b
end

function GetGroundZAt(position)
    local _, groundZ, _ = GetGroundZAndNormalFor_3dCoord(position.x, position.y, position.z)

    return groundZ
end

function GetEntityLowestPoint(entity)
    local min, max = GetModelDimensions(GetEntityModel(entity))

    return GetOffsetFromEntityInWorldCoords(entity, min)
end

function ReadFromInput()
    local contents = LoadResourceFile(GetCurrentResourceName(), "save.json") or ""

    cJSON = json.decode(contents) or {}

    SpawnEntitiesAtJSON()
end

function WriteToOutput()
    local copy = deepcopy(cJSON)

    for model, values in pairs(copy) do
        for index, d in pairs(values) do
            if d.entity then
                d.entity = nil
            end
        end
    end

    TriggerServerEvent("LP:Write", "save.json", json.encode(copy))
end

function SpawnEntitiesAtJSON()
    for model, values in pairs(cJSON) do
        model = GetHashKey(model)

        if IsModelValid(model) then
            if not HasModelLoaded(model) then
                RequestModel(model)
                while not HasModelLoaded(model) do
                    Citizen.Wait(0)
                end
            end

            for index, d in pairs(values) do
                local x, y, z = table.unpack(d.position)
                local rotation = d.rotation

                local ent = CreateObject(model, x, y, z, true, true, true)
                SetEntityHeading(ent, rotation)

                EnableEntityPhysics(ent, true)

                d.entity = ent
            end

            SetModelAsNoLongerNeeded(model)
        end
    end
end

function GetHashName(hash)
    if HASH_MODELS[hash] then
        return HASH_MODELS[hash]
    end
    if HASH_PEDS[hash] then
        return HASH_PEDS[hash]
    end
    if HASH_PROVISIONS[hash] then
        return HASH_PROVISIONS[hash]
    end
    if HASH_VEHICLES[hash] then
        return HASH_VEHICLES[hash]
    end
    return false
end

function EnableEntityPhysics(entity, enabled)
    if enabled then
        SetActivateObjectPhysicsAsSoonAsItIsUnfrozen(entity, true)
        FreezeEntityPosition(entity, false)
        SetEntityCollision(entity, true, true)
        ActivatePhysics(entity)
        SetEntityHasGravity(entity, true)
    else
        FreezeEntityPosition(entity, true)
        SetEntityCollision(entity, false, false)
    end
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            DeleteMyEntity()

            for model, values in pairs(cJSON) do
                for index, d in pairs(values) do
                    local ent = d.entity
                    if DoesEntityExist(ent) then
                        SetEntityAsMissionEntity(ent, true, true)
                        DeleteObject(ent)
                    end
                end
            end
        end
    end
)
