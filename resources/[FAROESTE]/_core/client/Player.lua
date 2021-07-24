local gPedModel
local gCharAppearence
local gLastPosition
local gStats

function cAPI.setDataAppearence(pedModel, charAppearence)
    gPedModel = pedModel
    gCharAppearence = charAppearence
end

function cAPI.Initialize(pedModel, charAppearence, lastPosition, stats)
    charAppearence = charAppearence[1] 

    gPedModel = pedModel
    gCharAppearence = charAppearence
    gLastPosition = lastPosition
    gStats = stats   


    local decodedLastPosition = json.decode(lastPosition)
    if decodedLastPosition.x ~= nil then
        decodedLastPosition = {decodedLastPosition.x, decodedLastPosition.y, decodedLastPosition.z}
    end

    local pScale = gCharAppearence.pedSize
    -- local pClothing

    -- if type(clothing) ~= "string" then
    --     if clothing <= 100 then
    --         pClothing = clothing
    --     end
    -- else
    --     pClothing = json.decode(clothing)
    -- end

    local pStats = stats

    Citizen.CreateThread(
        function()
            cAPI.PlaySkyCameraAnimationAtCoords(decodedLastPosition)
            cAPI.PlayerAsInitialized(true)
        end
    )

    cAPI.replaceWeapons({})
    
    cAPI.SetPlayerPed(pedModel)

    cAPI.setPlayerAppearence(PlayerPedId())
 --   cAPI.SetPedCloAthing(PlayerPedId(), pClothing)

    pHealth = pStats[1] or 250
    pStamina = pStats[2] or 34.0
    pHealthCore = pStats[3] or 100
    pStaminaCore = pStats[3] or 100

    Wait(3000)

    cAPI.VaryPlayerHealth(pHealth)
    cAPI.VaryPlayerStamina(pStamina)
    cAPI.VaryPlayerCore(0, pHealthCore)
    cAPI.VaryPlayerCore(1, pStaminaCore)

    TriggerServerEvent("FRP:RESPAWN:CheckDeath")
    TriggerServerEvent("API:pre_OnUserCharacterInitialization")
    
    if not cAPI.isStartedNeeds() then
        cAPI.startNeeds()
    end
end

function cAPI.setPlayerAppearence(playerId)

    --cAPI.SetPedBodyType(PlayerPedId(), pBodySize)    

    cAPI.SetSkin(playerId, gCharAppearence.enabledComponents)   

    cAPI.SetPedFaceFeature(playerId, gCharAppearence.faceFeatures)
    
    cAPI.SetPedScale(playerId, gCharAppearence.pedHeight)

    cAPI.SetPedPortAndWeight(playerId, json.decode(gCharAppearence.enabledComponents)["bodySize"], gCharAppearence.pedWeight)

    if gCharAppearence.clothes ~= nil then
        cAPI.SetSkin(playerId, gCharAppearence.clothes)   
    end
 
end


function cAPI.PlayerAsInitialized(bool)
    initializedPlayer = bool
end

function cAPI.IsPlayerInitialized()
    return initializedPlayer
end

function cAPI.notify(type, text, quantity)
    if type ~= nil and text == nil and quantity == nil then
        text = type
        type = "dev"
    end

    TriggerEvent("FRP:TOAST:New", type, text, quantity)
end

function cAPI.TeleportPlayerToWaypoint()
    if not IsWaypointActive() then
        return
    end

    local x, y, z = table.unpack(GetWaypointCoords())

    -- local ground
    -- local groundFound = false
    -- local groundCheckHeights = {
    -- 	0.0,
    -- 	50.0,
    -- 	100.0,
    -- 	150.0,
    -- 	200.0,
    -- 	250.0,
    -- 	300.0,
    -- 	350.0,
    -- 	400.0,
    -- 	450.0,
    -- 	500.0,
    -- 	550.0,
    -- 	600.0,
    -- 	650.0,
    -- 	700.0,
    -- 	750.0,
    -- 	800.0,
    -- 	850.0,
    -- 	900.0,
    -- 	950.0,
    -- 	1000.0,
    -- 	1050.0,
    -- 	1100.0
    -- }

    local ped = PlayerPedId()

    -- for i, height in ipairs(groundCheckHeights) do
    -- SetEntityCoordsNoOffset(ped, x, y, height, 0, 0, 1)

    RequestCollisionAtCoord(x, y, z)
    local retVal, groundZ, normal = GetGroundZAndNormalFor_3dCoord(x, y, z)

    if retVal == false then
        RequestCollisionAtCoord(x, y, z)
        local tries = 10
        while retVal == false and tries > 0 do
            Citizen.Wait(100)
            retVal, groundZ, normal = GetGroundZAndNormalFor_3dCoord(x, y, z)
            tries = tries - 1
        end

        z = (groundZ or 2000.0) + 1.0
    end
    -- end

    -- if not groundFound then
    -- 	z = 1200
    -- end

    SetEntityCoordsNoOffset(ped, x, y, z, 0, 0, 1)
