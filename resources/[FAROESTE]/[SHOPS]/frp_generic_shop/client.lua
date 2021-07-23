local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Tunnel.getInterface("API")
cAPI = Proxy.getInterface("API")

local NUIOpen = false

local closestShopIndex
local closestShopVector

local prompt_group

local prompt_open
local prompt_transaction
local prompt_transaction_extra

local selected_shop_index
local selected_transaction_index

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            local playerPed = PlayerPedId()
            local playerPosition = GetEntityCoords(playerPed)

            local foundShopName
            local foundShopVector
            local lastDist

            for shopName, shopLocations in pairs(Config.Locations) do
                for _, locationData in pairs(shopLocations) do
                    local x, y, z, _ = table.unpack(locationData)
                    local vec = vec3(x, y, z)
                    local dist = #(playerPosition - vec)

                    if dist <= 10.0 then
                        if lastDist == nil or dist < lastDist then
                            lastDist = dist
                            foundShopName = shopName
                            foundShopVector = vec
                        end
                    end
                end
            end

            closestShopIndex = nil
            closestShopVector = nil

            if foundShopName then
                local shopIndex = getShopIndexByName(foundShopName)

                if shopIndex then
                    local shop_group = Config.Shops[shopIndex].group

                    if shop_group == nil or cAPI.hasGroupOrInheritance(shop_group) then
                        closestShopIndex = shopIndex
                        closestShopVector = foundShopVector

                        PromptSetText(prompt_open, CreateVarString(10, "LITERAL_STRING", foundShopName))
                        PromptSetEnabled(prompt_open, true)
                    end
                end
            else
                PromptSetVisible(prompt_open, false)
                PromptSetEnabled(prompt_open, false)
            end
        end
    end
)

Citizen.CreateThread(
    function()
        InitiatePrompts()

        while true do
            Citizen.Wait(0)

            if NUIOpen == false then
                if closestShopIndex ~= nil then
                    local ped = PlayerPedId()
                    local playerPosition = GetEntityCoords(ped)

                    if #(playerPosition - closestShopVector) <= 1.5 then
                        PromptSetVisible(prompt_open, true)

                        -- local shop_name = Config.Shops[closestShopIndex].name

                        -- PromptSetActiveGroupThisFrame(prompt_group, CreateVarString(10, "LITERAL_STRING", shop_name))

                        if PromptHasHoldModeCompleted(prompt_open) then
                            if IsControlPressed(0, 0xDFF812F9) then
                                PromptSetEnabled(prompt_open, false)
                                Citizen.CreateThread(
                                    function()
                                        Citizen.Wait(1000)
                                        PromptSetEnabled(prompt_open, true)
                                    end
                                )

                                TriggerServerEvent("FRP:SHOP:TryToOpen", closestShopIndex)
                            end
                        end
                    else
                        PromptSetVisible(prompt_open, false)
                        PromptSetEnabled(prompt_open, false)
                    end
                end
            else
                DisableAllControlActions(0)
                DisableAllControlActions(1)
                DisableAllControlActions(2)
                EnableControlAction(0, 0x07B8BEAF, true)
                EnableControlAction(0, 0xC13A6564, true)

                if selected_shop_index and selected_transaction_index then
                    local transaction_data = Config.Shops[selected_shop_index].transactions[selected_transaction_index]

                    local item_data = ItemList[transaction_data.item]

                    local name = item_data.name
                    local amount = transaction_data.amount or 1
                    local weight = amount * item_data.weight

                    local displayText = name

                    if amount > 1 then
                        displayText = "x" .. amount .. " " .. name
                    end

                    PromptSetActiveGroupThisFrame(prompt_group, CreateVarString(10, "LITERAL_STRING", displayText))

                    if PromptHasHoldModeCompleted(prompt_transaction) then
                        if IsControlPressed(0, 0x07B8BEAF) then
                            PromptSetEnabled(prompt_transaction, false)
                            Citizen.CreateThread(
                                function()
                                    Citizen.Wait(1000)
                                    PromptSetEnabled(prompt_transaction, true)
                                end
                            )

                            TriggerServerEvent("FRP:SHOP:Transaction", selected_shop_index, selected_transaction_index, 0)
                        end
                    end

                    if PromptHasHoldModeCompleted(prompt_transaction_extra) then
                        if IsControlPressed(0, 0xC13A6564) then
                            PromptSetEnabled(prompt_transaction_extra, false)
                            Citizen.CreateThread(
                                function()
                                    Citizen.Wait(1000)
                                    PromptSetEnabled(prompt_transaction_extra, true)
                                end
                            )

                            TriggerServerEvent("FRP:SHOP:Transaction", selected_shop_index, selected_transaction_index, 1)
                        end
                    end
                end
            end
        end
    end
)

