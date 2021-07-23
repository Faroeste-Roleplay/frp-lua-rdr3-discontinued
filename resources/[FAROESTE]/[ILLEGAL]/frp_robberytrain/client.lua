
local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

trainHash = -2006657222
CURRENT_TRAIN = nil
train = nil

--     -1464742217, trem 3 pass
--     -577630801, TREM CARCA E PASS 1 
--     -1901305252, -- TREM CARGAS VAZIA
--     519580241, -- TREM DE CARGA
--     -1083616881, -- train metade transporte / carga
--     1030903581,  -- train metade transporte / carga
--     -2006657222, -- trem grande metade carga / metade pass
--     1285344034, -- TREM 6 PASS
--     987516329, -- somente passageiro
--     -651487570, -- 2 carga 2 pass
--     -593637311, -- 2 pass pequeno

--     1094934838, -- carga e pass grande

--     1054492269, -- trem de duas pessoas
--     1216031719, -- trem de carga usado


-- -64257206 cofre



Citizen.CreateThread(function()
    Wait(500)
    while true do
        Wait(1000)
        local game = NetworkIsGameInProgress()
        if StartRobbery then
            if GetEntitySpeed(CURRENT_TRAIN) == 0 then
                print('tremparou')
            end
        end
    end
end)


Citizen.CreateThread(function()
    Wait(500)
    while true do
        Wait(1000)
        local game = NetworkIsGameInProgress()
        if game == 1 then
            TriggerServerEvent('train:playerActivated')
            return
        end
    end
end)


RegisterNetEvent('FRP:Trainroute')
AddEventHandler('FRP:Trainroute', function(n)
    DeleteAllTrains()
    SetRandomTrains(false)

    local trainWagons = N_0x635423d55ca84fc8(trainHash)
    for wagonIndex = 0, trainWagons - 1 do
        local trainWagonModel = N_0x8df5f6a19f99f0d5(trainHash, wagonIndex)
        while not HasModelLoaded(trainWagonModel) do
            Citizen.InvokeNative(0xFA28FE3A6246FC30,trainWagonModel,1)
            Citizen.Wait(100)
        end
    end

    --spawn--
    local ped = PlayerPedId()
    local train = N_0xc239dbd9a57d2a71(trainHash, -5235.03515625,-3480.6264648438,-21.132341384888, 0, 1, 1, 1)
    local coords = GetEntityCoords(train)
    local trainV = vector3(coords.x, coords.y, coords.z)
  --  Citizen.InvokeNative(0xBA8818212633500A, train, 0, 1) -- this makes the train undrivable for players         
    --blip--
    local blipname = "Trem Roubavel"
    local bliphash = -399496385
    local blip = Citizen.InvokeNative(0x23f74c2fda6e7c61, bliphash, train) -- BLIPADDFORENTITY
    SetBlipScale(blip, 1.5)
    trainspawned = true
    CURRENT_TRAIN = train
 --   SetMissionTrainCoords(CURRENT_TRAIN, -5236.0234375,-3490.9416503906,-21.104068756104 )

    local cruisespeed = 0.0
    SetTrainCruiseSpeed(CURRENT_TRAIN, cruisespeed)

    Citizen.InvokeNative(0xE6C5E2125EB210C1 , -988268728, 0 ,1)
    Citizen.InvokeNative(0x3ABFA128F5BF5A70 , -988268728, 0 ,1)
    
    Citizen.InvokeNative(0xE6C5E2125EB210C1 , -988268728, 1 ,1)
    Citizen.InvokeNative(0x3ABFA128F5BF5A70 , -988268728, 1 ,1)

    Citizen.InvokeNative(0xE6C5E2125EB210C1 , -1467515357, 0,1)
    Citizen.InvokeNative(0x3ABFA128F5BF5A70 , -1467515357, 0,1)

    Wait(600000)

    local cruisespeed = 90.0
    SetTrainCruiseSpeed(CURRENT_TRAIN, cruisespeed)

    Citizen.InvokeNative(0xF8F7DA13CFBD4532, CURRENT_TRAIN, 0)

end)



Citizen.CreateThread(function()
    while true do        
    Citizen.Wait(1)
        local Ped = PlayerPedId()
        local Entity, farCoordsX, farCoordsY, farCoordsZ = cAPI.Target(6.0, Ped)
        local EntityType = GetEntityType(Entity)



            if TrainIdPlayerIsIn ~= 0 then
                TrainIndexPlayerIsIn = CURRENT_TRAIN
        
            else
                TrainIndexPlayerIsIn = nil
    
            end
        end
    end
)



