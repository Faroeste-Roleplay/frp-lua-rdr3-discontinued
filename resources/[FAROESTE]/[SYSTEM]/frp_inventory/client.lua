local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            if IsControlJustPressed(0, 0xC1989F95) and not opened then
                TriggerServerEvent("FRP:INVENTORY:OpenPersonal")
                opened = true
            end

            if IsControlJustPressed(0, 0x8AAA0AD4) and not opened  then
                SendNUIMessage(
                    {
                        type = "showHotbar"
                    }
                )
                Wait(500)
            end

            --[[
            if IsControlJustPressed(0, 0x3076E97C) then -- NUMPAD 6
                SendNUIMessage(
                    {
                        type = "nextHotbarSlot"
                    }
                )
                Wait(500)
            end 
            --]]
        end
    end
)

local whereWeaponIsAtSlot = {}
local isReloadingOrShooting = false

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            local ped = PlayerPedId()

            -- 0x24B100C68C645951 IS_PED_RELOADING
            local _, currentWeapon = GetCurrentPedWeapon(ped, true, 0, true)
            if currentWeapon ~= GetHashKey("weapon_lasso") then
                if IsPedShooting(ped) or Citizen.InvokeNative(0x24B100C68C645951, ped) then
                    -- local wasReloading = false
                    while Citizen.InvokeNative(0x24B100C68C645951, ped) do
                        -- wasReloading = true
                        Citizen.Wait(0)
                    end
                    isReloadingOrShooting = true
                    for weaponId, slotId in pairs(whereWeaponIsAtSlot) do
                        local weaponHash = GetHashKey(weaponId)
                        if currentWeapon == weaponHash then
                            local _, inClip = GetAmmoInClip(ped, weaponHash)

                            local inWeapon = GetAmmoInPedWeapon(ped, weaponHash)
                            local ammoRemaining = math.floor(inWeapon - inClip)

                            TriggerServerEvent("FRP:INVENTORY:SaveWeaponAmmoOnDB", slotId, inClip, ammoRemaining)
                        end
                    end
                end
            end
        end
    end
)

-- local currentlyTryingToSendItem = false
-- local prompt_senditem

-- function startLookingForAPlayerToSend(slotId)
--     if currentlyTryingToSendItem then
--         return
--     end

--     closeInv()

--     currentlyTryingToSendItem = true

--     local lastTargetPlayerServerId = nil

--     prompt_senditem = PromptRegisterBegin()
--     PromptSetControlAction(prompt_senditem, 0x07CE1E61)
--     PromptSetText(prompt_senditem, CreateVarString(10, "LITERAL_STRING", "Enviar"))
--     PromptSetEnabled(prompt_senditem, true)
--     PromptSetVisible(prompt_senditem, false)
--     PromptSetHoldMode(prompt_senditem, true)
--     PromptRegisterEnd(prompt_senditem)

--     Citizen.CreateThread(
--         function()
--             local timeRemaining = 10
--             while currentlyTryingToSendItem do
--                 local y, entity = GetPlayerTargetEntity(PlayerId())

--                 lastTargetPlayerServerId = nil

--                 if y then
--                     for _, pid in pairs(GetActivePlayers()) do
--                         if NetworkIsPlayerActive(pid) then
--                             local pped = GetPlayerPed(pid)
--                             if entity == pped then
--                                 local serverId = GetPlayerServerId(pid)
--                                 if lastTargetPlayerServerId ~= serverId then
--                                     lastTargetPlayerServerId = serverId
--                                     PromptSetVisible(prompt_senditem, true)
--                                     PromptSetGroup(prompt_senditem, PromptGetGroupIdForTargetEntity(entity))

--                                     local pPosition = GetEntityCoords(PlayerPedId())
--                                     local tPosition = GetEntityCoords(entity)

--                                     local dist = #(pPosition - tPosition)

--                                     if dist <= 1.5 then
--                                         PromptSetEnabled(prompt_senditem, true)
--                                     else
--                                         PromptSetEnabled(prompt_senditem, false)
--                                     end

--                                     break
--                                 end
--                             end
--                         end
--                     end
--                 end

--                 if lastTargetPlayerServerId == nil then
--                     PromptSetVisible(prompt_senditem, false)
--                 end

--                 Citizen.Wait(250)

--                 timeRemaining = timeRemaining - 0.25

--                 if timeRemaining <= 0 then
--                     currentlyTryingToSendItem = false
--                 end
--             end
--         end
--     )

