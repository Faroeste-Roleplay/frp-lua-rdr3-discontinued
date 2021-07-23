local dropPopulation = {}
--[[
    {
        entity
        position
        itemName
        itemAmount
        itemWeight
    }
]]
local indexInPickupRange

local prompt
local prompt_group

RegisterNetEvent("FRP:INVENTORY:DROP:Create")
AddEventHandler(
    "FRP:INVENTORY:DROP:Create",
    function(index, x, y, z, itemId, itemAmount)
        local itemName = ItemList[itemId].name or "Item Desconhecido"
        local itemWeight = ItemList[itemId].weight * itemAmount

        if itemId == "money" or itemId == "gold" then
            itemName = ""
            itemAmount = itemAmount / 100

            if itemId == "money" then
                local c = "$"

                if itemAmount < 1.0 then
                    c = "¢"
                    itemAmount = string.format("%.0f", (itemAmount * 100))
                end

                itemAmount = c .. itemAmount
            elseif itemId == "gold" then
                itemAmount = "G" .. itemAmount
            end
        else
            itemAmount = "x" .. itemAmount
        end

        dropPopulation[index] = {
            position = vec3(x, y, z),
            itemName = itemName,
            itemAmount = itemAmount,
            itemWorldModel = ItemList[itemId].worldModel,
            itemWeight = string.format("%.2f", itemWeight)
        }

        local inRange, distance = isCoordsInRenderRange(dropPopulation[index].position)

        if inRange then
            tryToCreateDroppedEntityForIndex(index)

            if distance <= 1.5 then
                indexInPickupRange = index
            end
        end
    end
)

RegisterNetEvent("FRP:INVENTORY:DROP:Delete")
AddEventHandler(
    "FRP:INVENTORY:DROP:Delete",
    function(index)
        deleteDroppedEntityForIndex(index)

        dropPopulation[index] = nil
    end
)

Citizen.CreateThread(
    function()
        prepareMyPrompt()

        while true do
            Citizen.Wait(1000)

            local pedPosition = GetEntityCoords(PlayerPedId())

            indexInPickupRange = nil

            for index, d in pairs(dropPopulation) do
                local inRange, distance = isCoordsInRenderRange(d.position, pedPosition)
                if inRange then
                    tryToCreateDroppedEntityForIndex(index)

                    if distance <= 1.5 then
                        indexInPickupRange = index
                    end
                else
                    if d.entity ~= nil then
                        deleteDroppedEntityForIndex(index)
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if indexInPickupRange ~= nil then
                local d = dropPopulation[indexInPickupRange]

                if d ~= nil and d.entity ~= nil then
                    local dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(d.entity))

                    if dist <= 1.2 then
                        local itemName = d.itemName
                        local itemAmount = d.itemAmount
                        local itemWeight = d.itemWeight

                        PromptSetActiveGroupThisFrame(prompt_group, CreateVarString(10, "LITERAL_STRING", itemAmount .. " " .. itemName .. " | " .. itemWeight .. "kg"))
                        if PromptHasHoldModeCompleted(prompt) then
                            PromptSetEnabled(prompt, false)
                            Citizen.CreateThread(
                                function()
                                    Citizen.Wait(1000)
                                    PromptSetEnabled(prompt, true)
                                end
                            )

                            TriggerServerEvent("FRP:INVENTORY:PickedUpDroppedItem", indexInPickupRange)
                        end
                    else
                        indexInPickupRange = nil
                    end
                else
                    indexInPickupRange = nil
                end
            end
        end
    end
)

function tryToCreateDroppedEntityForIndex(index, optional_pedPosition)
    local d = dropPopulation[index]

    if d == nil then
        return
    end

    if d.entity ~= nil then
        if DoesEntityExist(d.entity) then
            return
        end
    end

    local droppedI_Position = d.position

    -- local pedPosition = optional_pedPosition or GetEntityCoords(PlayerPedId())

    -- if isCoordsInRenderRange(droppedI_Position) then

    local droppedI_worldModel = d.itemWorldModel or "p_cs_lootsack02x"
    local droppedI_worldModelHash = GetHashKey(droppedI_worldModel)

    if not HasModelLoaded(droppedI_worldModelHash) then
        RequestModel(droppedI_worldModelHash)
        while not HasModelLoaded(droppedI_worldModelHash) do
            Citizen.Wait(0)
        end
    end

    local entity = CreateObject(droppedI_worldModelHash, droppedI_Position, false, true, true)
    PlaceObjectOnGroundProperly(entity)
    SetEntityInvincible(entity, true)

    if droppedI_worldModel ~= "p_cs_lootsack02x" then
        Citizen.InvokeNative(0x7DFB49BCDB73089A, entity, true)
    end

    dropPopulation[index].entity = entity

    -- while GetEntityVelocity(entity, false) ~= vec3(0, 0, 0) do
    --     Citizen.Wait(0)
    -- end

    FreezeEntityPosition(entity, true)
end

function deleteDroppedEntityForIndex(index)
    local d = dropPopulation[index]

    if d == nil then
        return
    end

    if d.entity ~= nil then
        if DoesEntityExist(d.entity) then
            DeleteEntity(d.entity)
            d.entity = nil
        end
    end
end

function isCoordsInRenderRange(position, optional_pedPosition)
    local pedPosition = optional_pedPosition or GetEntityCoords(PlayerPedId())

    local dist = #(pedPosition - position)
    if #(pedPosition - position) <= 50.0 then
        return true, dist
    end
    return false, dist
end

function prepareMyPrompt()
    prompt = PromptRegisterBegin()
    prompt_group = GetRandomIntInRange(0, 0xffffff)
    PromptSetControlAction(prompt, 0xE8342FF2)
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Pegar"))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, true)
    PromptSetGroup(prompt, prompt_group)
    PromptRegisterEnd(prompt)
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            for index, _ in pairs(dropPopulation) do
                deleteDroppedEntityForIndex(index)
            end

            PromptDelete(prompt)
        end
    end
)

AddEventHandler(
    "onResourceStart",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            TriggerServerEvent("FRP:INVENTORY:DROP:Request")
        end
    end
)