end

function cAPI.IsPlayerMountedOnOwnHorse()
    local mount = GetMount(PlayerPedId())

    if mount ~= 0 and mount == cAPI.GetPlayerHorse() then
        return true
    end

    return false
end

function cAPI.SetPlayerPosition(x, y, z)
    SetEntityCoords(PlayerPedId(), x + 0.0001, y + 0.0001, z + 0.0001, 1, 0, 0, 1)
end

function cAPI.VaryPlayerHealth(variation, variationTime)
    cAPI.VaryPedHealth(PlayerPedId(), variation, variationTime)
end

function cAPI.VaryPlayerStamina(variation, variationTime)
    cAPI.VaryPedStamina(PlayerPedId(), variation, variationTime)
end

function cAPI.VaryPlayerCore(core, variation, variationTime, goldenEffect)
    cAPI.VaryPedCore(PlayerPedId(), core, variation, variationTime, goldenEffect)
end

function cAPI.VaryHorseHealth(variation, variationTime)
    if cAPI.IsPlayerHorseActive() then
        cAPI.VaryPedHealth(cAPI.GetPlayerHorse(), variation, variationTime)
    end
end

function cAPI.VaryHorseStamina(variation, variationTime)
    if cAPI.IsPlayerHorseActive() then
        cAPI.VaryPedHealth(cAPI.GetPlayerHorse(), variation, variationTime)
    end
end

function cAPI.VaryHorseCore(core, variation, variationTime, goldenEffect)
    if cAPI.IsPlayerHorseActive() then
        cAPI.VaryPedCore(cAPI.GetPlayerHorse(), core, variation, variationTime, goldenEffect)
    end
end

local playerHorse = 0
local isHorseActivationBlocked = false
local horseActivationSeconds
local isHorseInWrithe = false

function cAPI.SetPlayerHorse(horse)
    playerHorse = horse
end

function cAPI.GetPlayerHorse()
    return playerHorse
end

function cAPI.IsPlayerHorseActive()
    return playerHorse ~= 0
end

function cAPI.IsPlayerHorseActivationBlocked()
    return isHorseActivationBlocked
end

function cAPI.DestroyPlayerHorse()
    if cAPI.GetPlayerHorse() ~= 0 then
        DeleteEntity(cAPI.GetPlayerHorse())
        cAPI.SetPlayerHorse(0)
    end
    isHorseActivationBlocked = false
    horseActivationSeconds = nil
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            if cAPI.IsPlayerHorseActive() then
                if not isHorseActivationBlocked then
                    if IsPedInjured(playerHorse) then
                        cAPI.notify("error", "Seu cavalo foi ferido, você não poderá chama-lo nos proximos 2 minutos")
                        isHorseActivationBlocked = true
                        horseActivationSeconds = 120
                    end

                    if PromptHasHoldModeCompleted(prompt_inventory) then
                        PromptSetEnabled(prompt_inventory, false)
                        Citizen.CreateThread(
                            function()
                                Citizen.Wait(250)
                                PromptSetEnabled(prompt_inventory, true)
                            end
                        )

                        TriggerServerEvent("FRP:HORSE:OpenInventory")
                    end

                    -- Flee
                    if IsControlJustPressed(0, 0x4216AF06) then -- F
                        TaskAnimalFlee(playerHorse, PlayerPedId(), -1)
                        Citizen.CreateThread(
                            function()
                                Citizen.Wait(10000)
                                cAPI.DestroyPlayerHorse()
                            end
                        )
                    end
                else
                    if not IsPedInjured(playerHorse) then
                        isHorseActivationBlocked = false
                        horseActivationSeconds = nil
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            if playerHorse ~= 0 and not DoesEntityExist(playerHorse) then -- and DoesEntityExist(playerHorse) then
                cAPI.DestroyPlayerHorse()
            end

            if isHorseActivationBlocked then
                horseActivationSeconds = horseActivationSeconds - 1
                if horseActivationSeconds <= 0 then
                    cAPI.DestroyPlayerHorse()
                end
            end

            if isHorseInWrithe then
                if not IsPedInWrithe(playerHorse) then
                    isHorseInWrithe = false
                end
            else
                if IsPedInWrithe(playerHorse) then
                    cAPI.notify("alert", "Seu cavalo foi ferido, reanime-o")
                    isHorseInWrithe = true
                else
                    if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(playerHorse)) > 500.0 then
                        cAPI.DestroyPlayerHorse()
                    end
                end
            end
        end
    end
)

local role = 0

RegisterNetEvent("FRP:EVENTS:CharacterSetRole")
AddEventHandler(
    "FRP:EVENTS:CharacterSetRole",
    function(_role)
        role = _role
    end
)

RegisterNetEvent("FRP:EVENTS:CharacterJoinedGroup")
AddEventHandler(
    "FRP:EVENTS:CharacterJoinedGroup",
    function(group)
        if not cAPI.hasGroup(group) then
            local bit = config_file_GROUPS[group:lower()]

            if bit ~= nil then
                role = role | bit
            end
        end
    end
)