--     Citizen.CreateThread(
--         function()
--             while currentlyTryingToSendItem do
--                 Citizen.Wait(0)
--                 if lastTargetPlayerServerId ~= nil then
--                     if PromptHasHoldModeCompleted(prompt_senditem) then
--                         PromptDelete(prompt_senditem)
--                         prompt_senditem = nil

--                         currentlyTryingToSendItem = false
--                         TriggerServerEvent("FRP:INVENTORY:SendToPlayer", slotId, lastTargetPlayerServerId)
--                     end
--                 end
--             end

--             PromptDelete(prompt_senditem)
--             prompt_senditem = nil
--         end
--     )
-- end

RegisterNetEvent("FRP:INVENTORY:ToggleHotbar")
AddEventHandler(
    "FRP:INVENTORY:ToggleHotbar",
    function(bool)
        SendNUIMessage(
            {
                type = "ToggleHotbar",
                val = bool
            }
        )
    end
)

RegisterNetEvent("FRP:INVENTORY:closeInv")
AddEventHandler(
    "FRP:INVENTORY:closeInv",
    function()
        closeInv()
    end
)

RegisterNetEvent("FRP:INVENTORY:NUICloseNoCallback")
AddEventHandler(
    "FRP:INVENTORY:NUICloseNoCallback",
    function()
        closeInv(false)
    end
)

RegisterNetEvent("FRP:INVENTORY:openAsPrimary")
AddEventHandler(
    "FRP:INVENTORY:openAsPrimary",
    function(slots, inventoryWeight, inventoryMaxWeight)
        slots = computeSlots(slots, true)

        SetNuiFocus(true, true)
        SendNUIMessage(
            {
                type = "clearPrimary",
                primarySlots = slots,
                primaryWeight = inventoryWeight,
                primaryMaxWeight = inventoryMaxWeight
            }
        )
    end
)

RegisterNetEvent("FRP:INVENTORY:openAsSecondary")
AddEventHandler(
    "FRP:INVENTORY:openAsSecondary",
    function(slots, inventoryWeight, inventoryMaxWeight)
        slots = computeSlots(slots, false)

        SetNuiFocus(true, true)
        SendNUIMessage(
            {
                type = "clearSecondary",
                secondarySlots = slots,
                secondaryWeight = inventoryWeight,
                secondaryMaxWeight = inventoryMaxWeight
            }
        )
    end
)

RegisterNetEvent("FRP:INVENTORY:PrimarySyncSlots")
AddEventHandler(
    "FRP:INVENTORY:PrimarySyncSlots",
    function(slots, inventoryWeight)
        slots = computeSlots(slots, true)

        SendNUIMessage(
            {
                primarySlots = slots,
                primaryWeight = inventoryWeight
            }
        )
    end
)

RegisterNetEvent("FRP:INVENTORY:SecondarySyncSlots")
AddEventHandler(
    "FRP:INVENTORY:SecondarySyncSlots",
    function(slots, inventoryWeight)
        slots = computeSlots(slots, false)

        SendNUIMessage(
            {
                secondarySlots = slots,
                secondaryWeight = inventoryWeight
            }
        )
    end
)

RegisterNUICallback(
    "use",
    function(cb)
        TriggerServerEvent("FRP:INVENTORY:Use", tonumber(cb.slotId))
    end
)

RegisterNUICallback(
    "drop",
    function(cb)
        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
        TriggerServerEvent("FRP:INVENTORY:Drop", tonumber(cb.slotId), x, y, z)
    end
)