function InitiatePrompts()
    prompt_group = GetRandomIntInRange(0, 0xffffff)

    prompt_open = PromptRegisterBegin()
    PromptSetControlAction(prompt_open, 0xDFF812F9)
    PromptSetText(prompt_open, CreateVarString(10, "LITERAL_STRING", "Abrir"))
    PromptSetEnabled(prompt_open, false)
    PromptSetVisible(prompt_open, false)
    PromptSetHoldMode(prompt_open, true)
    -- PromptSetGroup(prompt_open, prompt_group)
    PromptRegisterEnd(prompt_open)

    prompt_transaction = PromptRegisterBegin()
    PromptSetControlAction(prompt_transaction, 0x07B8BEAF)
    PromptSetEnabled(prompt_transaction, true)
    PromptSetVisible(prompt_transaction, true)
    PromptSetHoldMode(prompt_transaction, true)
    PromptSetGroup(prompt_transaction, prompt_group)
    PromptRegisterEnd(prompt_transaction)

    prompt_transaction_extra = PromptRegisterBegin()
    PromptSetControlAction(prompt_transaction_extra, 0xC13A6564)
    PromptSetEnabled(prompt_transaction_extra, true)
    PromptSetVisible(prompt_transaction_extra, false)
    PromptSetHoldMode(prompt_transaction_extra, true)
    PromptSetGroup(prompt_transaction_extra, prompt_group)
    PromptRegisterEnd(prompt_transaction_extra)
end

RegisterNetEvent("FRP:SHOP:OpenNUI")
AddEventHandler(
    "FRP:SHOP:OpenNUI",
    function(shopIndex, activeTransactions)
        NUIOpen = true

        local shop_data = deepcopy(Config.Shops[shopIndex])

        SendNUIMessage(
            {
                type = "show",
                shop_data = shop_data,
                activeTransations = activeTransactions
            }
        )

        SetNuiFocusKeepInput(true)
        SetNuiFocus(true, true)

        PromptSetVisible(prompt_open, false)

        selected_shop_index = shopIndex

        ClearPedTasks(PlayerPedId())
        TaskItemInteraction(PlayerPedId(), GetHashKey("KIT_HANDHELD_CATALOG"), GetHashKey("MP_CATALOGUE_UNHOLSTER_S1"), 1, 0, -1082130432)
    end
)

RegisterNetEvent("FRP:SHOP:OpenShopByName")

AddEventHandler(
    "FRP:SHOP:OpenShopByName",
    function(shopName)
        local shopIndex = getShopIndexByName(shopName)

        if shopIndex then
            TriggerServerEvent("FRP:SHOP:TryToOpen", shopIndex)
        end
    end
)

function getShopIndexByName(shopName)
    for shopIndex, shop_data in pairs(Config.Shops) do
        local shop_name = shop_data.name

        if shop_name == shopName then
            return shopIndex
        end
    end
end

RegisterNUICallback(
    "select",
    function(cb)
        selected_transaction_index = cb.transactionIndex

        local shop_type = Config.Shops[selected_shop_index].type

        local transaction_data = Config.Shops[selected_shop_index].transactions[selected_transaction_index]

        local item_data = ItemList[transaction_data.item]

        local amount = transaction_data.amount or 1
        local weight = amount * item_data.weight
        local transaction_dollar = transaction_data.dollar ~= nil and transaction_data.dollar or (transaction_data.gold == nil and "GRÁTIS" or "")
        local transaction_gold = transaction_data.gold

        PromptSetVisible(prompt_transaction, true)

        if shop_type == "buy" then
            if tonumber(transaction_dollar) or transaction_gold then
                if transaction_gold then
                    PromptSetText(prompt_transaction, CreateVarString(10, "LITERAL_STRING", "$" .. string.format("%.2f", transaction_dollar)))

                    PromptSetVisible(prompt_transaction_extra, true)

                    PromptSetText(prompt_transaction_extra, CreateVarString(10, "LITERAL_STRING", "~t4~G" .. string.format("%.2f", transaction_gold)))
                else
                    PromptSetText(prompt_transaction, CreateVarString(10, "LITERAL_STRING", "Comprar"))
                end
            else
                PromptSetText(prompt_transaction, CreateVarString(10, "LITERAL_STRING", "Pegar"))

                PromptSetVisible(prompt_transaction_extra, false)
            end
        elseif shop_type == "sell" then
            PromptSetText(prompt_transaction, CreateVarString(10, "LITERAL_STRING", "Vender"))

            weight = nil
        end

        local data = {
            name = item_data.name,
            description = item_data.description,
            amount = amount,
            weight = weight,
            transaction_dollar = transaction_dollar,
            transaction_gold = transaction_gold
        }

        SendNUIMessage(
            {
                type = "description",
                data = data
            }
        )
    end
)

RegisterNUICallback(
    "hideNUI",
    function(data, cb)
        destroy()
    end
)

function destroy()
    SendNUIMessage(
        {
            type = "hide"
        }
    )

    SetNuiFocusKeepInput(false)
    SetNuiFocus(false, false)

    NUIOpen = false

    PromptSetVisible(prompt_open, true)
    PromptSetVisible(prompt_transaction, false)
    PromptSetVisible(prompt_transaction_extra, false)

    selected_shop_index = nil
    selected_transaction_index = nil

    ClearPedTasks(PlayerPedId())
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            destroy()

            PromptDelete(prompt_open)
            PromptDelete(prompt_transaction)
            PromptDelete(prompt_transaction_extra)
        end
    end
)
