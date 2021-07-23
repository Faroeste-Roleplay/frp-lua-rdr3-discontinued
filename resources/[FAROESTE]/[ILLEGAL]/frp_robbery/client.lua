local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

-- RegisterCommand(
--     "interiss",
--     function(source, args, rawCommand)
--         print('a,', GetInteriorFromEntity(PlayerPedId()))
--     end,
--     false
-- )

local interiors = {
    --   [1] = 72962, -- BANCO BLACKWATER
    [2] = 42754, -- BANCO SAINT DENNIS
    [3] = 29442 -- BANCO RHODES
    --  [4] = 12290 -- BANCO VALENTINE
}

local interiorIndexBeingRobbed = nil
local interiorIndexPlayerIsIn = nil

local isParticipantOfRobbery = false
local isBlockedByRobbery = false

local secondsUntilRobberyEnds = nil
local secondsUntilAbandonRobbery = nil

local shootingToStartCooldown = false

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            local ped = PlayerPedId()

            local interiorIdPlayerIsIn = GetInteriorFromEntity(ped)

            if interiorIdPlayerIsIn ~= 0 then
                for index, interiorId in pairs(interiors) do
                    if interiorIdPlayerIsIn == interiorId then
                        -- print(index)
                        interiorIndexPlayerIsIn = index
                    end
                end
            else
                interiorIndexPlayerIsIn = nil
            end
        end
    end
)

Citizen.CreateThread(
    function()
        ClearPedTasksImmediately(PlayerPedId())

        --AddTextEntry("shoot_to_start", "Atire para começar o assalto")
        --AddTextEntry("wait_to_shoot", "Aguarde 10 segundos...")
        local hashUnarmed = GetHashKey("WEAPON_UNARMED")
        while true do
            Citizen.Wait(0)

            if interiorIndexPlayerIsIn ~= nil then
                local ped = PlayerPedId()
                local retval, weaponHash = GetCurrentPedWeapon(ped, 1)
                if weaponHash ~= hashUnarmed then
                    if interiorIndexBeingRobbed == nil then
                        if not shootingToStartCooldown then
                            notify("Atire para começar o assalto.")
                            --  TriggerEvent('FRP:Notify', 'Atire para começar o assalto.')
                            if IsPedShooting(ped) then
                                initShootingCountdown()

                                -- print("Roubo começo!!")

                                local playerId = PlayerId()
                                local interiorIdPlayerIsIn = interiors[interiorIndexPlayerIsIn]

                                local participants = {
                                    GetPlayerServerId(playerId)
                                }

                                for _, activePlayerId in pairs(GetActivePlayers()) do
                                    if activePlayerId ~= playerId then
                                        local activePlayerPed = GetPlayerPed(activePlayerId)
                                        if activePlayerPed ~= 0 then
                                            local activePlayerPedInterior = GetInteriorFromEntity(activePlayerPed)
                                            if activePlayerPedInterior == interiorIdPlayerIsIn then
                                                table.insert(participants, GetPlayerServerId(activePlayerId))
                                            end
                                        end
                                    end
                                end

                                if NetworkIsSessionActive() == 1 then
                                    TriggerServerEvent("FRP:ROBBERY:TryToStartRobbery", interiorIndexPlayerIsIn, participants)
                                else
                                    cAPI.notify("error", "Sessão solo!")
                                end
                            end
                        else
                            -- notify('Aguarde 10 segundos...')
                            -- DisplayHelpTextThisFrame("wait_to_shoot", false)
                            --TriggerEvent('FRP:Notify', 'Aguarde 10 segundos...')
                        end
                    else
                        if IsPedShooting(ped) then
                        --notify('Roubo em andamento, aguarde...')
                        -- print("Roubo em andamento, aguarde")
                        end
                    end

                -- Block player actions if they are not an active participant
                end

                if isBlockedByRobbery then
                    if interiorIndexBeingRobbed == nil then
                        isBlockedByRobbery = false
                        RemoveAnimDict("random@arrests@busted")
                        ClearPedTasks(ped)
                    else
                        -- DisableControlAction(0, 24, true)
                        --  DisableControlAction(0, 25, true)
                        --  DisableControlAction(0, 140, true)
                        --  DisableControlAction(0, 141, true)
                        -- DisableControlAction(0, 142, true)
                        --  DisableControlAction(0, 257, true)
                        --  DisableControlAction(0, 263, true)
                        --   DisableControlAction(0, 264, true)

                        if weaponHash ~= hashUnarmed then
                            SetCurrentPedWeapon(ped, hashUnarmed, true)
                        end
                        if not IsEntityPlayingAnim(ped, "script_proc@robberies@homestead@lonnies_shack@deception", "hands_up_loop", 3) then
                            TaskPlayAnim(ped, "script_proc@robberies@homestead@lonnies_shack@deception", "hands_up_loop",  2.0, -2.0, -1, 67109393, 0.0, false, 1245184, false, "UpperbodyFixup_filter", false)
                        end
                    end
                end
                if interiorIndexPlayerIsIn == interiorIndexBeingRobbed then
                    if secondsUntilRobberyEnds ~= nil then
                        -- local hours = secondsUntilRobberyEnds / 3600
                        local minutes = math.floor((secondsUntilRobberyEnds % 3600) / 60)
                        local seconds = secondsUntilRobberyEnds % 60
                        drawText(minutes .. " minutos e " .. seconds .. " segundos", true)
                    end
                end
            else
                if secondsUntilAbandonRobbery ~= nil then
                    drawText("~r~Volte para dentro do banco! " .. math.floor((secondsUntilAbandonRobbery / 10)) .. " segundos", true)
                end
            end
            --print(secondsUntilAbandonRobbery)
        end
    end
)

