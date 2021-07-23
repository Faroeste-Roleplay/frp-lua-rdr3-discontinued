local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Tunnel.getInterface("API")
cAPI = Proxy.getInterface("API")

local closestShopId
local closestShopVector

local prompt
local prompt_sell
local prompt_group

local sentFirstData = false

local NUIOpen = false

local selected_itemId
local selected_shopId
local selected_prompt_group_name

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            closestShopId = nil
            closestShopVector = nil

            local ped = PlayerPedId()
            local pCoords = GetEntityCoords(ped)

            local foundShopId
            local foundShopVector

            for shopId, shopLocations in pairs(Config.ShopLocations) do
                for _, locationData in pairs(shopLocations) do
                    local x, y, z, _ = table.unpack(locationData)
                    local vec = vec3(x, y, z)
                    local dist = #(pCoords - vec)
                    if dist <= 50 then
                        foundShopId = shopId
                        foundShopVector = vec
                    end
                end
            end

            closestShopId = foundShopId
            closestShopVector = foundShopVector
        end
    end
)

Citizen.CreateThread(
    function()
        InitiatePrompts()

        while true do
            Citizen.Wait(0)

            if NUIOpen == false then
                if closestShopId ~= nil then
                    local ped = PlayerPedId()
                    local pCoords = GetEntityCoords(ped)

                    if #(pCoords - closestShopVector) <= 1.5 then
                        PromptSetActiveGroupThisFrame(prompt_group, CreateVarString(10, "LITERAL_STRING", closestShopId))
                        if PromptHasHoldModeCompleted(prompt) then
                            if IsControlPressed(0, 0xDFF812F9) then
                                TriggerEvent("FRP:SHOP:SELL:OpenShop", closestShopId)
                                Citizen.Wait(1000)
                            end
                        end
                    end
                end
            else
                DisableAllControlActions(0)
                DisableAllControlActions(1)
                DisableAllControlActions(2)
                EnableControlAction(0, 0x7F8D09B8, true)
                if selected_shopId ~= nil and selected_itemId ~= nil then
                    PromptSetActiveGroupThisFrame(prompt_group, selected_prompt_group_name)
                    if PromptHasHoldModeCompleted(prompt_sell) then
                        PromptSetEnabled(prompt_sell, false)
                        Citizen.CreateThread(
                            function()
                                Citizen.Wait(1000)
                                PromptSetEnabled(prompt_sell, true)
                            end
                        )

                        TriggerServerEvent("FRP:SHOP:TryToSell", selected_shopId, selected_itemId, false)
                    end
                end
            end
        end
    end
)

function InitiatePrompts()
    prompt = PromptRegisterBegin()
    prompt_group = GetRandomIntInRange(0, 0xffffff)
    PromptSetControlAction(prompt, 0xDFF812F9)
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Abrir"))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, true)
    PromptSetPosition(prompt, foundShopVector)
    PromptSetGroup(prompt, prompt_group)
    -- N_0x0c718001b77ca468(prompt, 1.5)
    -- PrompContextSetSize(prompt, 3.0)
    PromptRegisterEnd(prompt)

    prompt_sell = PromptRegisterBegin()
    PromptSetControlAction(prompt_sell, 0x7F8D09B8)
    PromptSetText(prompt_sell, CreateVarString(10, "LITERAL_STRING", "Vender"))
    PromptSetEnabled(prompt_sell, true)
    PromptSetVisible(prompt_sell, false)
    PromptSetHoldMode(prompt_sell, true)
    PromptSetGroup(prompt_sell, prompt_group)
    PromptRegisterEnd(prompt_sell)
end

RegisterNetEvent("FRP:SHOP:SELL:OpenShop")
AddEventHandler(
    "FRP:SHOP:SELL:OpenShop",
    function(shopId)
        if sentFirstData == true then
            SendNUIMessage(
                {
                    display = true,
                    shopId = shopId
                }
            )
        else
            local temp_ConfigShopData = Config.ShopDatas

            for _, shopData in pairs(temp_ConfigShopData) do
                for key, value in pairs(shopData) do
                    if key ~= "name" then
                        for _, shopItemData in pairs(value) do
                            local itemId = shopItemData[1]
                            local itemData = ItemList[itemId]
                            if itemData then
                                local minItemAmount = shopItemData[3]
                                shopItemData[5] = itemData.name
                                shopItemData[6] = itemData.desc
                                shopItemData[7] = itemData.weight * minItemAmount
                            end
                        end
                    end
                end
            end

            SendNUIMessage(
                {
                    display = true,
                    shopId = shopId,
                    firstTimeData = temp_ConfigShopData
                }
            )
            sentFirstData = true
        end
        SetNuiFocus(true, true)
        SetNuiFocusKeepInput(true)

        NUIOpen = true

        PromptSetVisible(prompt, false)
    end
)

-- RegisterNUICallback(
--     "sellItem",
--     function(data, cb)
--         TriggerServerEvent("FRP:SHOP:TryToSell", data.shopId, data.itemId, data.withGold)
--     end
-- )

RegisterNUICallback(
    "selectedItem",
    function(data)
        selected_itemId = data.itemId
        selected_shopId = data.shopId
        selected_prompt_group_name = CreateVarString(10, "LITERAL_STRING", "x" .. GetItemSellAmount(selected_shopId, selected_itemId) .. " " .. ItemList[selected_itemId].name)

        PromptSetVisible(prompt_sell, true)
        PromptSetText(prompt_sell, CreateVarString(10, "LITERAL_STRING", "Vender"))
    end
)

RegisterNUICallback(
    "unselectedItem",
    function(data, cb)
        -- local itemId = cb.itemId
        selected_itemId = nil
        selected_shopId = nil
        PromptSetVisible(prompt_sell, false)
    end
)

RegisterNUICallback(
    "focusOff",
    function(data, cb)
        NUIHide()
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            NUIHide()

            if prompt ~= nil then
                PromptDelete(prompt)
                PromptDelete(prompt_sell)
            end
        end
    end
)

function NUIHide()
    SendNUIMessage(
        {
            display = false
        }
    )
    SetNuiFocusKeepInput(false)

    SetNuiFocus(false, false)
    NUIOpen = false
    PromptSetVisible(prompt_sell, false)
    PromptSetVisible(prompt, true)
end

function GetItemSellAmount(shopId, itemId)
    for i = 1, #Config.ShopDatas do
        if Config.ShopDatas[i].name == shopId then
            for _, v in pairs(Config.ShopDatas[i][1]) do
                local _itemId = v[1]
                if _itemId == itemId then
                    return v[3]
                end
            end
            break
        end
    end
end
