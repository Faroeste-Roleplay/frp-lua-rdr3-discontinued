local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Tunnel.getInterface("API")
cAPI = Proxy.getInterface("API")

local pickupSpots = {
    {vec3(-785.209, -1323.833, 43.884), vec(-796.451, -1319.053, 43.568), 10.0}
}

local deliverySpots = {
    vec3(-796.945, -1270.311, 43.516)
}

local closestPickupSpot
local closestDeliverySpot

local prompt_pickup
local prompt_deliver
local promptGroup_pickup
local promptGroup_deliver
local promptGroupName_pickup = CreateVarString(10, "LITERAL_STRING", "Transporte de Produtos")
local promptGroupName_deliver = CreateVarString(10, "LITERAL_STRING", "Local de Carga")
local promptGroupName_deliver_error = CreateVarString(10, "LITERAL_STRING", "Onde está minha carga?")

local cooldown

Citizen.CreateThread(
    function()
        DecorRegister("job_transport_vehicle_num_cargo", 3)

        while true do
            Citizen.Wait(1000)

            local ped = PlayerPedId()
            local pCoords = GetEntityCoords(ped)

            if cooldown == nil then
                local d
                local lP
                for _, v in pairs(pickupSpots) do
                    local dist = #(pCoords - v[1])
                    if dist <= 10.0 and (d == nil or dist < d) then
                        d = dist
                        lP = _
                    end
                end

                closestPickupSpot = lP

                if closestPickupSpot ~= nil and prompt == nil then
                    InitPrompt()
                end
            else
                cooldown = cooldown - 1

                if cooldown <= 0 then
                    cooldown = nil
                end
            end

            local d
            local lD
            for _, v in pairs(deliverySpots) do
                local dist = #(pCoords - v)
                if dist <= 10.0 and (d == nil or dist < d) then
                    d = dist
                    lD = _
                end
            end

            closestDeliverySpot = lD
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)


            Citizen.InvokeNative(0x9C113883487FD53C, -1943724816, 0)

            if closestPickupSpot ~= nil then
                local ped = PlayerPedId()
                local pCoords = GetEntityCoords(ped)

                local closestPickupSpotCoords = pickupSpots[closestPickupSpot][1]

                if #(pCoords - closestPickupSpotCoords) <= 1.0 then
                    PromptSetActiveGroupThisFrame(promptGroup_pickup, promptGroupName_pickup)
                    if PromptIsJustPressed(prompt_pickup) then
                        local closestPickupSpotVehicleSpawnCoords = pickupSpots[closestPickupSpot][2]
                        local closestPickupSpotVehicleSpawnHeading = pickupSpots[closestPickupSpot][3]

                        local canSpawn = true

                        local itemSet = CreateItemset(true)
                        local size = Citizen.InvokeNative(0x59B57C4B06531E1E, closestPickupSpotCoords, 3.0, itemSet, 2)
                        -- number xPos, number yPox, number zPos, float distance, int itemSet, int entityType

                        if size ~= false and size > 0 then
                            for index = 0, size - 1 do
                                local entity = GetIndexedItemInItemset(index, itemSet)
                                if IsEntityAVehicle(entity) then
                                    print(entity)
                                    canSpawn = false
                                    break
                                end
                            end
                        end

                        if IsItemsetValid(itemSet) then
                            DestroyItemset(itemSet)
                        end

                        if canSpawn then
                            local vehicleModelHash = GetHashKey("wagonWork01x")
                            if not HasModelLoaded(vehicleModelHash) then
                                RequestModel(vehicleModelHash)
                                while not HasModelLoaded(vehicleModelHash) do
                                    Citizen.Wait(10)
                                end
                            end

                            local vehicle = CreateVehicle(GetHashKey("wagonWork01x"), closestPickupSpotVehicleSpawnCoords, closestPickupSpotVehicleSpawnHeading, 1, 1)
                            DecorSetInt(vehicle, "job_transport_vehicle_num_cargo", 1)
                            cAPI.notify("success", "Uma carroça te espera lá fora")

                            print(vehicle)
                        else
                            cooldown = 5
                            cAPI.notify("error", "Já tem uma carroça lá fora")
                        end
                    end
                end
            end

            if closestDeliverySpot ~= nil then
                local ped = PlayerPedId()
                local pCoords = GetEntityCoords(ped)

                local closestDeliverySpotCoords = deliverySpots[closestDeliverySpot]

                local dist = #(pCoords - closestDeliverySpotCoords)
                if dist <= 5.0 then
                    local canDeliver = false
                    local vehPedIsIn = GetVehiclePedIsIn(ped, false)
                    if vehPedIsIn ~= 0 then
                        print(DecorExistOn(vehPedIsIn, "job_transport_vehicle_num_cargo"), DecorGetInt(vehPedIsIn, "job_transport_vehicle_num_cargo"), closestDeliverySpot)
                        if DecorExistOn(vehPedIsIn, "job_transport_vehicle_num_cargo") and DecorGetInt(vehPedIsIn, "job_transport_vehicle_num_cargo") == closestDeliverySpot then
                            canDeliver = true
                        end
                    end

                    if canDeliver then
                        PromptSetEnabled(prompt_deliver, true)
                        PromptSetActiveGroupThisFrame(promptGroup_deliver, promptGroupName_deliver)
                        if PromptIsJustPressed(prompt_deliver) then
                            local lV = DecorGetInt(vehPedIsIn, "job_transport_vehicle_num_cargo")
                            if lV + 1 <= #deliverySpots then
                                -- cAPI.notify("success", "Entregue")
                                DecorSetBool(vehPedIsIn, "job_transport_vehicle_num_cargo", lV + 1)
                                cAPI.notify("speech", "Carga entregue, vá até a proxima loja")
                            else
                                DecorRemove(vehPedIsIn, "job_transport_vehicle_num_cargo")
                                -- SetVehicleBodyHealth(vehPedIsIn, 0.0)
                                cAPI.notify("speech", "Todas as cargas foram entregues")
                            end
                        end
                    else
                        if dist <= 1.5 and DecorExistOn(vehPedIsIn, "job_transpjob_transport_vehicle_num_cargoort_vehicle") and DecorGetInt(vehPedIsIn, "job_transport_vehicle_num_cargo") == closestDeliverySpot then
                            PromptSetEnabled(prompt_deliver, false)
                            PromptSetActiveGroupThisFrame(promptGroup_deliver, promptGroupName_deliver_error)
                        end
                    end
                end
            end
        end
    end
)