function initCheckPedIsOutside()
    isParticipantOfRobbery = true
    Citizen.CreateThread(
        function()
            local defaultSeconds = 5
            defaultSeconds = defaultSeconds * 10 -- 100ms (Wait) * 50 = 5000ms
            secondsUntilAbandonRobbery = defaultSeconds
            while isParticipantOfRobbery do
                Citizen.Wait(100)

                local ped = PlayerPedId()

                local interiorIdBeingRobbed = interiors[interiorIndexBeingRobbed]
                local interiorIdPlayerIsIn = GetInteriorFromEntity(ped)

                if interiorIdPlayerIsIn ~= interiorIdBeingRobbed then
                    if secondsUntilAbandonRobbery == nil then
                        secondsUntilAbandonRobbery = defaultSeconds
                    end

                    secondsUntilAbandonRobbery = secondsUntilAbandonRobbery - 1 -- Wait ms
                    if secondsUntilAbandonRobbery <= 0 then
                        if not isBlockedByRobbery then
                            -- print("Você ficou tempo demais fora do roubo")
                            TriggerServerEvent("FRP:ROBBERY:PlayerAbandonedRobbery")
                        else
                            -- print("Você ficou tempo demais fora do roubo blocked")
                            isBlockedByRobbery = false
                            ClearPedTasks(ped)
                        end

                        TriggerEvent("FRP:ROBBERY:EndRobbery")

                        break
                    end
                else
                    if secondsUntilAbandonRobbery ~= nil then
                        secondsUntilAbandonRobbery = nil
                    end
                end
            end

            if not isParticipantOfRobbery then
                local ped = PlayerPedId()
                if IsEntityPlayingAnim(ped, "random@arrests@busted", "idle_a", 3) then
                    ClearPedTasks(ped)
                end
            end
        end
    )
end