function explosion(player)
    local coords = GetEntityCoords(player)
    AddExplosion(coords.x, coords.y, coords.z, 25, 1, 1, 1, 10)
    AddExplosionWithUserVfx(coords.x, coords.y, coords.z, 26, GetHashKey('EXP_VFXTAG_TRN4_DYNAMITE'), 1, true, false, 1)
end

RegisterNetEvent('TRAIN:create')
AddEventHandler('TRAIN:create', function()
	TriggerEvent('Distress', 'sucesso', 'Um trem carregado de materias está no mapa.')	
end)

-- RegisterCommand('deletartrain', function()
--     DeleteEntity(CURRENT_TRAIN)
-- end)

-- RegisterCommand('change', function(source,args)
--     Citizen.InvokeNative(0xCB9401F918CB0F75 , PlayerPedId(), "Crafting_SatchelUpgrade", 1, -1);    
-- end)

-- RegisterCommand('int', function(source,args)
--     --TaskItemInteraction(PlayerPedId(), -569063887, GetHashKey('PROVISION_OLD_BRASS_COMPASS'), 1, 1, -1082130432)

--     SetAnimSceneEntity(PlayerPedId(), "s_moneysackbig01x", N_0x4d0d2e3d8bc000eb(PlayerPedId(), "p_cs_sackCorn01x_PH_R_HAND", 0), 0)

--     N_0x4d0d2e3d8bc000eb(PlayerPedId(), "p_bottleBeer01x_PH_R_HAND", 1)
--     TaskItemInteraction(PlayerPedId(), -24362764, GetHashKey("p_bottlebeer01x_ph_r_hand"), 1587785400, 1, 0, -1082130432)
--     print( GetHashKey('PROVISION_OLD_BRASS_COMPASS'))
-- end)

local SwitchTrack = {
    -1739625337,    -- 13
    -1748581154,   -- 2
    -1716490906,    
    -2069622439,
    1751550675,
    1499637393,
    -1240153854,
    1229981728,
    -705539859,
    -1242669618,
    1039216354,
    -1467515357,
    -988268728,
    760570040,
}   


-- local SwitchTrack = {
--     -705539859,
--     1499637393,
--     -760570040,
--     -988268728,   -- onde eu quero
--     -1467515357, -- 2 
-- }   

-- Citizen.CreateThread(function()
--     while true do
--         Wait(3000)
--         for _, trackHash in pairs(SwitchTrack) do
--             print('Doing track' .. trackHash)
--              for i = 0, 13 do
--                 Citizen.InvokeNative(0xE6C5E2125EB210C1, trackHash, i ,1 )
--                 Citizen.InvokeNative(0x3ABFA128F5BF5A70, trackHash, i ,1 )
--                 print(i)
--                 Citizen.Wait(10)
--              end
--             Citizen.Wait(50)
--          end
--     end
-- end)

-- RegisterCommand('switch', function(source,args)
--     local state = tonumber(args[1])
--     Citizen.InvokeNative(0xE6C5E2125EB210C1 , -988268728, 1 ,1)
--     Citizen.InvokeNative(0x3ABFA128F5BF5A70 , -988268728, 1 ,1)

--     Citizen.InvokeNative(0xE6C5E2125EB210C1 , -1467515357, 1 ,1)
--     Citizen.InvokeNative(0x3ABFA128F5BF5A70 , -1467515357, 1 ,1)
-- end)

local seguranca = GetHashKey("S_M_M_UniTrainGuards_01")


