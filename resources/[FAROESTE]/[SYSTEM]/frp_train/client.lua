trainHash = 987516329
CURRENT_TRAIN = nil
train = nil
-- - bondinho

bondHash = -1083616881
CURRENT_BOND = nil
bond = nil


-- -1464742217,
-- ,
-- ,
-- ,
-- 519580241,
--,
-- ,
-- -,
-- ,
-- -,
-- ,
-- -,
-- ,
-- -,
-- -,
-- -,
-- ,
-- ,
-- ,

-- GHOST TRAIN
CURRENT_GHOST_TRAIN = nil
Ghost_train = nil

local stops = {
    {["dst"] = 180.0, ["dst2"] = 4.0, ["x"] = -142.67,  ["y"] = 654.18,   ["z"] = 113.52, ["time"] = 60000, ["name"] = "Valentine Station"},
    {["dst"] = 400.0, ["dst2"] = 4.0, ["x"] = 2685.39,  ["y"] = -1480.33, ["z"] = 45.80,  ["time"] = 60000, ["name"] = "Saint Denis Station"},
    {["dst"] = 220.0, ["dst2"] = 4.0, ["x"] = 1197.48,  ["y"] = -1282.29, ["z"] = 76.45,  ["time"] = 60000, ["name"] = "Rhodes Station"},
    {["dst"] = 220.0, ["dst2"] = 4.0, ["x"] = -379.38,  ["y"] = -369.51,  ["z"] = 86.44,  ["time"] = 30000, ["name"] = "Flatneck Station"},
    {["dst"] = 180.0, ["dst2"] = 4.0, ["x"] = -1118.27, ["y"] = -567.17,  ["z"] = 82.67,  ["time"] = 30000, ["name"] = "Riggs Station"},
    {["dst"] = 180.0, ["dst2"] = 4.0, ["x"] = -1291.04, ["y"] = 440.69,   ["z"] = 94.36,  ["time"] = 30000, ["name"] = "Wallace Station"},
    {["dst"] = 180.0, ["dst2"] = 4.0, ["x"] = 610.54,   ["y"] = 1661.53,  ["z"] = 188.0,  ["time"] = 30000, ["name"] = "Bacchus Station"},
    {["dst"] = 220.0, ["dst2"] = 4.0, ["x"] = 2914.50,  ["y"] = 1238.53,  ["z"] = 44.73,  ["time"] = 60000, ["name"] = "Annesburg Station"},
    {["dst"] = 180.0, ["dst2"] = 4.0, ["x"] = 2879.30,  ["y"] = 592.75,   ["z"] = 57.84,  ["time"] = 60000, ["name"] = "Van Horn Tradin Post"}
} 

local stopsBond = {
    {["dst"] = 180.0, ["dst2"] = 4.0, ["x"] = 2608.637,  ["y"] = -1165.520,   ["z"] = 52.706, ["time"] = 20000, ["name"] = "Saint Dennis 01"},
    {["dst"] = 400.0, ["dst2"] = 4.0, ["x"] = 2608.829,  ["y"] = -1196.003, ["z"] = 53.348,  ["time"] = 20000, ["name"] = "Saint Dennis 01"},
    {["dst"] = 220.0, ["dst2"] = 4.0, ["x"] = 1197.48,  ["y"] = -1282.29, ["z"] = 76.45,  ["time"] = 20000, ["name"] = "Saint Dennis 03"},
    {["dst"] = 220.0, ["dst2"] = 4.0, ["x"] = -379.38,  ["y"] = -369.51,  ["z"] = 86.44,  ["time"] = 30000, ["name"] = "Saint Dennis 04"},
    {["dst"] = 180.0, ["dst2"] = 4.0, ["x"] = -1118.27, ["y"] = -567.17,  ["z"] = 82.67,  ["time"] = 30000, ["name"] = "Saint Dennis 05"},
} 




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

RegisterNetEvent('Trainroute')
AddEventHandler('Trainroute', function(n)
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
    local train = N_0xc239dbd9a57d2a71(trainHash, 48.70, 16.49, 102.56, 0, 1, 1, 1)
    local coords = GetEntityCoords(train)
    local trainV = vector3(coords.x, coords.y, coords.z)
    Citizen.InvokeNative(0xBA8818212633500A, train, 0, 1) -- this makes the train undrivable for players
         
    --blip--
    local blipname = "Trem"
    local bliphash = -399496385
    local blip = Citizen.InvokeNative(0x23f74c2fda6e7c61, bliphash, train) -- BLIPADDFORENTITY
    SetBlipScale(blip, 1.5)
    trainspawned = true
    CURRENT_TRAIN = train
    trainroute()
end)

function trainroute()
    while trainspawned == true do
        for i = 1, #stops do
            local coords = GetEntityCoords(CURRENT_TRAIN)
            local trainV = vector3(coords.x, coords.y, coords.z)
            local distance = #(vector3(stops[i]["x"], stops[i]["y"], stops[i]["z"]) - trainV)
    
            --speed--
            local stopspeed = 0.0
            local cruisespeed = 5.0
            local fullspeed = 15.0
            if distance < stops[i]["dst"] then
                SetTrainCruiseSpeed(CURRENT_TRAIN, cruisespeed)
                Wait(200)
                if distance < stops[i]["dst2"] then
                    SetTrainCruiseSpeed(CURRENT_TRAIN, stopspeed)
                    Wait(stops[i]["time"])
                    SetTrainCruiseSpeed(CURRENT_TRAIN, cruisespeed)
                    Wait(10000)
                end
            elseif distance > stops[i]["dst"] then
                SetTrainCruiseSpeed(CURRENT_TRAIN, fullspeed)
                Wait(25)
            end
        end
    end