function InitPrompt()
    prompt_pickup = PromptRegisterBegin()
    promptGroup_pickup = GetRandomIntInRange(0, 0xffffff)
    PromptSetControlAction(prompt_pickup, 0xDFF812F9)
    PromptSetText(prompt_pickup, CreateVarString(10, "LITERAL_STRING", "Começar Serviço"))
    PromptSetEnabled(prompt_pickup, 1)
    PromptSetVisible(prompt_pickup, 1)
    PromptSetStandardMode(prompt_pickup, 1)
    PromptSetGroup(prompt_pickup, promptGroup_pickup)
    PromptRegisterEnd(prompt_pickup)

    prompt_deliver = PromptRegisterBegin()
    promptGroup_deliver = GetRandomIntInRange(0, 0xffffff)
    PromptSetControlAction(prompt_deliver, 0x7F8D09B8)
    PromptSetText(prompt_deliver, CreateVarString(10, "LITERAL_STRING", "Terminar Serviço"))
    PromptSetEnabled(prompt_deliver, 1)
    PromptSetVisible(prompt_deliver, 1)
    PromptSetStandardMode(prompt_deliver, 1)
    PromptSetGroup(prompt_deliver, promptGroup_deliver)
    PromptRegisterEnd(prompt_deliver)
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            PromptDelete(prompt_pickup)
            PromptDelete(prompt_deliver)
        end
    end
)

