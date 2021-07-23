local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local saviorHumanNpc

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            local playerPed = PlayerPedId()

            CheckForHelpfullNpcs(playerPed)
            checkForWitness(playerPed)
        end
    end
)

function CheckForHelpfullNpcs(playerPed)
    if saviorHumanNpc == nil then
        if GetEntityHealth(playerPed) <= 0 then
            local playerPosition = GetEntityCoords(playerPed)

            local drugStorePosition, drugsStoreDistance = GetClosestDrugStore(playerPosition)

            if drugsStoreDistance > 10.0 then
                local humanNpcs = GetClosestHumanNpcs(50.0)

                for _, humanNpc in pairs(humanNpcs) do
                    if humanNpc ~= playerPed then
                        if HasEntityClearLosToEntity(humanNpc, playerPed, 0) then
                            if not IsPedDeadOrDying(humanNpc, 1) then
                                if not NativeIsPedLassoed(humanNpc) then
                                    if not IsPedInCombat(humanNpc, 0) then
                                        local npcMount = GetMount(humanNpc)
                                        if npcMount ~= 0 then
                                            -- saviorHumanNpc = humanNpc
                                            -- HandleSaviorNpc(humanNpc, npcMount, drugStorePosition)

                                            saviorHumanNpc = humanNpc

                                            local humanNpcPosition = GetEntityCoords(humanNpc)

                                            SetEntityAsMissionEntity(humanNpc, true, true)
                                            NetworkRequestControlOfEntity(humanNpc)

                                            taskSequence = Citizen.InvokeNative("0xE8854A4326B9E12B", Citizen.PointerValueInt())
                                            --TaskSetBlockingOfNonTemporaryEvents(0, true)
                                            TaskGoToEntity(0, playerPed, -1, 1.2, 1.5, 2.0, 0)
                                            TaskPickupCarriableEntity(0, playerPed)
                                            TaskPlaceCarriedEntityOnMount(0, playerPed, npcMount, 7)
                                            Citizen.InvokeNative(0x92DB0739813C5186, 0, npcMount, -1, -1, 2.0, 1, 0, 0)

                                            TaskGoToCoordAnyMeansExtraParams(0, drugStorePosition, 3.0, 0, false, 524311, -1.0, 0, 1101004800, 800, 1112014848)

                                            TaskDumpCarriableFromParent(0, npcMount, playerPed)
                                            --Citizen.InvokeNative(0x92DB0739813C5186, 0, npcMount, -1, -1, 2.0, 1, 0, 0)

                                            TaskGoToCoordAnyMeansExtraParams(0, humanNpcPosition, 3.0, 0, false, 524311, -1.0, 0, 1101004800, 800, 1112014848)

                                            --TaskSetBlockingOfNonTemporaryEvents(0, false)
                                            CloseSequenceTask(taskSequence)

                                            TaskPerformSequence(humanNpc, taskSequence)

                                            break
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    else
        if GetSequenceProgress(saviorHumanNpc) == -1 then
            saviorHumanNpc = nil
            SetEntityAsMissionEntity(humanNpc, false, false)
            ClearSequenceTask(taskSequence)
        end
    end
end

local MAX_WITNESS = 3
local MAX_WITNESS_DISTANCE = 10.0
local WITNESS_REPORT_DISTANCE = 45.0
local REPORT_THRESHOLD = 60 * 1000
local LAST_REPORT_TIME = 0

local witnessList = {}

function checkForWitness(playerPed)
    if (cAPI.IsWanted() and not isAtMaxWitness()) then
        local humanNpcs = GetClosestHumanNpcs(MAX_WITNESS_DISTANCE)

        for _, humanNpc in pairs(humanNpcs) do
            if humanNpc ~= playerPed then
                if not isAtMaxWitness() then
                    if HasEntityClearLosToEntityInFront(humanNpc, playerPed, 0) then
                        if not IsPedDeadOrDying(humanNpc, 1) then
                            if not NativeIsPedLassoed(humanNpc) then
                                addWitness(humanNpc, "crime")
                            end
                        end
                    end
                end
            end
        end
    end
end

function isAtMaxWitness()
    return #witnessList >= MAX_WITNESS
end

function isAWitness(entity)
    for _, d in pairs(witnessList) do
        local w_entity = d.entity

        if w_entity == entity then
            return true
        end
    end

    return false
