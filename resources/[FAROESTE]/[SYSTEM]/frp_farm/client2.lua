local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local SCOPE_RANGE = 20.0
local SCOPE_REAL_COMPOSITE_RANGE = 10.0
local SCOPE_MAX_ENTITIES = 20

local SCOPE_FAKE_ENTITIES = false

local indexToVector = {}

local pop = {}

local activePop = {}

local STATE_TYPE_TOBACCO = 1 << 0
local STATE_TYPE_BLACK_BERRY = 1 << 1
local STATE_TYPE_MILKWEED = 1 << 2

local STATE_GROWTH_NO_PICKUP = 1 << 3
local STATE_GROWTH_CAN_PICKUP = 1 << 4

pop = {
    STATE_TYPE_TOBACCO | STATE_GROWTH_CAN_PICKUP,
    STATE_TYPE_BLACK_BERRY | STATE_GROWTH_CAN_PICKUP,
    STATE_TYPE_BLACK_BERRY | STATE_GROWTH_CAN_PICKUP,
    STATE_TYPE_BLACK_BERRY | STATE_GROWTH_CAN_PICKUP,
    STATE_TYPE_BLACK_BERRY | STATE_GROWTH_CAN_PICKUP,
    STATE_TYPE_MILKWEED | STATE_GROWTH_CAN_PICKUP,
    STATE_TYPE_MILKWEED | STATE_GROWTH_CAN_PICKUP,
    STATE_TYPE_TOBACCO | STATE_GROWTH_CAN_PICKUP,
    STATE_TYPE_BLACK_BERRY | STATE_GROWTH_CAN_PICKUP,
    STATE_TYPE_BLACK_BERRY | STATE_GROWTH_CAN_PICKUP,
    STATE_TYPE_BLACK_BERRY | STATE_GROWTH_CAN_PICKUP,
    STATE_TYPE_MILKWEED | STATE_GROWTH_CAN_PICKUP,
    STATE_TYPE_MILKWEED | STATE_GROWTH_CAN_PICKUP,
    STATE_TYPE_TOBACCO | STATE_GROWTH_CAN_PICKUP,
    STATE_TYPE_BLACK_BERRY | STATE_GROWTH_CAN_PICKUP,
    STATE_TYPE_BLACK_BERRY | STATE_GROWTH_CAN_PICKUP,
    STATE_TYPE_BLACK_BERRY | STATE_GROWTH_CAN_PICKUP,
    STATE_TYPE_MILKWEED | STATE_GROWTH_CAN_PICKUP
}

Citizen.CreateThread(
    function()
        registerFarmAreas()

        while true do
            Citizen.Wait(0)

            if #indexToVector > 0 then
                ReloadActiveIndices()
            end
        end
    end
)

