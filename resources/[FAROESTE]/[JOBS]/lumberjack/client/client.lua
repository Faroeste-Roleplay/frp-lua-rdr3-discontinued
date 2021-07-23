local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

Citizen.CreateThread(
    function()
        local aimMaxDistance = 7

        while true do
            Citizen.Wait(0)

            local ped = PlayerPedId()

            local pedVector = GetEntityCoords(ped)

            local cameraRotation = GetGameplayCamRot()
            local cameraCoord = GetGameplayCamCoord()
            local direction = RotationToDirection(cameraRotation)
            local aimingAtVector = vec3(cameraCoord.x + direction.x * aimMaxDistance, cameraCoord.y + direction.y * aimMaxDistance, cameraCoord.z + direction.z * aimMaxDistance)

            local rayHandle = StartShapeTestRay(pedVector, aimingAtVector, 256, ped, 0)
            local _, hit, endCoords, _, entityHit = GetShapeTestResult(rayHandle)

            local isATree = false

            if hit == 1 then
                aimingAtVector = endCoords
                isATree = drawBox(entityHit)
            end
            
            print(_, hit, endCoords, _, entityHit)

            -- Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,pedVector, aimingAtVector, 255, 0, 0, 255)

            if isATree and IsControlJustPressed(0, 0xDFF812F9) then -- E
                print('pass')
                local scenario = Citizen.InvokeNative(0x94B745CE41DB58A1, GetHashKey("EA_WORLD_HUMAN_TREE_CHOP_NEW"), GetEntityCoords(entityHit) + (GetEntityForwardVector(entityHit) * 1.3), GetEntityHeading(entityHit) + 170, 2.0, -1.0, 1)
                local axe = Citizen.InvokeNative(0x295514F198EFD0CA, scenario, 'PRIMARYITEM')
                -- uParam0->f_101 = TASK::_0x05A0100EA714DB68(Global_34, joaat("PRIMARYITEM"));
                TaskUseScenarioPoint(PlayerPedId(), scenario, "", -1.0, 0, 0, 0, 0, 0)
            end

            -- ForceSonarBlipsThisFrame()
            -- TriggerSonarBlip(348490638, GetEntityCoords(PlayerPedId()))
        end
    end
)

function drawBox(entity)
    local min, max = GetModelDimensions(GetEntityModel(entity))

    local minPos = GetOffsetFromEntityInWorldCoords(entity, min)
    local lowA = GetOffsetFromEntityInWorldCoords(entity, min.x, max.y, min.z)
    local lowB = GetOffsetFromEntityInWorldCoords(entity, max.x, min.y, min.z)
    local lowC = GetOffsetFromEntityInWorldCoords(entity, max.x, max.y, min.z)

    local maxPos = GetOffsetFromEntityInWorldCoords(entity, max)
    local highA = GetOffsetFromEntityInWorldCoords(entity, max.x, min.y, max.z)
    local highB = GetOffsetFromEntityInWorldCoords(entity, min.x, max.y, max.z)
    local highC = GetOffsetFromEntityInWorldCoords(entity, min.x, min.y, max.z)

    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,minPos, lowA, 255, 0, 0, 255)
    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,minPos, lowB, 255, 0, 0, 255)
    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,lowC, lowA, 255, 0, 0, 255)
    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,lowC, lowB, 255, 0, 0, 255)

    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,maxPos, highA, 255, 0, 0, 255)
    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,maxPos, highB, 255, 0, 0, 255)
    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,highC, highA, 255, 0, 0, 255)
    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,highC, highB, 255, 0, 0, 255)

    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,minPos, maxPos, 255, 0, 0, 255)
    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,lowA, highA, 255, 0, 0, 255)
    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,lowB, highB, 255, 0, 0, 255)
    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,lowC, highC, 255, 0, 0, 255)

    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,minPos, highC, 255, 0, 0, 255)
    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,lowA, highB, 255, 0, 0, 255)
    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,lowB, highA, 255, 0, 0, 255)
    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,lowC, maxPos, 255, 0, 0, 255)

    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,GetEntityCoords(entity), GetEntityCoords(entity) + (GetEntityForwardVector(entity) * 1.3), 255, 255, 0, 255)

    -- Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,lowA, lowB, 255, 0, 0, 255)
    -- Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,lowC, minPos, 255, 0, 0, 255)
    -- return max.z > 4.0
    return true
end

function RotationToDirection(rotation)
    local adjustedRotation = {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    local direction = {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }
    return direction
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
        -- for _, prompt in pairs(prompts) do
        --     PromptDelete(prompt)
        -- end
        end
    end
)