-- RegisterNUICallback(
--     "startsendingslot",
--     function(cb)
--         -- startLookingForAPlayerToSend(cb.slotId)
--         TriggerEvent("FRP:PLAYERPROMPTS:TryToSendItemSlotToTarget", cb.slotId)
--     end
-- )

RegisterNUICallback(
    "moveSlotToPrimary",
    function(cb)
        TriggerServerEvent("FRP:INVENTORY:moveSlotToPrimary", cb.slotId, cb.itemAmount)
    end
)

RegisterNUICallback(
    "moveSlotToSecondary",
    function(cb)
        TriggerServerEvent("FRP:INVENTORY:moveSlotToSecondary", cb.slotId, cb.itemAmount)
    end
)

RegisterNUICallback(
    "primarySwitchSlot",
    function(cb)
        TriggerServerEvent("FRP:INVENTORY:PrimarySwitchSlot", cb.slotFrom, cb.slotTo, cb.itemAmount)
    end
)

RegisterNUICallback(
    "secondarySwitchSlot",
    function(cb)
        TriggerServerEvent("FRP:INVENTORY:SecondarySwitchSlot", cb.slotFrom, cb.slotTo, cb.itemAmount)
    end
)

-- RegisterNUICallback(
--     "interactWithHotbarSlot",
--     function(cb)
--         local itemId = cb.itemId or "unarmed"
--         local weaponId = "weapon_" .. itemId
--         local weaponHash = GetHashKey(weaponId)

--         local ped = PlayerPedId()

--         local _, currentWeapon = GetCurrentPedWeapon(ped, true, 0, true)
--         if currentWeapon ~= weaponHash then
--             Citizen.InvokeNative(0x5E3BDDBCB83F3D84, ped, weaponHash, 0, true, true)
--             TaskReloadWeapon(ped, 0)
--         end
--     end
-- )

RegisterNUICallback(
    "NUIFocusOff",
    function()
        closeInv()
    end
)

AddEventHandler(
    "onResourceStart",
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end
        closeInv()
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end
        if prompt_senditem ~= nil then
            PromptDelete(prompt_senditem)
        end
    end
)

function closeInv(callback)
    SetNuiFocus(false, false)
    SendNUIMessage(
        {
            action = "hide"
        }
    )
    opened = false
    if callback == nil or callback == true then
    TriggerServerEvent("FRP:INVENTORY:Close")
    end
end

function computeSlots(table, asPrimary)
    local ped = PlayerPedId()
    for slotId, values in pairs(table) do
        local itemInfo = ItemList[values.name]

        if itemInfo ~= nil then
            local itemId = values.name
            local itemAmount = values.amount[1]

            local ammoInClip = values.amount[2]
            local ammoInWeapon = values.amount[3]
           
            values.itemName = itemInfo.name
            values.itemDescription = itemInfo.description or "Descrição"
            values.itemStackSize = itemInfo.stackSize or 1

            local itemType = itemInfo.type

            if itemInfo.type == "weapon" and asPrimary then
                -- ammoInClip = ammoInClip - 1
                values.amount[2] = ammoInClip
                values.amount[3] = ammoInWeapon

                if (slotId >= 129 and slotId <= 132) then
                    -- if not shotOrReloaded then
                    local weaponId = "weapon_" .. itemId
                    local weaponHash = GetHashKey(weaponId)

                    whereWeaponIsAtSlot[weaponId] = nil

                    if itemAmount > 0 then
                        for wId, slot in pairs(whereWeaponIsAtSlot) do
                            if slot == slotId and weaponId ~= wId then
                                local foundHash = GetHashKey(wId)
                                SetPedAmmo(ped, foundHash, 0)
                                RemoveWeaponFromPed(ped, foundHash)
                                whereWeaponIsAtSlot[wId] = nil
                            end
                        end

                        if not HasPedGotWeapon(ped, weaponHash, false) then
                            -- GiveWeaponToPed(ped, weaponHash, ammoInWeapon, false, false)
                            -- cAPI.giveWeapon(weaponId, ammoInWeapon, false)
                            Citizen.InvokeNative(0x5E3BDDBCB83F3D84, ped, weaponHash, ammoInWeapon, true, true)
                        end

                        SetPedAmmo(ped, weaponHash, ammoInWeapon)
                        SetAmmoInClip(ped, weaponHash, ammoInClip)

                        whereWeaponIsAtSlot[weaponId] = slotId
                    else
                        if HasPedGotWeapon(ped, weaponHash, false) then
                            SetPedAmmo(ped, weaponHash, 0)
                            RemoveWeaponFromPed(ped, weaponHash)
                        end
                    end
                -- end
                end
            end
        end
    end

    return table