function ReloadActiveIndices()
    local playerPed = PlayerPedId()

    local pedCoords = GetEntityCoords(PlayerPedId())

    local forwardVector = GetEntityForwardVector(playerPed)

    local scopePosition = pedCoords + (1.5 * forwardVector)

    for index, state_flag in pairs(pop) do
        local position = indexToVector[index]

        local dist = #(scopePosition - position)

        if dist <= SCOPE_RANGE then
            if not activePop[index] then
                if dist <= SCOPE_REAL_COMPOSITE_RANGE then
                    local compositeType

                    compositeType = state_flag & STATE_TYPE_TOBACCO ~= 0 and "COMPOSITE_LOOTABLE_INDIAN_TOBACCO_DEF" or compositeType
                    compositeType = state_flag & STATE_TYPE_BLACK_BERRY ~= 0 and "COMPOSITE_LOOTABLE_BLACK_BERRY_DEF" or compositeType
                    compositeType = state_flag & STATE_TYPE_MILKWEED ~= 0 and "COMPOSITE_LOOTABLE_MILKWEED_DEF" or compositeType

                    local compositeHash = GetHashKey(compositeType)

                    WrapperRequestComposite(compositeHash)

                    local composite = exports["frp_herb_population"]:NativeCreateComposite(compositeHash, position.x, position.y, position.z, true)

                    activePop[index] = composite

                -- print(index, "Real composite created", composite)
                end

                if SCOPE_FAKE_ENTITIES then
                    if dist > SCOPE_REAL_COMPOSITE_RANGE then
                        local propType

                        propType = state_flag & STATE_TYPE_TOBACCO ~= 0 and "s_inv_indtobacco01dx" or propType
                        propType = state_flag & STATE_TYPE_BLACK_BERRY ~= 0 and "s_inv_blackberry01x" or propType
                        propType = state_flag & STATE_TYPE_MILKWEED ~= 0 and "s_inv_milkweed01dx" or propType

                        local propTypeHash = GetHashKey(propType)

                        WrapperRequestModel(propTypeHash)

                        local prop = CreateObject(propTypeHash, position.x, position.y, position.z, false, false, false, false, false)

                        activePop[index] = prop

                    -- print(index, "Fake composite created", prop)
                    end
                end
            else
                if SCOPE_FAKE_ENTITIES then
                    if dist <= SCOPE_REAL_COMPOSITE_RANGE then
                        local composite = activePop[index]

                        if DoesEntityExist(composite) then
                            DeleteObject(composite)

                            activePop[index] = nil

                        -- print("Deleting fake composite to create a real one", index)
                        end
                    end
                end

                if dist > SCOPE_REAL_COMPOSITE_RANGE then
                    local composite = activePop[index]

                    -- print('Outside real scope', index, DoesEntityExist(composite))

                    if not DoesEntityExist(composite) then
                        NativeDeleteComposite(composite)

                        activePop[index] = nil

                    -- print("Deleting real composite to create a fake one", index)
                    end
                end
            end
        end

        if dist > SCOPE_RANGE then
            if activePop[index] then
                local composite = activePop[index]

                NativeDeleteComposite(composite)

                if SCOPE_FAKE_ENTITIES then
                    SetEntityAsMissionEntity(composite, true, true)
                    DeleteObject(composite)
                end

                activePop[index] = nil
            end
        end
    end
end

function computeSpotsBetweenTwoPointsAddToTable(spacing, a, b)
    local d = math.sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y)) / spacing
    local fi = math.atan2(b.y - a.y, b.x - a.x)

    for i = 0, spacing do
        local x = a.x + i * d * math.cos(fi)
        local y = a.y + i * d * math.sin(fi)
        local _, z, _ = GetGroundZAndNormalFor_3dCoord(x, y, a.z)

        table.insert(indexToVector, vec3(x, y, z))
    end
end

function computeSpots()
    indexToVector = {}

    for i = 1, #farmsRows do
        local d = farmsRows[i]

        local spacing = d.numSpots

        for key, v in pairs(d) do
            if key ~= "numSpots" and key ~= "type" then
                local pointA = v[1]
                local pointB = v[2]

                local spots = computeSpotsBetweenTwoPointsAddToTable(spacing, pointA, pointB)
            end
        end
    end
end

function NativeDeleteComposite(composite)
    Citizen.InvokeNative(0x5758B1EE0C3FD4AC, composite, 0)
end

function WrapperRequestComposite(compositeHash)
    if not Citizen.InvokeNative(0x5E5D96BE25E9DF68, compositeHash) then
        Citizen.InvokeNative(0x73F0D0327BFA0812, compositeHash)

        while not Citizen.InvokeNative(0x5E5D96BE25E9DF68, compositeHash) do
            Citizen.Wait(0)
        end
    end
end

function WrapperRequestModel(propTypeHash)
    if not HasModelLoaded(propTypeHash) then
        if IsModelValid(propTypeHash) then
            RequestModel(propTypeHash)
            while not HasModelLoaded(propTypeHash) do
                Citizen.Wait(0)
            end
        end
    end
end

