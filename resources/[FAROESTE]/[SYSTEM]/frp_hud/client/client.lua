local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

opened = false
local Cinematic = false
local temperature = GetTemperatureAtCoords(GetEntityCoords(PlayerPedId(), true))

RegisterCommand(
    "horsecl",
    function()
        local playerHorse = cAPI.GetPlayerHorse()
        -- playerHorse = 228907
        local p = PlayerId()

        Citizen.InvokeNative(0xD2CB0FB0FDCB473D, p, 0)

        local z = Citizen.InvokeNative(0x8FBF9EDB378CCB8C, p, playerHorse)
        local w = Citizen.InvokeNative(0x227B06324234FB09, p, playerHorse)

        local main_horse = Citizen.InvokeNative(0x46FA0AE18F4C7FA9, p)
        local temp_horse = Citizen.InvokeNative(0xD3F7445CEA2E5035, p)
        Citizen.InvokeNative(0x75415EE0CB583760, playerHorse, 7, 950)

        print(cAPI.GetPlayerHorse(), playerHorse, main_horse, temp_horse, DoesEntityExist(playerHorse))
    end
)

Citizen.CreateThread(
    function()
        -- ESCONDER E MOSTRAR ALGUMAS HUDS
        Citizen.InvokeNative(0x4CC5F2FC1332577F, 1058184710) --remove skill cards
        Citizen.InvokeNative(0x4CC5F2FC1332577F, -66088566) --removed money

        N_0x4cc5f2fc1332577f(-2106452847) -- remove wheell itens
        -- N_0x4cc5f2fc1332577f(-1249243147)
        -- N_0x4cc5f2fc1332577f(2011163970)

        -- Citizen.InvokeNative(0x4CC5F2FC1332577F, 0xBB47198C) --disables reticle
        Citizen.InvokeNative(0x8BC7C1F929D07BF3, 0xBB47198C) --enables reticle
        Citizen.InvokeNative(0x8BC7C1F929D07BF3, -2106452847)
        while true do
            Citizen.Wait(0)

            --     Citizen.InvokeNative(0xFFC24B988B938B38, PlayerPedId(), "mood_talking", "FACE_HUMAN@GEN_MALE@BASE")
            if Cinematic then
                N_0x69d65e89ffd72313(true)
            else
                N_0x69d65e89ffd72313(false)
            end

            if IsPedOnMount(PlayerPedId()) then
                N_0x8bc7c1f929d07bf3(474191950)
           --   ShowPlayerCores(false) -- player core
                Citizen.InvokeNative(0x50C803A4CD5932C5, false)
               Citizen.InvokeNative(0xD4EE21B7CC7FD350, false) -- horse core
            else
              -- ShowPlayerCores(false) -- player core
                Citizen.InvokeNative(0x50C803A4CD5932C5, false)

                Citizen.InvokeNative(0xD4EE21B7CC7FD350, false) -- horse core
                N_0x4cc5f2fc1332577f(474191950)
            end

            local _, weaponHash = GetCurrentPedWeapon(PlayerPedId(), 1)
            if weaponHash ~= GetHashKey("WEAPON_UNARMED") then
                DisableControlAction(0, 0xADEAF48C, true) -- MeleeGrappleAttack
            end

            --N_0xbae08f00021bffb2(horse) -- agitates the horse
            -- N_0x8bc7c1f929d07bf3(2106452847) -- show

            --    N_0x50c803a4cd5932c5(false)
            --     N_0xd4ee21b7cc7fd350(false)
            --    Citizen.InvokeNative(0x50C803A4CD5932C5, true)
            --    Citizen.InvokeNative(0xD4EE21B7CC7FD350, true)

            if IsControlJustPressed(0, 0x446258B6) then
                print("press")
                opened = true
                TriggerServerEvent("FRP:HUD:request")
            end

            Citizen.InvokeNative(0x4B8F743A4A6D2FF8, true)
          --  DisplayRadar(true)
         --   DisplayHud(true)
            -- Citizen.InvokeNative(0xC65A45D4453C2627, 704572841, "HUD_PAGE_RADAR", 1, 1, 0, 1)
        end
    end
)