RegisterNetEvent('TRAIN:createPedDefender')
AddEventHandler('TRAIN:createPedDefender', function()

    print('vapo')

    print(-1947.3331298828,-2605.48828125,68.722503662109)
   -- carrosinfo(carros_spw)
    --setupModelo(seguranca)
    local seguranca_spw = CreatePed(seguranca, -1947.3331298828,-2605.48828125,68.722503662109, 4, 1, 0)
    local seguranca_spw_2 = CreatePed(seguranca, -1947.3331298828,-2605.48828125,68.722503662109, 4,  1, 0)
    local seguranca_spw_3 = CreatePed(seguranca, -1947.3331298828,-2605.48828125,68.722503662109, 4,  1, 0)
    local seguranca_spw_4 = CreatePed(seguranca, -1947.3331298828,-2605.48828125,68.722503662109, 4,  1, 0)
    local seguranca_spw_5 = CreatePed(seguranca, -1947.3331298828,-2605.48828125,68.722503662109, 4,  1, 0)
    local seguranca_spw_6 = CreatePed(seguranca, -1947.3331298828,-2605.48828125,68.722503662109, 4,  1, 0)
    local seguranca_spw_7 = CreatePed(seguranca, -1947.3331298828,-2605.48828125,68.722503662109, 4,  1, 0)
    local seguranca_spw_8 = CreatePed(seguranca, -1947.3331298828,-2605.48828125,68.722503662109, 4,  1, 0)
    local seguranca_spw_9 = CreatePed(seguranca, -1947.3331298828,-2605.48828125,68.722503662109, 4,   1, 0)
    local seguranca_spw_10 = CreatePed(seguranca, -1947.3331298828,-2605.48828125,68.722503662109, 4,  1, 0)
    SetEntityAsMissionEntity(seguranca_spw, 0, 0) 
    SetEntityAsMissionEntity(seguranca_spw_2, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_3, 0, 0) 
    SetEntityAsMissionEntity(seguranca_spw_4, 0, 0) 
    SetEntityAsMissionEntity(seguranca_spw_5, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_6, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_7, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_8, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_9, 0, 0)
    SetEntityAsMissionEntity(seguranca_spw_10, 0, 0) 
    guardasinfo(seguranca_spw)
    guardasinfo(seguranca_spw_2)
    guardasinfo(seguranca_spw_3)
    guardasinfo(seguranca_spw_4)
    guardasinfo(seguranca_spw_5)
    guardasinfo(seguranca_spw_6)
    guardasinfo(seguranca_spw_7)
    guardasinfo(seguranca_spw_8)
    guardasinfo(seguranca_spw_9)
    guardasinfo(seguranca_spw_10)
end)


-- RegisterCommand('criarped2', function(source,args)    

--     local pedModel = "S_M_M_UniTrainGuards_01"

--     local pedModelHash = GetHashKey(pedModel)
--     if not IsModelValid(pedModelHash) then
--         print('model is not valid')
--         return
--     end

--     if not HasModelLoaded(pedModelHash) then
--         RequestModel(pedModelHash)
--         while not HasModelLoaded(pedModelHash) do
--             Citizen.Wait(10)
--         end
--     end

--     local ped = CreatePed(pedModelHash, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), 1, 0)
--     Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
--     Citizen.InvokeNative(0x58A850EAEE20FAA3, ped)

--     ClearPedTasks(ped)
--     ClearPedSecondaryTask(ped)
--     ClearPedTasksImmediately(ped)
--     SetPedFleeAttributes(ped, 0,0)
--     TaskWanderStandard(ped, 1, 0)
--     TaskSetBlockingOfNonTemporaryEvents(ped, 1)
--     SetEntityAsMissionEntity(ped)

--     guardasinfo(ped)
        
--     N_0x841475ac96e794d1(0)
--     TaskRideTrain(CURRENT_TRAIN, seguranca_spw, 0, 0);

-- end)


function setupModelo(modelo)
    RequestModel(modelo)
    while not HasModelLoaded(modelo) do
      RequestModel(modelo)
      Wait(50)
    end
    -- SetModelAsNoLongerNeeded(modelo)
  end

function guardasinfo(inputPed)
    SetPedShootRate(inputPed,  700)
    --AddArmourToPed(inputPed, GetPlayerMaxArmour(seguranca_spw)- GetPedArmour(seguranca_spw))
   -- SetPedAlertness(inputPed, 3)
   	Citizen.InvokeNative(0x283978A15512B2FE, inputPed, true)
	Citizen.InvokeNative(0x58A850EAEE20FAA3, inputPed)
    SetPedAccuracy(inputPed, 81)
    SetEntityHealth(inputPed,  200)
    SetPedFleeAttributes(inputPed, false, true)
    SetPedCombatAttributes(inputPed, 46, true)
    SetPedCombatAttributes(inputPed, 0, true)
    SetPedCombatAttributes(inputPed, 2, true)
    SetPedCombatAttributes(inputPed, 52, true)
    SetPedCombatAbility(inputPed,  2)
    SetPedCombatRange(inputPed, 2)
    SetPedPathAvoidFire(inputPed,  0)
    SetPedPathCanUseLadders(inputPed,1)
    SetPedPathCanDropFromHeight(inputPed, 1)
    SetPedPathPreferToAvoidWater(inputPed, 1)
    --SetPedGeneratesDeadBodyEvents(inputPed, 1)
   -- GiveWeaponToPed(inputPed, GetHashKey("WEAPON_COMBATPISTOL"), 5000, false, true)
    --GiveWeaponToPed(inputPed, GetHashKey("WEAPON_SMG"), 5000, false, true)
    SetPedRelationshipGroupHash(inputPed, GetHashKey("security_guard"))
  end

RegisterNetEvent('TRAIN:killblip')
AddEventHandler('TRAIN:killblip', function()
	RemoveBlip(blip)
end)