-- function DestroyPrompt()

-- local scenario_usable
-- local scenario_usable_type

-- local scenario_active
-- local scenario_active_type
-- local scenario_active_entity

-- local promptGroup
-- local prompt_pickup
-- local prompt_putdown
-- local var_bale = CreateVarString(10, "LITERAL_STRING", "Bloco de Feno")
-- local var_sack = CreateVarString(10, "LITERAL_STRING", "Saco")

-- local scenarios = {
--     -- "WORLD_PLAYER_CHORES_BALE_PICKUP_1",
--     -- "WORLD_PLAYER_CHORES_BALE_PUT_DOWN_1",
--     "WORLD_HUMAN_BALE_PICKUP_1",
--     "WORLD_HUMAN_BALE_PICKUP_1_MALE_A",
--     "WORLD_HUMAN_BALE_PICKUP_2",
--     "WORLD_HUMAN_BALE_PICKUP_2_MALE_A",
--     "WORLD_HUMAN_SUGAR_SACK_PICKUP_1",
--     "WORLD_HUMAN_SUGAR_SACK_PICKUP_2",
--     "WORLD_HUMAN_SUGAR_SACK_PICKUP_COUNTER",
--     "WORLD_HUMAN_SACK_PICKUP_1",
--     "WORLD_HUMAN_SACK_PICKUP_1_MALE_A",
--     "WORLD_HUMAN_SACK_PICKUP_2",
--     "WORLD_HUMAN_SACK_PICKUP_2_MALE_A",
--     "WORLD_HUMAN_SACK_PICKUP_COUNTER",
--     "WORLD_HUMAN_SACK_PICKUP_COUNTER_MALE_A"
--     --
--     -- WORLD_HUMAN_BALE_PUT_DOWN_1
--     -- WORLD_HUMAN_BALE_PUT_DOWN_1_MALE_A
--     -- WORLD_HUMAN_BALE_PUT_DOWN_2
--     -- WORLD_HUMAN_BALE_PUT_DOWN_2_MALE_A
--     --
--     -- WORLD_HUMAN_SACK_PUT_DOWN_1
--     -- WORLD_HUMAN_SACK_PUT_DOWN_1_MALE_A
--     -- WORLD_HUMAN_SACK_PUT_DOWN_2
--     -- WORLD_HUMAN_SACK_PUT_DOWN_2_MALE_A
--     -- WORLD_HUMAN_SACK_PUT_DOWN_COUNTER
--     -- WORLD_HUMAN_SACK_PUT_DOWN_COUNTER_MALE_A
-- }

-- Citizen.CreateThread(
--     function()
--         setupPrompts()

--         while true do
--             Citizen.Wait(1000)

--             local ped = PlayerPedId()
--             local pCoords = GetEntityCoords(ped)

--             if scenario_active == nil then
--                 local lastDist
--                 local foundPickupScenario
--                 for _, scenarioType in pairs(scenarios) do
--                     local s = _FindClosestActiveScenarioPointOfType(pCoords, scenarioType, 1.5)
--                     if s then
--                         local dist = #(pCoords - _GetScenarioPointCoords(s))
--                         if lastDist == nil or dist < lastDist then
--                             foundPickupScenario = s
--                             scenario_usable_type = scenarioType
--                         end
--                     end
--                 end

--                 scenario_usable = foundPickupScenario

--                 if scenario_usable == nil then
--                     scenario_usable_type = nil
--                 end
--             end
--         end
--     end
-- )

-- -- Citizen.CreateThread(
-- --     function()
-- --         local aimMaxDistance = 7.0
-- --         local drawcoords
-- --         while true do
-- --             Citizen.Wait(0)

-- --             -- if drawcoords ~= nil then
-- --             --     Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, GetEntityCoords(PlayerPedId()), drawcoords, 255, 0, 0, 255)
-- --             -- end