RegisterCommand(
    "cinema",
    function(source, args)
        if args[1] == "1" then
            Cinematic = true
        elseif args[1] == "2" then
            print("foi")
            Cinematic = false
        end
    end
)

local Talking = false

AddEventHandler(
    "SaltyChat_TalkStateChanged",
    function(isTalking)
    Talking = isTalking
    if isTalking then
        Citizen.InvokeNative(0xFFC24B988B938B38, PlayerPedId(), "mood_talking_normal", "FACE_HUMAN@GEN_MALE@BASE")
    else
        Citizen.InvokeNative(0xFFC24B988B938B38, PlayerPedId(), "mood_normal", "FACE_HUMAN@GEN_MALE@BASE")        
    end
end)

-- Citizen.CreateThread(
--     function()
--         while true do
--             Citizen.Wait(0)
--             if Talking then
--                 DrawText('VOZ : Falando',  0.01, 0.01, 0.25, 0.25, false, 252, 240, 192, 145, 0, 7)
--             else
--                 DrawText('VOZ : Normal',  0.01, 0.01, 0.25, 0.25, false, 255, 255, 255, 145, 0, 7)
--             end
--         end
--     end
-- )

RegisterNetEvent("FRP:HUD:RevealMap")
AddEventHandler(
    "FRP:HUD:RevealMap",
    function(toggle)
        if toggle == nil then
            SetMinimapHideFow(false)
        else
            --  RevealMinimapFow(toggle)
            Citizen.InvokeNative(0xEB3CB3386C775D72, 0)
            Citizen.InvokeNative(0x63E7279D04160477, toggle, 0)
            Citizen.InvokeNative(0xF8096DF9B87246E3, toggle)
        end
    end
)

RegisterNetEvent("FRP:HUD:show")
AddEventHandler(
    "FRP:HUD:show",
    function(data)
        SendNUIMessage(
            {
                showhud = true,
                data = data
            }
        )
        Wait(10000)
        TriggerEvent("FRP:HUD:hide")
    end
)

RegisterNetEvent("FRP:HUD:hide")
AddEventHandler(
    "FRP:HUD:hide",
    function()
        opened = false
        SendNUIMessage(
            {
                hidehud = true
            }
        )
    end
)

RegisterCommand(
    "cans",
    function(source, args)
        Citizen.InvokeNative(0xEA47FE3719165B94, PlayerPedId(), "FACE_HUMAN@GEN_MALE@BASE", "mood_talking_happy", 1090519040, -4.0, 5000, 17, 0, 0, 0, 0, 0, 0)
        --  Citizen.InvokeNative(0x726256CC1EEB182F, PlayerPedId())
        --  Citizen.InvokeNative(0xEA47FE3719165B94, PlayerPedId(), "FACE_HUMAN@GEN_MALE@BASE", "mood_talking_happy", 1090519040, -4.0, -1, 17, 0, 0, 0, 0, 0, 0)
    end
)
local NotifyShow
local StateName
local CurrentStateName
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            CurrentStateName = GetCurrentStateName()

            if CurrentStateName ~= StateName then
                NotifyShow = true
                if NotifyShow then
                    local RegionName = GetCurrentRegionName()
                    DrawSprite("menu_textures", "translate_bg_1a", 0.50, 0.08, 0.20, 0.10, 0.8, 0, 0, 0, 250, 1)
                    DrawTxt(RegionName, 0.50, 0.04, 0.6, 0.6, true, 255, 255, 255, 255, true)
                    DrawTxt(CurrentStateName, 0.50, 0.078, 0.3, 0.3, true, 255, 255, 255, 255, true)
                    DrawTxt(GetClockHours() .. ":" .. GetClockMinutes() .. " | " .. string.format("%0.1f", temperature) .. "°C", 0.50, 0.099, 0.28, 0.28, true, 255, 255, 255, 255, true)
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if CurrentStateName ~= StateName then
                StateName = GetCurrentStateName()
                temperature = GetTemperatureAtCoords(GetEntityCoords(PlayerPedId(), true))
                NotifyShow = false
                Citizen.Wait(10000)
            end
        end
    end
)

