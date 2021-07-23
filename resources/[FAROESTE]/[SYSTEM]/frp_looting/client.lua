local pocketing = {}

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            local itemSet = CreateItemset(true)
            -- FindAllAttachedCarriableEntities(PlayerPedId(), itemSet)

            FindAllAttachedCarriableEntities(9782024, itemSet)
            local size = GetItemsetSize(itemSet)

            if size > 0 then
                for index = 0, size - 1 do
                    local entity = GetIndexedItemInItemset(index, itemSet)

                    -- POCKETABLE ITEM
                    -- print(GetEntityModel(entity), GetEntityType(entity), GetCarriableCarryConfig(entity))
                    local carryConfig = GetCarriableCarryConfig(entity)
                    if GetEntityType(entity) == 3 and (carryConfig == -411455723 or carryConfig == -1953048298) then
                        if not pocketing[entity] then
                            pocketing[entity] = GetEntityModel(entity)
                        end
                    end
                end
            end

            if IsItemsetValid(itemSet) then
                DestroyItemset(itemSet)
            end

            for entity, model in pairs(pocketing) do
                if not DoesEntityExist(entity) then
                    TriggerServerEvent("FRP:LOOTING:TryToLoot", model)
                    pocketing[entity] = nil
                end
            end
        end
    end
)

function GetCarriableCarryConfig(carriable)
    return Citizen.InvokeNative(0x0FD25587BB306C86, carriable)
end

RegisterNetEvent("FRP:LOOTING:LooteableDenied")
AddEventHandler(
    "FRP:LOOTING:LooteableDenied",
    function(entityModel)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped) + (GetEntityForwardVector(ped) * 0.5)

        if not HasModelLoaded(entityModel) then
            RequestModel(entityModel)
            while not HasModelLoaded(entityModel) do
                Citizen.Wait(10)
            end
        end

        local entity = CreateObject(entityModel, coords, true, true, true)
        Citizen.InvokeNative(0xF0B4F759F35CC7F5, entity, Citizen.InvokeNative(0x34F008A7E48C496B, entity, 3), 0, 0, 512)
        Citizen.InvokeNative(0x7DFB49BCDB73089A, entity, true)
        PlaceObjectOnGroundProperly(entity)
    end
)
