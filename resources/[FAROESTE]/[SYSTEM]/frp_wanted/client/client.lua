local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

RegisterNetEvent("FRP:WANTED:gunshotInProgress")
AddEventHandler(
    "FRP:WANTED:gunshotInProgress",
    function(targetCoords)
        --   if cAPI.hasGroupOrInheritance('trooper') or cAPI.hasGroupOrInheritance('sheriff') then
        local blip = Citizen.InvokeNative(0x45F13B7E0A15C880, 408396114, targetCoords.x, targetCoords.y, targetCoords.z, 60.0)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Disparo de Tiro")
        Wait(8000)
        RemoveBlip(blip)
        -- end
    end
)


RegisterNetEvent("FRP:WANTED:denuncia")
AddEventHandler(
    "FRP:WANTED:denuncia",
    function(targetCoords)
        local blip = Citizen.InvokeNative(0x45F13B7E0A15C880, 408396114, targetCoords.x, targetCoords.y, targetCoords.z, 60.0)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Denuncia")
        Wait(8000)
        RemoveBlip(blip)
    end
)


local reward2 = 0
local pname = "Nome Desconhecido"
local annon = false
local CityName = "Cidade Fantasma"
local TimeAlert = 0

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local CityName = GetCurrentTownName()
            local retval, hashArma = GetCurrentPedWeapon(PlayerPedId(), 0, 0, 0)
            local arma = Citizen.InvokeNative(0x705BE297EEBDB95D, hashArma)
            local retval, weaponHash = GetCurrentPedWeapon(playerPed, 1)            
            local TimeAlertDiff = TimeAlert - GetGameTimer()
            if IsPedShooting(playerPed) and weaponHash ~= GetHashKey("WEAPON_BOW") then
                if arma then                   
                    if TimeAlertDiff <= 0 then
                    --       local Policia = cAPI.hasGroupOrInheritance('trooper') or cAPI.hasGroupOrInheritance('sheriff')
                        if CityName ~= nil and CityName ~= "Cidade Fantasma" then
                            local ped = PlayerPedId()
                            local currentWeaponHash = GetCurrentPedWeapon(ped)
                            local havesilence = false
                            local playerGender = GetEntityModel(ped)
                            Citizen.Wait(3000)
                            -- DecorSetInt(playerPed, 'isOutlaw', 2)
                            TriggerServerEvent(
                                "FRP:WANTED:gunshotInProgress",
                                {
                                    x = playerCoords.x,
                                    y = playerCoords.y,
                                    z = playerCoords.z
                                },
                                CityName,
                                playerGender
                            )
                        end
                        TimeAlert = GetGameTimer() + 10000
                    end
                end
            end
        end
    end
)

RegisterNetEvent("FRP:WANTED:RewardClient")
AddEventHandler(
    "FRP:WANTED:RewardClient",
    function(arg1, arg2)
        TriggerServerEvent("FRP:WANTED:RewardNotify", arg1, arg2, GetCurrentTownName())
        TriggerServerEvent("FRP:WANTED:RewardSERVER", arg1, arg2, GetCurrentTownName())
    end
)

RegisterNetEvent("FRP:WANTED:RewardNotify")
AddEventHandler(
    "FRP:WANTED:RewardNotify",
    function(reward, playername, city)
        reward2 = reward
        pname = playername
        CityName = city
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        annon = true
        Wait(9000)
        annon = false
    end
)

RegisterNetEvent("FRP:WANTED:GetWanted")
AddEventHandler(
    "FRP:WANTED:GetWanted",
    function(city)
        for key, value in pairs(city) do
            print(key, value)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if annon then
                DrawSprite("menu_textures", "translate_bg_1a", 0.50, 0.10, 0.30, 0.10, 0.8, 0, 0, 0, 250, 1)
                DrawTxt("~e~PROCURADO", 0.50, 0.05, 0.9, 0.9, true, 255, 255, 255, 255, true)
                DrawTxt("Capture ~e~" .. pname .. " ~q~morto ou vivo, recompensa $" .. reward2, 0.50, 0.10, 0.3, 0.3, true, 255, 255, 255, 255, true)
                DrawTxt("E leve para o Sheriff de ~e~" .. CityName, 0.50, 0.12, 0.3, 0.3, true, 255, 255, 255, 255, true)
            end
        end
    end
)