function GetCurrentStateName()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords, 10)

    if town_hash == GetHashKey("GuarmaD") then
        return "Nuevo Paraiso"
    elseif town_hash == GetHashKey("BayouNwa") then
        return "Lemoyne"
    elseif town_hash == GetHashKey("bigvalley") then
        return "West Elizabeth"
    elseif town_hash == GetHashKey("BluewaterMarsh") then
        return "Lemoyne"
    elseif town_hash == GetHashKey("ChollaSprings") then
        return "New Austin"
    elseif town_hash == GetHashKey("Cumberland") then
        return "Ambarino"
    elseif town_hash == GetHashKey("DiezCoronas") then
        return "Nuevo Paraiso"
    elseif town_hash == GetHashKey("GaptoothRidge") then
        return "New Austin"
    elseif town_hash == GetHashKey("greatPlains") then
        return "West Elizabeth"
    elseif town_hash == GetHashKey("GrizzliesEast") then
        return "Ambarino"
    elseif town_hash == GetHashKey("GrizzliesWest") then
        return "Ambarino"
    elseif town_hash == GetHashKey("HennigansStead") then
        return "New Austin"
    elseif town_hash == GetHashKey("Perdido") then
        return "Nuevo Paraiso"
    elseif town_hash == GetHashKey("PuntaOrgullo") then
        return "Nuevo Paraiso"
    elseif town_hash == GetHashKey("RioBravo") then
        return "New Austin"
    elseif town_hash == GetHashKey("roanoke") then
        return "New Hanover"
    elseif town_hash == GetHashKey("scarlettMeadows") then
        return "Lemoyne"
    elseif town_hash == GetHashKey("TallTrees") then
        return "West Elizabeth"
    elseif town_hash == GetHashKey("Heartlands") then
        return "New Hanover"
    elseif town_hash == false then
        return "Cidade Desconhecida"
    end
end

function GetCurrentRegionName()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords, 10)
    if town_hash == GetHashKey("GuarmaD") then
        return "GuarmaD"
    elseif town_hash == GetHashKey("BayouNwa") then
        return "Bayou Nwa"
    elseif town_hash == GetHashKey("bigvalley") then
        return "Big Valley"
    elseif town_hash == GetHashKey("BluewaterMarsh") then
        return "Bluewater Marsh"
    elseif town_hash == GetHashKey("ChollaSprings") then
        return "Cholla Springs"
    elseif town_hash == GetHashKey("Cumberland") then
        return "Cumberland"
    elseif town_hash == GetHashKey("DiezCoronas") then
        return "Diez Coronas"
    elseif town_hash == GetHashKey("GaptoothRidge") then
        return "Gaptooth Ridge"
    elseif town_hash == GetHashKey("greatPlains") then
        return "Great Plains"
    elseif town_hash == GetHashKey("GrizzliesEast") then
        return "Grizzlies East"
    elseif town_hash == GetHashKey("GrizzliesWest") then
        return "Grizzlies West"
    elseif town_hash == GetHashKey("HennigansStead") then
        return "Hennigans Stead"
    elseif town_hash == GetHashKey("Perdido") then
        return "Perdido"
    elseif town_hash == GetHashKey("PuntaOrgullo") then
        return "Punta Orgullo"
    elseif town_hash == GetHashKey("RioBravo") then
        return "Rio Bravo"
    elseif town_hash == GetHashKey("roanoke") then
        return "Roanoke"
    elseif town_hash == GetHashKey("scarlettMeadows") then
        return "Scarlett Meadows"
    elseif town_hash == GetHashKey("TallTrees") then
        return "Tall Trees"
    elseif town_hash == GetHashKey("Heartlands") then
        return "The Heartlands"
    elseif town_hash == false then
        return "Desconhecido"
    end
end

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


-- local prompt = false
-- local AnimalPrompt

