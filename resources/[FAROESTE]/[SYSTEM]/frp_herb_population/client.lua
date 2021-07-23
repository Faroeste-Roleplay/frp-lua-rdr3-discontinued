local pop = {}
local popSuppressed = {}

local SCOPE_RANGE_LOAD = 100.0
local SCOPE_RANGE_UNLOAD = 120.0

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000) -- 10 sec

            local playerPosition = GetEntityCoords(PlayerPedId())

            for indexComposite = 1, #CompositeVectors2 do
                local d = CompositeVectors2[indexComposite]

                local compositeType = d.name

                RequestAndWaitForComposite(GetHashKey(compositeType))

                local vectors = d.vectors

                for index = 1, #vectors do
                    if not IsVectorIndexSuppressed(indexComposite, index) then
                        local v = vectors[index]

                        local dist = #(playerPosition - v)

                        if not IsVectorIndexLoaded(indexComposite, index) then
                            if dist <= SCOPE_RANGE_LOAD then
                                LoadAtVectorIndex(indexComposite, index)
                            end
                        else
                            if dist >= SCOPE_RANGE_UNLOAD then
                                UnloadAtVectorIndex(indexComposite, index)
                            end
                        end
                    end
                end
            end
        end
    end
)

function LoadAtVectorIndex(indexComposite, index)
    if pop[indexComposite] == nil then
        pop[indexComposite] = {}
    end

    local compositeType = LookupTableGetCompositeNameFromIndex(indexComposite)
    local v = LookupTableGetVectorFromIndex(indexComposite, index)

    local composite = exports["frp_herb_population"]:NativeCreateComposite(GetHashKey(compositeType), v.x, v.y, v.z, false)

    pop[indexComposite][index] = composite
end

function UnloadAtVectorIndex(indexComposite, indexVector, sanityCheck)
    local sanityCheck = sanityCheck or true

    if pop[indexComposite] or sanityCheck == false then
        if pop[indexComposite][indexVector] or sanityCheck == false then
            NativeDeleteComposite(pop[indexComposite][indexVector])
            pop[indexComposite][indexVector] = nil
        end
    end
end

function SetVectorIndexSuppressed(indexComposite, index, suppress)
    if suppress then
        -- end
        -- if not IsVectorIndexSuppressed(indexComposite, index) then
        UnloadAtVectorIndex(indexComposite, index)

        if popSuppressed[indexComposite] == nil then
            popSuppressed[indexComposite] = {}
        end

        popSuppressed[indexComposite][index] = true
    else
        -- end
        -- if IsVectorIndexSuppressed(indexComposite, index) then
        popSuppressed[indexComposite][index] = nil
    end
end

function UnloadAllVectorIndices()
    for indexComposite, indices in pairs(pop) do
        for index, composite in pairs(indices) do
            UnloadAtVectorIndex(indexComposite, index, false)
        end
    end
end

function IsVectorIndexLoaded(indexComposite, index)
    return pop[indexComposite] ~= nil and pop[indexComposite][index] ~= nil or false
end

function IsVectorIndexSuppressed(indexComposite, index)
    return popSuppressed[indexComposite] ~= nil and popSuppressed[indexComposite][index] ~= nil or false
end

function LookupTableGetCompositeNameFromIndex(indexComposite)
    return CompositeVectors2[indexComposite].name
end

function LookupTableGetVectorFromIndex(indexComposite, index)
    return CompositeVectors2[indexComposite].vectors[index]
end

function RequestAndWaitForComposite(compositeHash)
    if not Citizen.InvokeNative(0x5E5D96BE25E9DF68, compositeHash) then
        Citizen.InvokeNative(0x73F0D0327BFA0812, compositeHash)

        while not Citizen.InvokeNative(0x5E5D96BE25E9DF68, compositeHash) do
            Citizen.Wait(0)
        end
    end
end

RegisterNetEvent("FRP:HERB_POPULATION:SetVectorIndexSuppressed")
AddEventHandler(
    "FRP:HERB_POPULATION:SetVectorIndexSuppressed",
    function(indexComposite, index, suppress)
        SetVectorIndexSuppressed(indexComposite, index, suppress)
    end
)