-- --             local ped = PlayerPedId()
-- --             local pCoords = GetEntityCoords(ped)

-- --             if scenario_active ~= nil then
-- --                 draw_putdown(scenario_active_type:find("_SACK_"))

-- --                 if IsControlJustPressed(2, 0x7F8D09B8) then
-- --                     local putDownScenario = scenario_active_type

-- --                     if putDownScenario:find("_SACK_") then
-- --                         -- putDownScenario = putDownScenario:gsub('_SUGAR', '')
-- --                         -- putDownScenario = putDownScenario:gsub('PICKUP', 'PUT_DOWN')
-- --                         putDownScenario = "WORLD_HUMAN_SACK_PUT_DOWN_2"
-- --                     elseif putDownScenario:find("_BALE_") then
-- --                         -- putDownScenario = putDownScenario:gsub('PICKUP', 'PUT_DOWN')
-- --                         putDownScenario = "WORLD_HUMAN_BALE_PUT_DOWN_1"
-- --                     end

-- --                     scenario_active = nil

-- --                     local putdown_coords = pCoords + (GetEntityForwardVector(ped) * 1.0)

-- --                     -- local rayHandle = StartShapeTestRay(pCoords, putdown_coords, -1, ped, 0)
-- --                     -- local _, hit, endCoords, _, _ = GetShapeTestResult(rayHandle)

-- --                     -- if hit then
-- --                     --     putdown_coords = endCoords
-- --                     -- end

-- --                     -- local _, groundZ, normal = GetGroundZAndNormalFor_3dCoord(pCoords.x, pCoords.y, pCoords.z)
-- --                     -- local scenario = Citizen.InvokeNative(0x94B745CE41DB58A1, GetHashKey(putDownScenario), putdown_coords, GetEntityHeading(PlayerPedId()), 0.0, 0.0, 0)

-- --                     -- TaskUseScenarioPoint(ped, scenario, putDownScenario, -1, false, true, 0, false, -1.0, 0)

-- --                     -- Citizen.Wait(250)

-- --                     -- TaskStartScenarioInPlace(ped, GetHashKey(putDownScenario), -1, 1, 0, -1, 0)

-- --                     -- Citizen.Wait(2500)

-- --                     -- ClearPedTasks(ped,1,0)

-- --                     SetPedToRagdoll(PlayerPedId(), 1, 1, 1, 0, 0, 0)

-- --                     Citizen.Wait(100)
-- --                     while GetEntityVelocity(scenario_active_entity) ~= vec3(0, 0, 0) do
-- --                         print(scenario_active_entity, GetEntityVelocity(scenario_active_entity))
-- --                         Citizen.Wait(100)
-- --                     end

-- --                     local scene_entity_coords = GetEntityCoords(scenario_active_entity)
-- --                     local scene_entity_heading = GetEntityHeading(scenario_active_entity)

-- --                     SetEntityAsMissionEntity(scenario_active_entity, true, true)
-- --                     DeleteEntity(scenario_active_entity)

-- --                     local snc = Citizen.InvokeNative(0x94B745CE41DB58A1, GetHashKey(scenario_active_type), scene_entity_coords, scene_entity_heading, 0.0, 0.0, 0)
-- --                     -- Citizen.InvokeNative(0x794AB1379A74064D, GetHashKey(scenario_active_type), scenario_active_entity, 0.0, 0.0, 0.0, GetEntityHeading(scenario_active_entity), 0, -1.0, 1)

-- --                     -- print(scene_entity_heading, Citizen.InvokeNative(0xB93EA7184BAA85C3, snc, 1, Citizen.ResultAsFloat()))

-- --                     scenario_active_entity = nil
-- --                     scenario_active_type = nil
-- --                 end
-- --             elseif scenario_usable ~= nil then
-- --                 draw_pickup(scenario_usable_type:find("_SACK_"))

