local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local hash
local nearestPlayers

local spotPool = {
    vec3(-374.009,724.092,116.359), -- Criar posse em um lugar
}

local closestSpotIndex

local prompt
local prompt_name = CreateVarString(10, "LITERAL_STRING", "Bando")

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            closeToPosser = false
            local ped = PlayerPedId()
            local pedVec = GetEntityCoords(ped)

            local closestDist

            for _, v in pairs(spotPool) do
                local dist = #(pedVec - v)
                if (dist <= 5 and closestDist == nil) or (closestDist ~= nil and dist < closestDist) then
                    closestDist = dist
                    closestSpotIndex = _
                else
                    closestDist = nil
                    closestSpotIndex = nil
                end
            end
        end
    end
)

RegisterNetEvent("VP:POSSE:SetPosse")
AddEventHandler(
    "VP:POSSE:SetPosse",
    function(id)
        if id ~= nil then
            local _, h = AddRelationshipGroup('posse:' .. id)
            hash = b
            SetPedRelationshipGroupHash(ped, hash)
        else
            hash = nil
            SetPedRelationshipGroupHash(ped, GetHashKey("PLAYER"))
        end
    end
)

Citizen.CreateThread(
    function()
        InitiatePrompts()
        while true do
            Citizen.Wait(0)
            if closestSpotIndex ~= nil then
                PromptSetActiveGroupThisFrame(prompt_group, prompt_name)
                HandlePrompts()
            end
        end
    end
)

function HandlePrompts()
    if PromptHasHoldModeCompleted(prompt) then
        PromptSetEnabled(prompt, false)
        Citizen.CreateThread(
            function()
                Citizen.Wait(1000)
                PromptSetEnabled(prompt, true)
            end
        )     
        TriggerServerEvent('VP:POSSE:checkBando')        
    end
end


function InitiatePrompts()
    prompt_group = GetRandomIntInRange(0, 0xffffff)

    prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, 0xE8342FF2)
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Criar Bando"))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, true)
    -- Citizen.InvokeNative(0xAE84C5EE2C384FB3, prompt, position)
    -- Citizen.InvokeNative(0x0C718001B77CA468, prompt, 3.0)
    PromptSetGroup(prompt, prompt_group)
    PromptRegisterEnd(prompt)
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if GetCurrentResourceName() == resourceName then
            -- for _, prompt in pairs(prompts) do
            PromptDelete(prompt)
        -- end
        end
    end
)

RegisterNetEvent("VP:POSSE:OpenMenu")
AddEventHandler(
    "VP:POSSE:OpenMenu",
    function(data, clanName)
        SetNuiFocus(true, true)
        SendNUIMessage(
            {
                action = "open",
                clanName = clanName,
                data = data,
                nearestPlayers = nearestPlayers
            }
        )
    end
)

RegisterNetEvent("VP:POSSE:CloseMenu")
AddEventHandler(
    "VP:POSSE:CloseMenu",
    function()
        SetNuiFocus(false, false)
        SendNUIMessage(
            {
                action = "close"
            }
        )
    end
)

RegisterNUICallback(
    "NUICallbackOff",
    function()
        SetNuiFocus(false, false)
    end
)

RegisterNUICallback(
    "promote",
    function(charId)
        print(charId)
        TriggerServerEvent("VP:POSSE:Promote", charId.charId)
    end
)

RegisterNUICallback(
    "demote",
    function(charId)
         print(charId)
        TriggerServerEvent("VP:POSSE:Demote", charId.charId)
    end
)

RegisterNUICallback(
    "kick",
    function(charId)
        TriggerServerEvent("VP:POSSE:Kick", charId.charId)
    end
)

RegisterNUICallback(
    "leave",
    function()
        TriggerServerEvent("VP:POSSE:Leave")
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end
        SetNuiFocus(false, false)
        SendNUIMessage(
            {
                action = "close"
            }
        )
        SetPedRelationshipGroupHash(PlayerPedId(), GetHashKey("PLAYER"))
    end
)