function initSecondsCountdown(seconds)
    -- print("got seconds", seconds)
    secondsUntilRobberyEnds = seconds

    Citizen.CreateThread(
        function()
            while secondsUntilRobberyEnds ~= nil do
                Citizen.Wait(1000)
                if secondsUntilRobberyEnds ~= nil then
                    secondsUntilRobberyEnds = secondsUntilRobberyEnds - 1

                    if secondsUntilRobberyEnds == 0 then
                        secondsUntilRobberyEnds = nil
                    end
                end
            end
        end
    )
end

function initShootingCountdown()
    shootingToStartCooldown = true
    seconds = 10

    Citizen.CreateThread(
        function()
            while seconds > 0 do
                Citizen.Wait(1000)
                seconds = seconds - 1
            end
            shootingToStartCooldown = false
        end
    )
end

RegisterNetEvent("FRP:ROBBERY:StartRobbery")
AddEventHandler(
    "FRP:ROBBERY:StartRobbery",
    function(index, asParticipant, seconds)
        interiorIndexBeingRobbed = index
        if asParticipant then
            initCheckPedIsOutside()
            initSecondsCountdown(seconds)
            cAPI.AddWantedTime(true, 30)
        end
        TriggerEvent("FRP:TOAST:New", "alert", "O assalto acabará em " .. seconds .. " segundos")
    end
)

RegisterNetEvent("FRP:ROBBERY:StartRobberyAsBlocked")
AddEventHandler(
    "FRP:ROBBERY:StartRobberyAsBlocked",
    function(index)
        interiorIndexBeingRobbed = index
        isBlockedByRobbery = true
        initCheckPedIsOutside()

        if not HasAnimDictLoaded("random@arrests@busted") then
            RequestAnimDict("random@arrests@busted")
        end
    end
)

RegisterNetEvent("FRP:ROBBERY:EndRobbery")
AddEventHandler(
    "FRP:ROBBERY:EndRobbery",
    function()
        interiorIndexBeingRobbed = nil

        isParticipantOfRobbery = false
        isBlockedByRobbery = false

        secondsUntilRobberyEnds = nil
        secondsUntilAbandonRobbery = nil
        shootingToStartCooldown = false
    end
)

function setSatchel(model)
    if HasModelLoaded(model) then
        Citizen.InvokeNative(0xFA28FE3A6246FC3, parseInt(model))
    end
    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), parseInt(model), true, true, true)
end

RegisterNetEvent("FRP:ROBBERY:Bolsa")
AddEventHandler(
    "FRP:ROBBERY:Bolsa",
    function()
        --   cAPI.AddWantedTime(true, 30)

        if IsPedMale(PlayerPedId()) then
            setSatchel(0xEA272E11)
        else
            setSatchel(0xFCAF241B)
        end
    end
)

local lastDisplayedText
local lastVarString

function drawText(str, center)
    local x = 0.87
    local y = 0.95
    if lastDisplayedText == nil or lastDisplayedText ~= str then
        lastDisplayedText = str
        lastVarString = CreateVarString(10, "LITERAL_STRING", str)
    end
    SetTextScale(0.4, 0.4)
    SetTextColor(255, 255, 255, 255)
    Citizen.InvokeNative(0xADA9255D, 1)
    --DisplayText(str, x, y)
    if center then
        SetTextCentre(center)
        DisplayText(lastVarString, x, y)
    elseif alignRight then
        DisplayText(lastVarString, x + 0.15, y)
    else
        DisplayText(lastVarString, x, y)
    end
end

function notify(_message)
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", _message, Citizen.ResultAsLong())
    SetTextScale(0.25, 0.25)
    SetTextCentre(1)
    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
end

-- function drawText(text)
--     SetTextFont(0)
--     SetTextProportional(1)
--     SetTextScale(0.0, 0.3)
--     SetTextColour(128, 128, 128, 255)
--     SetTextDropshadow(0, 0, 0, 0, 255)
--     SetTextEdge(1, 0, 0, 0, 255)
--     SetTextDropShadow()
--     SetTextOutline()
--     SetTextEntry("STRING")
--     AddTextComponentString(text)
--     DrawText(0.5, 0.5)
-- end