-- --                 if IsControlJustPressed(2, 0xDFF812F9) then
-- --                     scenario_active = scenario_usable
-- --                     scenario_active_type = scenario_usable_type

-- --                     scenario_usable = nil
-- --                     scenario_usable_type = nil

-- --                     local possible_entity_models = {
-- --                         "P_CS_SACKCORN01X",
-- --                         "p_cs_sugarcorn01x",
-- --                         "p_haybale03x"
-- --                     }

-- --                     local i = 1
-- --                     while i < #possible_entity_models + 1 do
-- --                         Citizen.Wait(0)
-- --                         scenario_active_entity = Citizen.InvokeNative(0x295514F198EFD0CA, scenario_active, possible_entity_models[i] .. "_PH_R_HAND", Citizen.ResultAsInteger())

-- --                         if scenario_active_entity ~= 0 then
-- --                             break
-- --                         end

-- --                         i = i + 1
-- --                     end

-- --                     print("scenario_active_entity", scenario_active_entity)

-- --                     local scenario_coords = Citizen.InvokeNative(0xA8452DD321607029, scenario_usable)

-- --                     TaskUseScenarioPoint(ped, scenario_active, scenario_active_type, -1, false, true, 0, false, -1.0, 0)

-- --                     Citizen.Wait(250)

-- --                     TaskStartScenarioInPlace(ped, GetHashKey(scenario_active_type), -1, 1, 0, -1, 0)
-- --                 end
-- --             end
-- --         end
-- --     end
-- -- )

-- function _FindClosestActiveScenarioPointOfType(pCoords, scenarioType, distance)
--     return Citizen.InvokeNative(0xF533D68FF970D190, pCoords, GetHashKey(scenarioType), distance, 0, 0)
-- end

-- function _GetScenarioPointCoords(scenario)
--     return Citizen.InvokeNative(0xA8452DD321607029, scenario, true, Citizen.ResultAsVector())
-- end

-- function setupPrompts()
--     promptGroup = GetRandomIntInRange(0, 0xffffff)

--     prompt_pickup = PromptRegisterBegin()
--     PromptSetControlAction(prompt_pickup, 0xDFF812F9)
--     PromptSetText(prompt_pickup, CreateVarString(10, "LITERAL_STRING", "Pegar"))
--     PromptSetEnabled(prompt_pickup, 1)
--     PromptSetVisible(prompt_pickup, 1)
--     PromptSetStandardMode(prompt_pickup, true)
--     PromptSetGroup(prompt_pickup, promptGroup)
--     PromptRegisterEnd(prompt_pickup)

--     prompt_putdown = PromptRegisterBegin()
--     PromptSetControlAction(prompt_putdown, 0x7F8D09B8)
--     PromptSetText(prompt_putdown, CreateVarString(10, "LITERAL_STRING", "Colocar no Chão"))
--     PromptSetEnabled(prompt_putdown, 1)
--     PromptSetVisible(prompt_putdown, 1)
--     PromptSetStandardMode(prompt_putdown, true)
--     PromptSetGroup(prompt_putdown, promptGroup)
--     PromptRegisterEnd(prompt_putdown)
-- end

-- function draw_pickup(isBale)
--     PromptSetEnabled(prompt_pickup, true)
--     PromptSetEnabled(prompt_putdown, false)
--     PromptSetActiveGroupThisFrame(promptGroup, isBale == true and var_bale or var_sack)
-- end

-- function draw_putdown(isBale)
--     PromptSetEnabled(prompt_putdown, true)
--     PromptSetEnabled(prompt_pickup, false)
--     PromptSetActiveGroupThisFrame(promptGroup, isBale == true and var_bale or var_sack)
-- end

-- AddEventHandler(
--     "onResourceStop",
--     function(resourceName)
--         if resourceName == GetCurrentResourceName() then
--             PromptDelete(prompt_pickup)
--             PromptDelete(prompt_putdown)
--         end
--     end
-- )

