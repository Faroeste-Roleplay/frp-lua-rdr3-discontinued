local minerblips = {
    -- {["CaveName"] = "Annesburg Coal Mine", x = 2752.87, y = 1364.09, z = 67.91, ["HasRares"] = false},
    -- {["CaveName"] = "Hidden WaterFall Cave", x = 2293.26, y = 1070.23, z = 81.43, ["HasRares"] = true}
    {x = 3347.256, y = -673.969, z = 46.132 },
    {x = 3339.151, y = -677.319, z = 45.577 }, 
    {x = 3339.489, y = -689.093, z = 44.035},    
    {x = 3357.520, y = -706.880, z = 45.095},
    {x = 3369.601, y = -715.581, z = 45.013},
    {x = 3357.934, y = -690.311, z = 43.995},
    {x = 3325.680, y = -674.845, z = 45.564},
}


local spawnedRocks = 0
local Rocks = {}
local InArea = false
local entity
local HasRareGems = false

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(5000)
            local ped = Ped()
            local pos = GetEntityCoords(ped)
            for k, v in pairs(minerblips) do
                if GetDistanceZTrue(pos, v) < 80.0 then
                    print('s')
                    InArea = true
                    SpawnRocks()
                    HasRareGems = v.HasRares
                end
            end
        end
    end
)

----check distance for both caves, if both false dont run thread & delete objects (Saves performance???), prolly a better way todo this but fuck it
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(10000)
            local ped = Ped()
            local pos = GetEntityCoords(ped)
            if InArea then
                local Prisao = {x = 3349.018, y = -689.026, z = 43.884}
                if GetDistanceZTrue(pos, Prisao) > 100.0 then
                    InArea = false
                    for k, v in pairs(Rocks) do
                        DeleteObject(v)
                    end
                    spawnedRocks = 0
                end
            end
        end
    end
)

---check distance from spawned rock
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(5)
            if InArea then
                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)
                local nearbyObject, nearbyID
                for i = 1, #Rocks, 1 do
                    local EntCoords = GetEntityCoords(Rocks[i])
                    if GetDistanceZTrue(pos, EntCoords) < 3 then
                        nearbyObject, nearbyID = Rocks[i], i
                        if nearbyObject then
                            DrawText3D(EntCoords.x, EntCoords.y, EntCoords.z, "Pressione E para mineirar")
                            if whenKeyJustPressed("E") then
                                local W = math.random(8000, 15000)
                                MineAndAttach()
                                Wait(100)
                                FreezeEntityPosition(ped, true)
                                Wait(W)
                                FreezeEntityPosition(ped, false)
                                DeleteObject(entity)
                                ClearPedTasks(ped)
                                SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
                                DeleteObject(nearbyObject)
                                table.remove(Rocks, nearbyID)
                                spawnedRocks = spawnedRocks - 1    
                     
                            end
                        end
                    end
                end
            end
        end
    end
)

function SpawnRocks()
    while spawnedRocks < 20 do
        local RockCoords = GenerateRockCoords()
            print(RockCoords)
        local obj = CreateObject(GetHashKey("BGV_ROCK_SCREE_SIM_02"), RockCoords.x, RockCoords.y, RockCoords.z, false, false, false)
        PlaceObjectOnGroundProperly(obj)
        FreezeEntityPosition(obj, true)
        table.insert(Rocks, obj)
        spawnedRocks = spawnedRocks + 1
    end
end

function GenerateRockCoords()
    while true do
        Citizen.Wait(1)

        local RockCoordX, RockCoordY

        math.randomseed(GetGameTimer())
        local modX = math.random(-10, 10)

        Citizen.Wait(100)

        math.randomseed(GetGameTimer())
        local modY = math.random(-10, 10)
        for k, v in pairs(minerblips) do
            if GetDistance(GetEntityCoords(Ped()), v) < 50.0 then
                RockCoordX = v.x + modX
                RockCoordY = v.y + modY
            end
        end

        if RockCoordX ~= nil then
            local coordZ = GetCoordZ(RockCoordX, RockCoordY)
            local coord = vector3(RockCoordX, RockCoordY, coordZ)

            if ValidateRockCoord(coord) then
                return coord
            end
        end
    end
end

function ValidateRockCoord(rockCoord)
    if spawnedRocks > 0 then
        local validate = true
        local outsideinterior = Citizen.InvokeNative(0xF291396B517E25B2, rockCoord.x, rockCoord.y, rockCoord.z) --ISENTITYOUTSIDE

        for k, v in pairs(Rocks) do
            if GetDistance(rockCoord, GetEntityCoords(v)) < 5 then
                validate = false
            end
            if outsideinterior then
                validate = false
            end
        end

        for k, v in pairs(minerblips) do
            if GetDistance(rockCoord, v) > 50 then
                if not k then
                    validate = false
                end
            end
        end

        return validate
    else
        return true
    end
end

function GetCoordZ(x, y)
    for height = 1, 1000 do
        local foundGround, groundZ = GetGroundZAndNormalFor_3dCoord(x, y, height + 0.0)

        if foundGround then
            return groundZ
        end
    end
end

function MineAndAttach()
    if not IsPedMale(Ped()) then
        local waiting = 0
        local dict = "amb_work@world_human_pickaxe@wall@male_d@base"
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            waiting = waiting + 100
            Citizen.Wait(100)
            if waiting > 5000 then
                TriggerEvent("redemrp_notification:start", "Request Animation is broken, Relog", 4, "warning")
                break
            end
        end

        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_HAND")
        local modelHash = GetHashKey("P_PICKAXE01X")
        LoadModel(modelHash)
        entity = CreateObject(modelHash, coords.x, coords.y, coords.z, true, false, false)
        SetEntityVisible(entity, true)
        SetEntityAlpha(entity, 255, false)
        Citizen.InvokeNative(0x283978A15512B2FE, entity, true)
        SetModelAsNoLongerNeeded(modelHash)
        AttachEntityToEntity(entity, ped, boneIndex, -0.030, -0.300, -0.010, 0.0, 100.0, 68.0, false, false, false, true, 2, true) ---6th rotates axe point
        TaskPlayAnim(ped, dict, "base", 1.0, 8.0, -1, 1, 0, false, false, false)
        fastTimer = fastTimer - 10
        print(fastTimer)      
    else
        TaskStartScenarioInPlace(Ped(), GetHashKey("WORLD_HUMAN_PICKAXE_WALL"), 60000, true, false, false, false)
        fastTimer = fastTimer - 10
        print(fastTimer)      
    end
end

AddEventHandler(
    "onResourceStop",
    function(resource)
        if resource == GetCurrentResourceName() then
            for k, v in pairs(Rocks) do
                DeleteObject(v)
            end
        end
    end
)