end


RegisterNetEvent('FRP:TRAIN:Bondroute')
AddEventHandler('FRP:TRAIN:Bondroute', function(n)
    DeleteAllTrains()
    SetRandomTrains(false) 
    local trainWagons = N_0x635423d55ca84fc8(bondHash)
    for wagonIndex = 0, trainWagons - 1 do
        local trainWagonModel = N_0x8df5f6a19f99f0d5(bondHash, wagonIndex)
        while not HasModelLoaded(trainWagonModel) do
            Citizen.InvokeNative(0xFA28FE3A6246FC30,trainWagonModel,1)
            Citizen.Wait(100)
        end
    end
    --spawn--
    local ped = PlayerPedId()
    local bond = N_0xc239dbd9a57d2a71(bondHash, 2747.645,-1410.556,45.999, 0, 1, 1, 1)
    local coords = GetEntityCoords(bond)
    local trainV = vector3(coords.x, coords.y, coords.z)
   -- Citizen.InvokeNative(0xBA8818212633500A, bond, 0, 0) -- this makes the train undrivable for players
         
    --blip--
    local blipname = "Bondinho"
    local bliphash = -399496385
    local blip = Citizen.InvokeNative(0x23f74c2fda6e7c61, bliphash, train) -- BLIPADDFORENTITY
    SetBlipScale(blip, 1.5)
    trainspawned = true
    CURRENT_BOND = bond
    bondroute()
end)

function bondroute()
    while trainspawned == true do
        for i = 1, #stops do
            local coords = GetEntityCoords(CURRENT_BOND)
            local trainV = vector3(coords.x, coords.y, coords.z)
            local distance = #(vector3(stops[i]["x"], stops[i]["y"], stops[i]["z"]) - trainV)
    
            --speed--
            local stopspeed = 0.0
            local cruisespeed = 2.0
            local fullspeed = 5.0
            if distance < stops[i]["dst"] then
                SetTrainCruiseSpeed(CURRENT_BOND, cruisespeed)
                Wait(200)
                if distance < stops[i]["dst2"] then
                    SetTrainCruiseSpeed(CURRENT_BOND, stopspeed)
                    Wait(stops[i]["time"])
                    SetTrainCruiseSpeed(CURRENT_BOND, cruisespeed)
                    Wait(10000)
                end
            elseif distance > stops[i]["dst"] then
                SetTrainCruiseSpeed(CURRENT_BOND, fullspeed)
                Wait(25)
            end
        end
    end
end

RegisterCommand('deletartrain', function()
    DeleteEntity(CURRENT_BOND)
end)

-- Citizen.CreateThread(function()
--     Wait(500)
--     while true do
--         Wait(8000)
--         if GetClockHours() == 0 then
--             if GetClockMinutes() >= 1 and GetClockMinutes() <= 3 then
--                 if Ghost_train == nil then
--                     TriggerServerEvent("FRP:GHOSTRAIN:calltrain")                
--                 end
--             end
--         end
--     end
-- end)

-- RegisterNetEvent('FRP:GHOST:Trainroute')
-- AddEventHandler('FRP:GHOST:Trainroute', function(n)

--     local trainWagons = N_0x635423d55ca84fc8(241358608)

--     for wagonIndex = 0, trainWagons - 1 do
--         local trainWagonModel = N_0x8df5f6a19f99f0d5(241358608, wagonIndex)        
--         SetEntityCollision(trainWagonModel, false, false)

--         while not HasModelLoaded(trainWagonModel) do
--             Citizen.InvokeNative(0xFA28FE3A6246FC30, trainWagonModel, 1)
--             SetEntityCollision(trainWagonModel, false, false)
--             Citizen.Wait(100)
--         end
--     end
 
--     --spawn--
--     local ped = PlayerPedId()
--     local Ghost_train = N_0xc239dbd9a57d2a71(241358608, 841.3918, -626.9301, 73.62413, 1, 0, 1, 0) 
--     local coords = GetEntityCoords(Ghost_train)
--     local trainV = vector3(coords.x, coords.y, coords.z)
--     Citizen.InvokeNative(0xBA8818212633500A, Ghost_train, 0, 1) -- this makes the train undrivable for players         

--     CURRENT_GHOST_TRAIN = Ghost_train

--     SetMissionTrainCoords(CURRENT_GHOST_TRAIN, 841.3918, -626.9301, 73.62413 )


--     SetTrainSpeed(CURRENT_GHOST_TRAIN, 1.0)
--     SetTrainCruiseSpeed(CURRENT_GHOST_TRAIN, 12.0)

--     Citizen.InvokeNative(0xF66F820909453B8C, CURRENT_GHOST_TRAIN, false, false)
--     SetEntityCollision(trainWagons, false, false)
--     -- --SetEntityAlpha(train, 0, true)
--     N_0xba8818212633500a(CURRENT_GHOST_TRAIN,  4, 1)

--     N_0xba8818212633500a(CURRENT_GHOST_TRAIN, 4, 1)
--     N_0xba8818212633500a(CURRENT_GHOST_TRAIN, 5, 1)
--     N_0xba8818212633500a(CURRENT_GHOST_TRAIN, 6, 1)
--      Wait(15000)
--      DeleteEntity(CURRENT_GHOST_TRAIN)

-- end)