-- RegisterNetEvent("FRP:WANTED:outlawNotify")
-- AddEventHandler(
--     "FRP:WANTED:outlawNotify",
--     function(alert)
--         --  if cAPI.hasGroupOrInheritance('trooper') or cAPI.hasGroupOrInheritance('sheriff') then
--         TriggerEvent("FRP:NOTIFY:Simple", "Sheriff: " .. (alert), 5000)
--         --   end
--     end
-- )

function GetCurrentTownName()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords, 1)

    if town_hash == GetHashKey("Annesburg") then
        return "Annesburg"
    elseif town_hash == GetHashKey("Armadillo") then
        return "Armadillo"
    elseif town_hash == GetHashKey("Blackwater") then
        return "Blackwater"
    elseif town_hash == GetHashKey("BeechersHope") then
        return "BeechersHope"
    elseif town_hash == GetHashKey("Braithwaite") then
        return "Braithwaite"
    elseif town_hash == GetHashKey("Butcher") then
        return "Butcher"
    elseif town_hash == GetHashKey("Caliga") then
        return "Caliga"
    elseif town_hash == GetHashKey("cornwall") then
        return "Cornwall"
    elseif town_hash == GetHashKey("Emerald") then
        return "Emerald"
    elseif town_hash == GetHashKey("lagras") then
        return "lagras"
    elseif town_hash == GetHashKey("Manzanita") then
        return "Manzanita"
    elseif town_hash == GetHashKey("Rhodes") then
        return "Rhodes"
    elseif town_hash == GetHashKey("Siska") then
        return "Siska"
    elseif town_hash == GetHashKey("StDenis") then
        return "Saint Denis"
    elseif town_hash == GetHashKey("Strawberry") then
        return "Strawberry"
    elseif town_hash == GetHashKey("Tumbleweed") then
        return "Tumbleweed"
    elseif town_hash == GetHashKey("valentine") then
        return "Valentine"
    elseif town_hash == GetHashKey("VANHORN") then
        return "Vanhorn"
    elseif town_hash == GetHashKey("Wallace") then
        return "Wallace"
    elseif town_hash == GetHashKey("wapiti") then
        return "Wapiti"
    elseif town_hash == GetHashKey("AguasdulcesFarm") then
        return "Aguasdulces Farm"
    elseif town_hash == GetHashKey("AguasdulcesRuins") then
        return "Aguasdulces Ruins"
    elseif town_hash == GetHashKey("AguasdulcesVilla") then
        return "Aguasdulces Villa"
    elseif town_hash == GetHashKey("Manicato") then
        return "Manicato"
    elseif town_hash == false then
        return "Cidade Fantasma"
    end
end

function GetCurrentStateName()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords, 0)

    -- if town_hash == GetHashKey("GuarmaD") then
    --     return "GuarmaD"
    -- elseif town_hash == GetHashKey("BayouNwa") then
    --     return "BayouNwa"
    -- elseif town_hash == GetHashKey("bigvalley") then
    --     return "bigvalley"
    -- elseif town_hash == GetHashKey("BluewaterMarsh") then
    --     return "BluewaterMarsh"
    -- elseif town_hash == GetHashKey("ChollaSprings") then
    --     return "ChollaSprings"
    -- elseif town_hash == GetHashKey("Cumberland") then
    --     return "Cumberland"
    -- elseif town_hash == GetHashKey("DiezCoronas") then
    --     return "DiezCoronas"
    -- elseif town_hash == GetHashKey("GaptoothRidge") then
    --     return "GaptoothRidge"
    -- elseif town_hash == GetHashKey("greatPlains") then
    --     return "greatPlains"
    -- elseif town_hash == GetHashKey("GrizzliesEast") then
    --     return "GrizzliesEast"
    -- elseif town_hash == GetHashKey("GrizzliesWest") then
    --     return "GrizzliesWest"
    -- elseif town_hash == GetHashKey("HennigansStead") then
    --     return "HennigansStead"
    -- elseif town_hash == GetHashKey("Perdido") then
    --     return "Perdido"
    -- elseif town_hash == GetHashKey("PuntaOrgullo") then
    --     return "PuntaOrgullo"
    -- elseif town_hash == GetHashKey("RioBravo") then
    --     return "RioBravo"
    -- elseif town_hash == GetHashKey("roanoke") then
    --     return "roanoke"
    -- elseif town_hash == GetHashKey("scarlettMeadows") then
    --     return "scarlettMeadows"
    -- elseif town_hash == GetHashKey("TallTrees") then
    --     return "TallTrees"
    -- elseif town_hash == GetHashKey("Heartlands") then
    --     return "Heartlands"
    -- elseif town_hash == false then
    --     return "Cidade Fantasma"
    -- end

    if town_hash == 999150106 then
        return "Ambarino"
    elseif town_hash == -1806461473 then
        return "Lemoyne"
    elseif town_hash == -694461623 then
        return "West Elizabeth"
    elseif town_hash == 1098225713 then
        return "New Austin"
    elseif town_hash == 1093870742 then
        return "New Hanover"
    elseif town_hash == -1828192959 then
        return "Guarma"
    end