end

RegisterCommand(
    "enviar",
    function(source, args, raw)
        if #args < 2 then
            cAPI.notify("error", "Sintaxe: /enviar nomedoitem 2")
            return
        end

        if cAPI.IsWanted() then
            TriggerEvent('FRP:NOTIFY:Simple', 'Você ainda está como procurado, não pode transferir um item. ', 10000)
            return
        end

       -- local targetPlayerServerId = cAPI.getNearestPlayer(1.5)

        local targetPlayerServerId, distance = GetClosestPlayer()
       
        if targetPlayerServerId == nil then
            cAPI.notify('error', 'Ninguem por perto')
            return
        end

        local itemAmountArg
        local itemAmount

        for i = 1, #args do
            if tonumber(args[i]) ~= nil then
                itemAmountArg = i
                itemAmount = tonumber(args[i])
            end
        end

        local concated = args[1]

        if #args > 2 then
            for i = 2, itemAmountArg - 1 do
                concated = concated .. " " .. args[i]
            end
        end

        local lastDistance
        local lastName
        local lastItemId

        for itemId, d in pairs(ItemList) do
            local dist = levenshtein_distance(concated, d.name)

            if lastDistance == nil or dist < lastDistance then
               lastDistance = dist
               lastName = d.name
               lastItemId = itemId
            end
        end

        if lastItemId == 'money' or lastItemId == 'gold' then
            itemAmount = itemAmount * 100
        end

        if targetPlayerServerId ~= nil then
            local nearestPed = GetPlayerPed(player)     
            if distance ~= -1 and distance <= 3.0 then
                TriggerServerEvent("FRP:INVENTORY:SendItemIdAndAmountToPlayer", lastItemId, itemAmount, targetPlayerServerId) 
            end
        end
  
    end,
    false
)


function levenshtein_distance(str1, str2)
    local len1, len2 = #str1, #str2
    local char1, char2, distance = {}, {}, {}
    str1:gsub(
        ".",
        function(c)
            table.insert(char1, c)
        end
    )
    str2:gsub(
        ".",
        function(c)
            table.insert(char2, c)
        end
    )
    for i = 0, len1 do
        distance[i] = {}
    end
    for i = 0, len1 do
        distance[i][0] = i
    end
    for i = 0, len2 do
        distance[0][i] = i
    end
    for i = 1, len1 do
        for j = 1, len2 do
            distance[i][j] = math.min(distance[i - 1][j] + 1, distance[i][j - 1] + 1, distance[i - 1][j - 1] + (char1[i] == char2[j] and 0 or 1))
        end
    end
    return distance[len1][len2]
end


function GetPlayers()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then
            table.insert(players, player)
        end
    end
    return players
end

function GetClosestPlayer()
    local players, closestDistance, closestPlayer = GetPlayers(), -1, -1
    local coords, usePlayerPed = coords, false
    local playerPed, playerId = PlayerPedId(), PlayerId()
    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        usePlayerPed = true
        coords = GetEntityCoords(playerPed)
    end
    for i = 1, #players, 1 do
        local target = GetPlayerPed(players[i])
        if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then
            local targetCoords = GetEntityCoords(target)
            local distance = #(coords - targetCoords)
            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = players[i]
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end