end

function addWitness(entity, crime)
    if not isAWitness(entity) then
        local blip = Citizen.InvokeNative(0x23f74c2fda6e7c61, GetHashKey("BLIP_STYLE_EYEWITNESS"), entity) -- BLIPADDFORENTITY
        SetBlipScale(blip, 1.0)

        table.insert(
            witnessList,
            {
                entity = entity,
                crime = crime,
                start_at = GetGameTimer(),
                blip = blip
            }
        )

        local playerPed = PlayerPedId()
        local playerPosition = GetEntityCoords(playerPed)

        fleeEntity(entity, playerPosition)

        if #witnessList == 1 then
            Citizen.CreateThread(
                function()
                    while #witnessList > 0 do
                        Citizen.Wait(0)

                        playerPed = PlayerPedId()

                        for _, d in pairs(witnessList) do
                            local entity = d.entity
                            local crime = d.crime
                            local start_at = d.start_at

                            local diff = GetGameTimer() - start_at

                            if diff >= 15 * 1000 and isEntityFarAndHasNoLOS(entity, playerPed, playerPosition) then
                                -- if diff >= 8 * 1000 and isEntityFarAndHasNoLOS(entity, playerPed, playerPosition) then
                                --     fleeEntity(entity, playerPosition)
                                -- end

                                if LAST_REPORT_TIME == 0 or (math.abs(LAST_REPORT_TIME - GetGameTimer())) >= REPORT_THRESHOLD then
                                    LAST_REPORT_TIME = GetGameTimer()

                                    playerPosition = GetEntityCoords(playerPed)

                                    TriggerServerEvent(
                                        "FRP:WANTED:gunshotInProgress",
                                        {
                                            x = playerPosition.x,
                                            y = playerPosition.y,
                                            z = playerPosition.z
                                        },
                                        GetCurrentTownName(),
                                        nil,
                                        true
                                    )

                                    cAPI.notify("alert", "Você foi denunciado!")
                                end

                                removeWitness(entity)
                            end

                            if IsPedDeadOrDying(entity, 0) == 1 then
                                local killer = GetPedSourceOfDeath(entity)

                                if killer == playerPed then
                                    if #witnessList > 0 then
                                        MAX_WITNESS = 6
                                        MAX_WITNESS_DISTANCE = 20.0
                                    end
                                end

                                removeWitness(entity)
                            end
                        end
                    end

                    MAX_WITNESS = 3
                    MAX_WITNESS_DISTANCE = 10.0
                end
            )
        end
    end
end

function removeWitness(entity)
    for _, d in pairs(witnessList) do
        local w_entity = d.entity
        local w_blip = d.blip

        if w_entity == entity then
            RemoveBlip(w_blip)

            table.remove(witnessList, _)
            break
        end
    end
end

function isEntityFarAndHasNoLOS(entity, playerPed, playerPosition)
    local entityPosition = GetEntityCoords(entity)

    local distance = #(entityPosition - playerPosition)

    if distance > WITNESS_REPORT_DISTANCE and not HasEntityClearLosToEntity(playerPed, entity, 17) then
        return true
    end

    return false
end

function fleeEntity(entity, position)
    -- if GetBestPedWeapon(entity, 0, 0) ~= GetHashKey("WEAPON_UNARMED") then
    -- TaskSmartFleeCoord(entity, position, 40.0, 10000, 8, 1077936128)

    ClearPedSecondaryTask(entity)

    SetPedCombatAttributes(entity, 17, true)
    SetPedCombatAttributes(entity, 5, false)
    SetPedCombatAttributes(entity, 58, false)
    SetPedFleeAttributes(entity, 512, false)
    SetPedFleeAttributes(entity, 1024, true)
    SetPedFleeAttributes(entity, 32768, false)
    TaskSmartFleeCoord(entity, position, 300.0, -1, 2097152, 1077936128)
    SetPedKeepTask(entity, true)

    -- TaskSmartFleePed(entity, PlayerPedId(), 500.0, -1, 0, 1.0, 0)
    -- SetPedKeepTask(entity, true)
    -- end
end

local drugstores = {
    vec3(-282.673, 797.344, 118.868),
    vec3(-1803.430, -421.097, 157.387),
    vec3(2739.827, -1231.289, 49.689)
}