function DestroyAllActivePop()
    for _, composite in pairs(activePop) do
        NativeDeleteComposite(composite)

        if SCOPE_FAKE_ENTITIES then
            SetEntityAsMissionEntity(composite, true, true)
            DeleteObject(composite)
        end
    end

    activePop = {}
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            local pedCoords = GetEntityCoords(PlayerPedId())

            for index, composite in pairs(activePop) do
                local position = indexToVector[index]

                local state_flag = pop[index]

                -- print(state_flag & STATE_GROWTH_NO_PICKUP)
                if not SCOPE_FAKE_ENTITIES or not DoesEntityExist(composite) then
                    if state_flag & STATE_GROWTH_NO_PICKUP ~= 0 then
                        Citizen.InvokeNative(0x082C043C7AFC3747, composite, true)
                        Citizen.InvokeNative(0x40D72189F46D2E15, composite, true)
                    elseif state_flag & STATE_GROWTH_CAN_PICKUP ~= 0 then
                        Citizen.InvokeNative(0x40D72189F46D2E15, composite, true)
                    end
                end

                -- Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, position, position + vec3(0, 0, 0.7), 122, 230, 122, 255)
                -- Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, pedCoords, position + vec3(0, 0, 0.7), 122, 230, 122, 50)
            end
        end
    end
)

RegisterNetEvent("FRP:FARM:SetIndex")
AddEventHandler(
    "FRP:FARM:SetIndex",
    function(index, state_flag)
        if state_flag == 0 then
            pop[index] = nil
        else
            pop[index] = state_flag
        end

        ReloadActiveIndices()
    end
)

RegisterNetEvent("FRP:FARM:SetPop")
AddEventHandler(
    "FRP:FARM:SetPop",
    function(a)
        pop = a

        for index, state_flag in pairs(a) do
            if state_flag == 0 then
                pop[index] = nil
            end
        end

        ReloadActiveIndices()
    end
)

AddEventHandler(
    "FRP:AREA:PlayerEnteredArea",
    function(areaId)
        if areaId == "tobacco" or areaId == "corn" or areaId == "sugarcane" then
            computeSpots()
        end
    end
)

AddEventHandler(
    "FRP:AREA:PlayerLeftArea",
    function(areaId)
        if areaId == "tobacco" or areaId == "corn" or areaId == "sugarcane" then
            indexToVector = {}
            DestroyAllActivePop()
        end
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            DestroyAllActivePop()
        end
    end
)

function registerFarmAreas()
    local tobbaco =
        cAPI.RegisterArea(
        "tobacco",
        {
            height = 4.0,
            color = {255, 0, 0, 60},
            -- threshold = 3.25,
            vec3(1226.5939941406, -1946.9085693359, 53.168365478516),
            vec3(1169.5446777344, -1945.1711425781, 47.385631561279),
            vec3(1165.0754394531, -1853.7674560547, 47.359714508057),
            vec3(1227.9428710938, -1851.642578125, 53.084655761719)
        }
    )

    local corn =
        cAPI.RegisterArea(
        "corn",
        {
            height = 3.5,
            color = {255, 0, 0, 60},
            vec3(933.54016113281, -2022.3217773438, 43.973258972168),
            vec3(1005.2134399414, -2008.4283447266, 46.51021194458),
            vec3(1017.6409912109, -1870.9841308594, 43.688522338867),
            vec3(939.23114013672, -1859.7126464844, 44.988395690918)
        }
    )

    local sugarcane =
        cAPI.RegisterArea(
        "sugarcane",
        {
            height = 3.5,
            color = {255, 0, 0, 60},
            vec3(1126.8572998047, -1475.6580810547, 52.427513122559),
            vec3(1007.4481201172, -1478.3896484375, 47.936859130859),
            vec3(1012.4561767578, -1556.0417480469, 46.178905487061),
            vec3(1133.5802001953, -1543.4616699219, 50.969917297363)
        }
    )
end