end
--=============================================================-- DRAW TEXT SECTION--=============================================================--
function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    --Citizen.InvokeNative(0x66E0276CC5F6B9DA, 2)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    Citizen.InvokeNative(0xADA9255D, 1)
    DisplayText(str, x, y)
end

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end

Citizen.CreateThread(
    function()
        Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 2, 0)
    end
)

local suspects = {}

RegisterNetEvent("FRP:WANTED:UsedEagleEye")
AddEventHandler(
    "FRP:WANTED:UsedEagleEye",
    function()
        cAPI.VarySickness(70)

        Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 2, 100)

        local SUSPECT_SEEM_RADIUS = 2.5

        local seeingAnySuspects = false

        local endTimestamp = GetGameTimer() + (2 * 1000 * 60)

        while endTimestamp > GetGameTimer() do
            Citizen.Wait(0)

            local playerPed = PlayerPedId()
            local playerPedPosition = GetEntityCoords(playerPed)
            local forwardVector = GetEntityForwardVector(playerPed)

            seeingAnySuspects = false

            for _, sServerId in pairs(suspects) do
                -- local sPlayer = GetPlayerFromServerId(sServerId)
                -- local sPed = GetPlayerPed(sPlayer)

                local sPed = sServerId
                if sPed == 0 then
                    suspects[_] = nil
                else
                    sPedPosition = GetEntityCoords(sPed)

                    local distanceToMe = #(sPedPosition - playerPedPosition)

                    local forwardForCompar = playerPedPosition + (distanceToMe * forwardVector)

                    -- print(distanceToMe, forwardForCompar,#(sPedPosition.xy - forwardForCompar.xy))

                    if distanceToMe > 10.0 then
                        if #(sPedPosition.xy - forwardForCompar.xy) <= SUSPECT_SEEM_RADIUS then
                            seeingAnySuspects = true
                        end
                    else
                        suspects[_] = nil
                    end
                end
            end

            if seeingAnySuspects then
                if not Citizen.InvokeNative(0x103C2F885ABEB00B, playerPed, 2) then
                    EnableAttributeOverpower(playerPed, 2, 1)
                end
            else
                DisableAttributeOverpower(playerPed, 2)
            end
        end

        Citizen.InvokeNative(0xC6258F41D86676E0, playerPed, 2, 0)
    end
)

RegisterNetEvent("FRP:WANTED:SyncWantedOrNotPlayer")
AddEventHandler(
    "FRP:WANTED:SyncWantedOrNotPlayer",
    function(src, asWanted)
        if asWanted then
            table.insert(suspects, src)
        else
            for _, s in pairs(suspects) do
                if s == src then
                    src[_] = nil
                    break
                end
            end
        end
    end
)

RegisterNetEvent("FRP:WANTED:SyncWantedPlayers")
AddEventHandler(
    "FRP:WANTED:SyncWantedPlayers",
    function(a)
        for _, src in pairs(a) do
            table.insert(suspects, src)
        end
    end
)