function GetClosestDrugStore(playerPosition)
    local lastIndex
    local lastDistance

    for i = 1, #drugstores do
        local v = drugstores[i]

        local dist = #(playerPosition - v)
        if lastIndex == nil or dist < lastDistance then
            lastIndex = i
            lastDistance = dist
        end
    end

    return drugstores[lastIndex], lastDistance
end

function IsPedBeingCarried(ped)
    return NativeGetCarrierAsPed(ped) ~= 0
end

function NativeGetCarrierAsPed(ped)
    return Citizen.InvokeNative(0x09B83E68DE004CD4, ped, Citizen.ResultAsInteger())
end

function NativeIsPedLassoed(ped)
    return Citizen.InvokeNative(0x9682F850056C9ADE, ped)
end

function GetClosestHumanNpcs(radius)
    local r = {}

    local playerPed = PlayerPedId()

    local itemSet = CreateItemset(true)
    local size = Citizen.InvokeNative(0x59B57C4B06531E1E, GetEntityCoords(playerPed), radius, itemSet, 1, Citizen.ResultAsInteger())
    -- number xPos, number yPox, number zPos, float distance, int itemSet, int entityType

    if size > 0 then
        for index = 0, size - 1 do
            local entity = GetIndexedItemInItemset(index, itemSet)
            if IsEntityAPed(entity) and IsPedHuman(entity) and not IsPedDeadOrDying(entity, 0) then
                if IsPedAPlayer(entity) and entity ~= playerPed then
                    r = {}
                    break
                end
                table.insert(r, entity)
            end
        end
    end

    if IsItemsetValid(itemSet) then
        DestroyItemset(itemSet)
    end

    return r
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        for _, d in pairs(witnessList) do
            local w_entity = d.entity
            local w_blip = d.blip

            RemoveBlip(w_blip)
        end
    end
)

--[[
    * MUDAR FUNÇÃO DE CIDADE PARA O _CORE
    * cAPI.GetCurrentTownLocalized()
]]
function GetCurrentTownName()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords, 1)

    if town_hash == GetHashKey("Annesburg") then
        return "Annesburg"
    elseif town_hash == GetHashKey("Armadillo") then
        return "Armadillo"
    elseif town_hash == GetHashKey("Blackwater") then
        return "Blackwater"
    elseif town_hash == GetHashKey("BeechersHope") then
        return "BeechersHope"
    elseif town_hash == GetHashKey("Braithwaite") then
        return "Braithwaite"
    elseif town_hash == GetHashKey("Butcher") then
        return "Butcher"
    elseif town_hash == GetHashKey("Caliga") then
        return "Caliga"
    elseif town_hash == GetHashKey("cornwall") then
        return "Cornwall"
    elseif town_hash == GetHashKey("Emerald") then
        return "Emerald"
    elseif town_hash == GetHashKey("lagras") then
        return "lagras"
    elseif town_hash == GetHashKey("Manzanita") then
        return "Manzanita"
    elseif town_hash == GetHashKey("Rhodes") then
        return "Rhodes"
    elseif town_hash == GetHashKey("Siska") then
        return "Siska"
    elseif town_hash == GetHashKey("StDenis") then
        return "Saint Denis"
    elseif town_hash == GetHashKey("Strawberry") then
        return "Strawberry"
    elseif town_hash == GetHashKey("Tumbleweed") then
        return "Tumbleweed"
    elseif town_hash == GetHashKey("valentine") then
        return "Valentine"
    elseif town_hash == GetHashKey("VANHORN") then
        return "Vanhorn"
    elseif town_hash == GetHashKey("Wallace") then
        return "Wallace"
    elseif town_hash == GetHashKey("wapiti") then
        return "Wapiti"
    elseif town_hash == GetHashKey("AguasdulcesFarm") then
        return "Aguasdulces Farm"
    elseif town_hash == GetHashKey("AguasdulcesRuins") then
        return "Aguasdulces Ruins"
    elseif town_hash == GetHashKey("AguasdulcesVilla") then
        return "Aguasdulces Villa"
    elseif town_hash == GetHashKey("Manicato") then
        return "Manicato"
    elseif town_hash == false then
        return "Cidade Fantasma"
    end
end