RegisterNetEvent("FRP:HERB_POPULATION:SetPopSuppressed")
AddEventHandler(
    "FRP:HERB_POPULATION:SetPopSuppressed",
    function(ps)
        popSuppressed = ps
    end
)

RegisterNetEvent("FRP:HERB_POPULATION:ForceVectorIndexReload")
AddEventHandler(
    "FRP:HERB_POPULATION:ForceVectorIndexReload",
    function(indexComposite, index)
        if IsVectorIndexLoaded(indexComposite, index) then
            UnloadAtVectorIndex(indexComposite, index)
            LoadAtVectorIndex(indexComposite, index)
        end
    end
)

AddEventHandler(
    "FRP:EVENTS:PedFinishedGatheringEntity",
    function(ped, entity, bool_unk)
        if not IsEntityAPed(entity) then
            -- Plantinhas
            if ped == PlayerPedId() then
                local closestCompositeType
                local closestIndexComposite
                local closestIndex

                local lastDist

                local playerPosition = GetEntityCoords(PlayerPedId())

                for indexComposite = 1, #CompositeVectors2 do
                    local d = CompositeVectors2[indexComposite]
                    --  print(d[1])
                    local vectors = CompositeVectors2[indexComposite].vectors

                    for index = 1, #vectors do
                        local v = vectors[index]

                        local dist = #(playerPosition - v)
                        if dist <= SCOPE_RANGE_LOAD then
                            if lastDist == nil or dist < lastDist then
                                lastDist = dist

                                closestCompositeType = d.name
                                closestIndexComposite = indexComposite
                                closestIndex = index
                            end
                        end
                    end
                end

                if closestIndexComposite == nil then
                    return
                end

                closestCompositeType = closestCompositeType:gsub("COMPOSITE_LOOTABLE_", "")

                --      print(closestCompositeType, closestIndexComposite, closestIndex, compositeType)

                TriggerServerEvent("FRP:HERB_POPULATION:Gathered", closestCompositeType, closestIndexComposite, closestIndex)
            end
        end
    end
)

function NativeDeleteComposite(composite)
    Citizen.InvokeNative(0x5758B1EE0C3FD4AC, composite, 0)
end

function NativeDisplayCompositeEatThisFrame(composite, display)
    Citizen.InvokeNative(0x082C043C7AFC3747, composite, display)
end

function NativeDisplayCompositePickuptThisFrame(composite, display)
    Citizen.InvokeNative(0x40D72189F46D2E15, composite, display)
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if GetCurrentResourceName() == resourceName then
            UnloadAllVectorIndices()
        end
    end
)

-- Citizen.CreateThread(
--     function()
--         local upVector = vec3(0.0, 0.0, 1.5)

--         local DRAW_LINE = GetHashKey("DRAW_LINE")

--         while true do
--             Citizen.Wait(0)

--             local playerPosition = GetEntityCoords(PlayerPedId())

--             for indexComposite = 1, #CompositeVectors2 do
--                 local d = CompositeVectors2[indexComposite]
--                 --  print(d[1])
--                 local vectors = CompositeVectors2[indexComposite].vectors

--                 for index = 1, #vectors do
--                     local v = vectors[index]
--                     -- if IsVectorIndexLoaded(indexComposite, index) then

--                     local dist = #(playerPosition - v)
--                     if dist <= SCOPE_RANGE_LOAD then
--                         Citizen.InvokeNative(DRAW_LINE & 0xFFFFFFFF, v, v + upVector, 0, 255, 0, 255)
--                     -- else
--                     -- Citizen.InvokeNative(DRAW_LINE & 0xFFFFFFFF, v, v + upVector, 255, 0, 0, 255)
--                     -- end
--                     end
--                 end
--             end
--         end
--     end
-- )

-- RegisterCommand(
--     "eagleeye",
--     function()
--         Citizen.InvokeNative(0xA63FCAD3A6FEC6D2, PlayerId(), 1) -- ENABLE_EAGLE_EYE(PLayer player, BOOL, enable)
--         Citizen.InvokeNative(0x28A13BF6B05C3D83, PlayerId(), 1) -- SETS DEADEYE/EAGLEEYE INFINITE
--     end,
--     false
-- )