local myOrgs = {}

function cAPI.getMyOrg()
    return myOrgs
end

function cAPI.setMyOrg(orgs)
    print(orgs)
    myOrgs = json.decode(orgs)
end

RegisterNetEvent("FRP:EVENTS:CharacterLeftGroup")
AddEventHandler(
    "FRP:EVENTS:CharacterLeftGroup",
    function(group)
        if cAPI.hasGroup(group) then
            local bit = config_file_GROUPS[group:lower()]

            if bit ~= nil then
                role = role & (~bit)
            end
        end
    end
)

function cAPI.hasGroup(group)
    local bit = config_file_GROUPS[group:lower()]

    if bit ~= nil then
        return (role & bit) ~= 0
    end

    return false
end

function cAPI.hasGroupOrInheritance(group)
    if cAPI.hasGroup(group) then
        return true
    else
        for superGroup, childrenGroup in pairs(config_file_INHERITANCE) do
            if childrenGroup == group then
                if cAPI.hasGroup(superGroup) then
                    return true
                end
            end
        end
    end

    return false
end

local isWanted = false
local wantedEndTimestamp = 0

function cAPI.AddWantedTime(wanted, time)
    if wanted then
        local add = 1000 * 60 * time

        if wantedEndTimestamp >= GetGameTimer() then
            wantedEndTimestamp = wantedEndTimestamp + add
        else
            wantedEndTimestamp = GetGameTimer() + add
        end
    end

    if wanted ~= isWanted then
        TriggerServerEvent("FRP:WANTED:MarkAsWanted", wanted)
    end

    isWanted = wanted
end

function cAPI.IsWanted()
    return isWanted ~= nil and Wanted or false
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            local diff = wantedEndTimestamp - GetGameTimer()

            if diff > 1 then
                if isWanted then
                    DrawText("Você está procurado por " .. string.format("%.0f", math.max(diff / 1000, 0)) .. " segundos", 0.925, 0.96, 0.25, 0.25, false, 255, 255, 255, 145, 1, 7)
                end
            else
                if isWanted then
                    isWanted = false
                end

                Citizen.Wait(1000)
            end
        end
    end
)

function DrawText(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre, font)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    Citizen.InvokeNative(0xADA9255D, font)
    DisplayText(CreateVarString(10, "LITERAL_STRING", str), x, y)
end

local sickness = 0

function cAPI.VarySickness(variation)
    sickness = math.min(100, sickness + variation)
end

function cAPI.OpioUse(variation)
    variationTime = 10
    for i = 0, 1 do
        cAPI.VaryPedCore(PlayerPedId(), i, 100, variationTime, 1)
    end
end

function cAPI.GetSickness()
    return sickness
end

Citizen.CreateThread(
    function()
        local sleep = 1000

        local animDict = "amb_misc@world_human_vomit@male_a@idle_a"
        local animName = "idle_b"

        local isVomiting = false
        local vomitingTime = 10000

        while true do
            sleep = 1000

            if cAPI.GetSickness() > 0 then
                sleep = 100

                sickness = math.max(0, sickness - 0.025)

                if sickness > 50 then
                    local playerPed = PlayerPedId()
                    local v = GetEntityVelocity(playerPed)

                    -- ? 8.3m/s = 30.0km/h

                    if GetMount(playerPed) ~= 0 then
                        if (math.abs(v.x) >= 2.5 or math.abs(v.y) >= 2.5 or math.abs(v.z) >= 2.5) or (sickness >= 95) then
                            if not isVomiting then
                                isVomiting = true

                                Citizen.CreateThread(
                                    function()
                                        Citizen.Wait(vomitingTime)
                                        isVomiting = false
                                    end
                                )
                            end
                        end
                    end

                    if isVomiting then
                        local moveBlendTarget = playerPed
                        local flag = 31

                        if IsPedOnFoot(playerPed) then
                            -- if not IsPedWalking(playerPed) then
                            --     flag = 32
                            -- end
                        else
                            local mount = GetMount(playerPed)

                            if mount ~= 0 then
                                moveBlendTarget = mount
                            end
                        end

                        SetPedMaxMoveBlendRatio(moveBlendTarget, 0.2)

                        if not IsEntityPlayingAnim(playerPed, animDict, animName, 3) and Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, playerPed) == false then
                            if not HasAnimDictLoaded(animDict) then
                                RequestAnimDict(animDict)
                                while not HasAnimDictLoaded(animDict) do
                                    Citizen.Wait(0)
                                end
                            end
                            TaskPlayAnim(playerPed, animDict, animName, 4.0, 4.0, vomitingTime, flag, 0, true, 0, false, 0, false)
                        end
                    end
                end
            end

            Citizen.Wait(sleep)
        end
    end
)

function cAPI.IsPlayerLassoed()
    local isLassoed = Citizen.InvokeNative(0x9682F850056C9ADE, PlayerPedId())

    if isLassoed == false then
        return false
    end

    return true
end
