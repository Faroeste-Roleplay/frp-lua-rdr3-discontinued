keys = {
    ["G"] = 0x760A9C6F,
    ["S"] = 0xD27782E3,
    ["W"] = 0x8FD015D8,
    ["H"] = 0x24978A28,
    ["G"] = 0x5415BE48,
    ["E"] = 0xDFF812F9
}

local prompts = {}

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)
-- 		local playerPed = PlayerPedId()
-- 		local coords = GetEntityCoords(playerPed)

-- 			for k,v in pairs(Config.Coords) do
-- 					if Vdist(coords, v) < 2 then
-- 						DrawTxt(Config.Shoptext, 0.30, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
-- 						if IsControlJustReleased(0, keys['E']) then
-- 							print('apertou')
-- 							TriggerServerEvent('frp_heal:heallife', 2)
-- 						end
-- 					end
-- 			end
-- 	end
-- end)

local shops = {
    {-285.87, 805.07, 119.39}, --VALENTINE
    {2730.295, -1231.783, 50.376} -- SAINT DENIS
}

Citizen.CreateThread(
    function()
        for _, values in pairs(shops) do
            -- local blip = N_0x554d9d53f696d002(1664425300, values[1], values[2], values[3])
            -- SetBlipSprite(blip, -145868367, 1)
            -- Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Loja de Armas')

            local prompt = PromptRegisterBegin()
            PromptSetControlAction(prompt, 0xE8342FF2)
            PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Atendimento Médico"))
            PromptSetEnabled(prompt, 1)
            PromptSetVisible(prompt, 1)
            PromptSetHoldMode(prompt, 1)
            PromptSetPosition(prompt, values[1], values[2], values[3])
            N_0x0c718001b77ca468(prompt, 3.0)
            -- PrompContextSetSize(prompt, 3.0)
            PromptRegisterEnd(prompt)
            table.insert(prompts, prompt)
        end
    end
)

-- Key Controls
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            for _, prompt in pairs(prompts) do
                if PromptHasHoldModeCompleted(prompt) then
                    TriggerServerEvent("frp_heal:heallife", 4000)

                    PromptSetEnabled(prompt, false)
                    Citizen.CreateThread(
                        function()
                            Citizen.Wait(1000)
                            PromptSetEnabled(prompt, true)
                        end
                    )
                end
            end
        end
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            for _, prompt in pairs(prompts) do
                PromptDelete(prompt)
            end
        end
    end
)

RegisterNetEvent("Message:cancel")
AddEventHandler(
    "Message:cancel",
    function()
        local timer = 200
        while timer > 0 do
            Citizen.Wait(0)
            DrawTxt(Config.NoMoney, 0.30, 0.90, 0.4, 0.4, true, 255, 255, 255, 150, false)
            timer = timer - 1
        end
    end
)

-- coreType = 0 (health), 1 (stamina), 2 (deadeye)
-- coreAmount = range between 0 (empty) and 100 (full)

RegisterNetEvent("heal:player")
AddEventHandler(
    "heal:player",
    function()
        Citizen.CreateThread(
            function()
                local playerPed = PlayerPedId()
                Wait(1000)

                if IsEntityDead(PlayerPedId()) then
                    NetworkResurrectLocalPlayer(GetEntityCoords(PlayerPedId()), true, true, false)
                    DestroyAllCams(true)
                    SetEntityHealth(PlayerPedId(), 2)
                    return
                end

                local maxHealth = GetEntityMaxHealth(playerPed)
                Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, 100)
                Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 1, 100)
                SetEntityHealth(playerPed, 250)
                SetPlayerHealthRechargeMultiplier(playerPed, 2000)
            end
        )
    end
)

RegisterNetEvent("heal:playeritem")
AddEventHandler(
    "heal:playeritem",
    function()
        Citizen.CreateThread(
            function()
                local playerPed = PlayerPedId()

                if IsEntityDead(PlayerPedId()) then
                    NetworkResurrectLocalPlayer(GetEntityCoords(PlayerPedId()), true, true, false)
                    DestroyAllCams(true)
                    SetEntityHealth(PlayerPedId(), 2)
                    return
                end

                local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
                Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_DRINK_FLASK"), 5000, true, false, false, false)
                Wait(1000)
                local maxHealth = GetEntityMaxHealth(playerPed)
                Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, 100)
                SetEntityHealth(playerPed, 250)
                SetPlayerHealthRechargeMultiplier(playerPed, 2000)
            end
        )
    end
)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    Citizen.InvokeNative(0xADA9255D, 10)
    DisplayText(str, x, y)
end