-- local pickupableEntity

-- local lastUsedScenario

-- Citizen.CreateThread(
--     function()
--         local possibleModels = {
--             "p_haybale03x"
--         }

--         while true do
--             Citizen.Wait(1000)

--             local ped = PlayerPedId()
--             local pCoords = GetEntityCoords(ped)

--             pickupableEntity = GetClosestObjectOfType(pCoords, 10.0, GetHashKey("p_haybale03x"), 0, 0, 0)
--         end
--     end
-- )

-- Citizen.CreateThread(
--     function()
--         while true do
--             Citizen.Wait(0)

--             local ped = PlayerPedId()

--             if lastUsedScenario == nil then
--                 if pickupableEntity ~= nil then
--                     local pCoords = GetEntityCoords(ped)

--                     local pickupableEntityCoords = GetEntityCoords(pickupableEntity)

--                     -- Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, pCoords, pickupableEntityCoords, 255, 0, 0, 255)

--                     if #(pCoords - pickupableEntityCoords) <= 1.0 then
--                         draw_pickup(true)

--                         if PromptIsJustPressed(prompt_pickup) then
--                             local pickupableEntityHeading = GetEntityHeading(pickupableEntity)

--                             SetEntityAsMissionEntity(pickupableEntity, true, true)
--                             DeleteEntity(pickupableEntity)

--                             local scenario = Citizen.InvokeNative(0x94B745CE41DB58A1, GetHashKey("WORLD_HUMAN_BALE_PICKUP_1"), pickupableEntityCoords, pickupableEntityHeading, 0.0, 0, 1)
--                             TaskUseScenarioPoint(ped, scenario, "", -1.0, 0, 0, 0, 0, 0)

--                             -- Citizen.Wait(250)

--                             local tries = 0
--                             while Citizen.InvokeNative(0x5BA659955369B0E2, scenario) ~= ped do
--                                 -- print( Citizen.InvokeNative(0x295514F198EFD0CA, scenario, "p_haybale03x_PH_R_HAND", Citizen.ResultAsInteger()))
--                                 print(Citizen.InvokeNative(0x5BA659955369B0E2, scenario))
--                                 Citizen.Wait(10)
--                                 tries = tries + 1
--                                 if tries >= 99 then
--                                     break
--                                 end
--                             end

--                             print(tries)

--                             if tries < 99 then
--                                 print('yes')
--                                 -- print(Citizen.InvokeNative(0xA92450B5AE687AAF, scenario), GetHashKey("WORLD_HUMAN_BALE_PICKUP_1"))

--                                 TaskStartScenarioInPlace(ped, GetHashKey("WORLD_HUMAN_BALE_PICKUP_1"), -1, 1, 0, -1, 0)

--                                 lastUsedScenario = scenario
--                             else
--                                 ClearPedTasks(ped, 1, 0)
--                             end
--                         end
--                     end
--                 end
--             else
--                 -- print( Citizen.InvokeNative(0x841475AC96E794D1 , lastUsedScenario),  Citizen.InvokeNative(0x5BA659955369B0E2, lastUsedScenario))
--                 if Citizen.InvokeNative(0x5BA659955369B0E2, lastUsedScenario) ~= ped then
--                     Citizen.InvokeNative(0x81948DFE4F5A0283, lastUsedScenario)
--                     lastUsedScenario = nil
--                     SetPedToRagdoll(PlayerPedId(), 1, 1, 1, 0, 0, 0)
--                     print('set to nil')
--                 else
--                     draw_putdown(true)

--                     if PromptIsJustPressed(prompt_putdown) then
--                         lastUsedScenario = nil
--                         SetPedToRagdoll(PlayerPedId(), 1, 1, 1, 0, 0, 0)
--                     end
--                 end
--             end
--         end
--     end
-- )
