local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Tunnel.getInterface("API")
cAPI = Proxy.getInterface("API")

local closestShopId
local closestShopVector

local prompt
local prompt_group
local prompt_group_name

local sentFirstData = false

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            local ped = PlayerPedId()
            local pCoords = GetEntityCoords(ped)

            local foundShopId
            local foundShopVector
            local lastDist

            for shopId, shopLocations in pairs(Config.ShopLocations) do
                for _, locationData in pairs(shopLocations) do
                    local x, y, z, _ = table.unpack(locationData)
                    local vec = vec3(x, y, z)
                    local dist = #(pCoords - vec)
                    if (foundShopVector == nil and dist <= 10.0) or (lastDist ~= nil and dist < lastDist)  then
                        foundShopId = shopId
                        foundShopVector = vec
                        lastDist = dist
                    end
                end
            end

            if foundShopId ~= nil then
                prompt_group_name = CreateVarString(10, "LITERAL_STRING", foundShopId)
            end

            closestShopId = foundShopId
            closestShopVector = foundShopVector
        end
    end
)

Citizen.CreateThread(
    function()
        initPrompt()
        while true do
            Citizen.Wait(0)

            if closestShopId ~= nil then
                local ped = PlayerPedId()
                local pCoords = GetEntityCoords(ped)

                if #(pCoords - closestShopVector) <= 1.5 then
                    -- if IsControlJustPressed(0, 0xDFF812F9) then
                    PromptSetActiveGroupThisFrame(prompt_group, prompt_group_name)

                    if PromptHasHoldModeCompleted(prompt) then
                        if IsControlPressed(0, 0xDFF812F9) then
                            if sentFirstData == true then
                                SendNUIMessage(
                                    {
                                        display = true,
                                        shopId = closestShopId
                                    }
                                )
                            else
                                local temp_ConfigShopData = Config.ShopDatas

                                for _, shopData in pairs(temp_ConfigShopData) do
                                    for key, value in pairs(shopData) do
                                        if key ~= "name" then
                                            for _, shopItemData in pairs(value) do
                                                local itemData = ItemList[shopItemData[1]]
                                                if itemData then
                                                    shopItemData[5] = itemData.name
                                                    shopItemData[6] = itemData.weight
                                                    shopItemData[7] = itemData.description
                                                end
                                            end
                                        end
                                    end
                                end
                                SendNUIMessage(
                                    {
                                        display = true,
                                        shopId = closestShopId,
                                        firstTimeData = temp_ConfigShopData
                                    }
                                )
                                sentFirstData = true
                            end
                            SetNuiFocus(true, true)
                            Citizen.Wait(1000)
                        end
                    end
                end
            end
        end
    end
)

function initPrompt()
    prompt = PromptRegisterBegin()
    prompt_group = GetRandomIntInRange(0, 0xffffff)
    PromptSetControlAction(prompt, 0xDFF812F9)
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Abrir"))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, true)
    -- PromptSetPosition(prompt, foundShopVector)
    -- N_0x0c718001b77ca468(prompt, 1.5)
    PromptSetGroup(prompt, prompt_group)
    PromptRegisterEnd(prompt)
end

RegisterNUICallback(
    "buyItem",
    function(data, cb)
        TriggerServerEvent("FRP:SHOP:TryToBuy", data.shopId, data.itemId, data.withGold)
    end
)

RegisterNUICallback(
    "focusOff",
    function(data, cb)
        SetNuiFocus(false, false)
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            SendNUIMessage(
                {
                    display = false
                }
            )
            SetNuiFocus(false, false)

            if prompt ~= nil then
                PromptDelete(prompt)
            end
        end
    end
)