-- function SetupAnimalPrompt()
--     Citizen.CreateThread(function()
--         local str = 'Colocar '
--         AnimalPrompt = PromptRegisterBegin()
--         PromptSetControlAction(AnimalPrompt, 0xE8342FF2)
--         str = CreateVarString(10, 'LITERAL_STRING', str)
--         PromptSetText(AnimalPrompt, str)
--         PromptSetEnabled(AnimalPrompt, false)
--         PromptSetVisible(AnimalPrompt, false)
--         PromptSetHoldMode(AnimalPrompt, true)
--         PromptRegisterEnd(AnimalPrompt)

--     end)
-- end

-- Citizen.CreateThread(function()
-- 	SetupAnimalPrompt()
-- 	while true do
-- 		Wait(100)
-- 		local ped = PlayerPedId()
-- 		coords = GetEntityCoords(ped)
-- 		forwardoffset = GetOffsetFromEntityInWorldCoords(ped,0.0,2.0,0.0)
-- 		local Pos2 = GetEntityCoords(ped)
-- 		local targetPos = GetOffsetFromEntityInWorldCoords(obj3, -0.0, 1.1,-0.1)
-- 		local rayCast = StartShapeTestRay(Pos2.x, Pos2.y, Pos2.z, forwardoffset.x, forwardoffset.y, forwardoffset.z,-1,ped,7)
-- 		local A,hit,C,C,spot = GetShapeTestResult(rayCast)
-- 		local model = GetEntityModel(spot)
-- 		cartcoords = GetEntityCoords(spot)
-- 		if model == model == -1758092337 or model == -1347283941 then --1347283941 : cart03 --1758092337 : WAGON05X
-- 			local animal = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped)
-- 			if animal ~= false then
-- 				if prompt == false then
-- 					PromptSetEnabled(AnimalPrompt, true)
-- 					PromptSetVisible(AnimalPrompt, true)
-- 					prompt = true
-- 				end
-- 				if PromptHasHoldModeCompleted(AnimalPrompt) then
-- 					PromptSetEnabled(AnimalPrompt, false)
-- 					PromptSetVisible(AnimalPrompt, false)
-- 					prompt = false
-- 					animalcheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped)
-- 					pedid = NetworkGetNetworkIdFromEntity(animalcheck)
-- 					Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), animalcheck, GetEntityCoords(PlayerPedId()), 10.0, true)
-- 					DoScreenFadeOut(1800)
-- 					Wait(2000)
-- 					TriggerServerEvent('EveryoneTeleportEntity',pedid,cartcoords.x,cartcoords.y,cartcoords.z+1.5)
-- 					SetEntityCoords(animalcheck,cartcoords.x,cartcoords.y,cartcoords.z+1.5,false)
-- 					DoScreenFadeIn(3000)
-- 					Wait(2000)
-- 				end

-- 				forwardoffset = GetOffsetFromEntityInWorldCoords(ped,0.0,2.0,0.0)
-- 				local Pos2 = GetOffsetFromEntityInWorldCoords(ped, -0.0, 0.0,0.5)
-- 				local targetPos = GetOffsetFromEntityInWorldCoords(obj3, -0.0, 1.1,-0.1)
-- 				local rayCast = StartShapeTestRay(Pos2.x, Pos2.y, Pos2.z, forwardoffset.x, forwardoffset.y, forwardoffset.z,-1,ped,7)
-- 				A,hit,B,C,spot = GetShapeTestResult(rayCast)
-- 				NetworkRequestControlOfEntity(animalcheck)
-- 				model = GetEntityModel(spot)
-- 			else
-- 				PromptSetEnabled(AnimalPrompt, false)
-- 				PromptSetVisible(AnimalPrompt, false)
-- 				prompt = false
-- 			end
-- 		else
-- 			PromptSetEnabled(AnimalPrompt, false)
-- 			PromptSetVisible(AnimalPrompt, false)
-- 			prompt = false
-- 		end
-- 	end
-- end)

RegisterNetEvent("EveryoneTeleportEntity")
AddEventHandler(
    "EveryoneTeleportEntity",
    function(netid, x, y, z)
        ent = NetworkGetEntityFromNetworkId(netid)
        Wait(150)
        SetEntityCoords(ent, x, y, z)
    end
)
