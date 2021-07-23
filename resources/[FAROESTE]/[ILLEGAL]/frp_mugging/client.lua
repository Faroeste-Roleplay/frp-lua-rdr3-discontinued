local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

cAPI = Proxy.getInterface('API')
API = Tunnel.getInterface('API')

local muggablePlayer

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(100)
            local nearestPlayer = cAPI.getNearestPlayer(1.5)
            if nearestPlayer ~= nil then
                if IsEntityPlayingAnim(GetPlayerPed(player), "script_proc@robberies@homestead@lonnies_shack@deception", "hands_up_loop", 3) then
                    muggablePlayer = nearestPlayer
                else
                    muggablePlayer = nil
                end
            else
                muggablePlayer = nil
            end
        end
    end
)

Citizen.CreateThread(
    function()
        local prompt = PromptRegisterBegin()
        local promptGroup = GetRandomIntInRange(0, 0xffffff)
        PromptSetControlAction(prompt, 0xCEFD9220)
        local str = CreateVarString(10, 'LITERAL_STRING', 'Assaltar')
        PromptSetText(prompt, str)
        PromptSetEnabled(prompt, 1)
        PromptSetVisible(prompt, 1)
        PromptSetHoldMode(prompt, 1)

        PromptSetGroup(prompt, promptGroup)
        PromptRegisterEnd(prompt)
        while true do
            Citizen.Wait(0)

            if muggablePlayer ~= nil then
                local promptGroupName = CreateVarString(10, 'LITERAL_STRING', GetPlayerName(muggablePlayer))
                PromptSetActiveGroupThisFrame(promptGroup, promptGroupName)
                if PromptHasHoldModeCompleted(prompt) then
                    Citizen.Wait(1000)
                    TriggerServerEvent('FRP:MUGGIN:TryToMug', GetPlayerServerId(muggablePlayer))
                end
            end
        end
    end
)
