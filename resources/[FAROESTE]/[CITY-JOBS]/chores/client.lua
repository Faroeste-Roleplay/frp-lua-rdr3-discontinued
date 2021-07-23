local oldscenarios = {}

RegisterCommand(
    "scenarios",
    function()
        local r = {
            -- "PG_SCENARIO_CHOPWOOD", -- DW
            -- "PG_AMBIENT_CAMP_ADD_WOOD", -- DW
            -- "PROP_HUMAN_WOOD_CHOP"
            -- "PROP_HUMAN_WOOD_CHOP_AXESTUCK_01_02",
            -- "WORLD_HUMAN_PLANE_WOOD_NO_PLANK",
            -- "WORLD_HUMAN_PLANE_WOOD",
            -- "PLAYER_CAMP_CHORES_WOOD_CHOP",
            -- "BCH_WOOD_CHOP_PRESADIE3",
            -- "PROP_HUMAN_WOOD_CHOP_AND_SHARPEN_AXE"
            -- "WORLD_PLAYER_CHORES_FEEDBAG_PICKUP",
            -- "WORLD_PLAYER_CHORES_FEEDBAG_PUTDOWN",
            -- "WORLD_HUMAN_CHICKEN_CRATE_PICKUP_2",
            -- "WORLD_HUMAN_CHAMBERPOT_PICKUP_PUTDOWN"
            -- "WORLD_HUMAN_CHAMBERPOT_PICKUP"
            -- "WORLD_HUMAN_SACK_OUT_BIN_TARP",
            -- "WORLD_PLAYER_CHORES_SACK_PICKUP_1",
            -- -- "WORLD_PLAYER_CHORES_SACK_PICKUP_1"
            -- "WORLD_PLAYER_CHORES_SACK_PUT_DOWN_1",
            -- "RANSACK_PROP_CHEST_PICKUP",
            -- "RANSACK_PROP_CHEST_PUTDOWN",
            -- "WORLD_HUMAN_NEWSPAPER_PICKUP",
            -- "PROP_HUMAN_BUTCHER_DEER_MALE_A_MEAT_DROP",
            -- "PROP_HUMAN_PUMP_WATER",
            -- "PROP_HUMAN_PUMP_WATER_BUCKET",
            -- "PROP_HUMAN_PUMP_WATER_BUCKET_FEMALE_B",
            -- "PROP_HUMAN_PUMP_WATER_BUCKET_MALE_A  ",
            -- "PROP_HUMAN_PUMP_WATER_FEMALE_B",
            -- "PROP_HUMAN_PUMP_WATER_MALE_A",
            -- "WORLD_CAMP_BOWL_PUT_DOWN_WASHBASIN",
            -- "WORLD_HUMAN_WASHBOARD_BASIN",
            -- "WORLD_HUMAN_WASHBOARD_FEMALE_A",
            -- "WORLD_HUMAN_WASHBOARD",
            -- "WORLD_HUMAN_WASH_DISHES_TABLE_LEFT_DROP_BOWL_FEMALE_A",
            -- "MP_MOONSHINE_BAND_PROP_HUMAN_SEAT_CHAIR_WASHBOARD_HANDOFF_PLAYER"
            -- "WORLD_HUMAN_SIT_DRINK",
            -- "WORLD_HUMAN_CLEAN_TABLE",
            "WORLD_HUMAN_FEEDBAG_PICKUP",
            -- "WORLD_HUMAN_FEED_PIGS"
            -- "WORLD_HUMAN_SACK_PICKUP_1_",
            -- "WORLD_HUMAN_SACK_PICKUP",
            --  "WORLD_HUMAN_BASKET_PICKUP",
            "WORLD_HUMAN_FEED_CHICKEN",
            "WORLD_HUMAN_FEED_CHICKENS_FEMALE_A",
            "WORLD_HUMAN_FEED_CHICKENS_MALE_A",
        }

        -- _NO : Means you can attach the scenario to your on prop

        local ped = PlayerPedId()
        local pcoords = GetEntityCoords(ped)

        local offset = vec3(pcoords.x + math.random(-5.0, 5.0), pcoords.y + math.random(-5.0, 5.0), pcoords.z)
        local _, groundZ, normal = GetGroundZAndNormalFor_3dCoord(offset.x, offset.y, offset.z)

        for _, v in pairs(r) do
            SetScenarioGroupEnabled(v, true)
            print("#" .. _)

            -- local offset = vec3(pcoords.x + math.random(-5.0, 5.0), pcoords.y + math.random(-5.0, 5.0), pcoords.z)
            -- local _, groundZ, normal = GetGroundZAndNormalFor_3dCoord(offset.x, offset.y, offset.z)
            -- offset = vec3(offset.xy, groundZ)

            groundZ = groundZ +  0.20
            offset = vec3(offset.xy, groundZ)

            local stype = v
            local s
            local scenarioTypeHash = GetHashKey(stype)

            if type(v) == "table" then
                stype = v[1]

                local pmodel = GetHashKey(v[2])

                if IsModelValid(pmodel) then
                    if not HasModelLoaded(pmodel) then
                        RequestModel(pmodel)
                        while not HasModelLoaded(pmodel) do
                            Citizen.Wait(10)
                        end
                    end
                end

                local entity = CreateObject(pmodel, offset, true, 1, 1)

                s = NativeCreateScenarioPointAttachedToEntity(entity, scenarioTypeHash)
            else
                s = NativeCreateScenarioPoint(scenarioTypeHash, offset, 180.0)
            end

            if NativeDoesScenarioPointExist(s) then
                table.insert(oldscenarios, s)
            end
        end
    end,
    false
)

Citizen.CreateThread(
    function()
        local DRAW_LINE = GetHashKey("DRAW_LINE")

        -- print(GetVehiclePedIsIn(PlayerPedId(), false))
        -- Citizen.InvokeNative(0x2208438012482A1A, ped, false, false)

        -- local veh = 8279559
        -- Citizen.InvokeNative(0x75F90E4051CC084C, veh, GetHashKey("PG_MP005_HUNTINGWAGONTARP01"))
        -- Citizen.InvokeNative(0xC0F0417A90402742, veh, GetHashKey("PG_VEH_CART06_LANTERNS01"))
        -- local propset =Citizen.InvokeNative(0xA079300AF757FB1A, 3370002)

        -- local sc = Citizen.InvokeNative(0xF533D68FF970D190, GetEntityCoords(PlayerPedId()), GetHashKey("MP005_P_HUNTINGWAGONTARP01"), 50.0, 0, false)
        -- print(sc)

        while true do
            Citizen.Wait(0)
            local ped = PlayerPedId()
            local pcoords = GetEntityCoords(ped)

            local closest
            local lastdist

            for _, scenario in pairs(oldscenarios) do
                scoords = NativeGetScenarioPointCoords(scenario)

                if lastdist == nil or #(pcoords - scoords) < lastdist then
                    closest = scenario
                end

                Citizen.InvokeNative(DRAW_LINE & 0xFFFFFFFF, scoords, scoords + vec3(0, 0, 2.0), 255, 0, 0, 255)
                Citizen.InvokeNative(DRAW_LINE & 0xFFFFFFFF, pcoords, scoords, 255, 0, 0, 255)
            end

            if closest ~= nil then
                if IsControlJustPressed(0, 0xB4E465B4) then
                    print("using scenario", ped, closest)

                    -- PROP_HUMAN_WOOD_CHOP_PICKUPLSIDE2

                    TaskUseScenarioPoint(ped, closest, "", -1, true, false, 0, false, -1.0, true)

                -- local objhash = GetHashKey("p_washboard01x")

                -- if not HasModelLoaded(objhash) then
                --     RequestModel(objhash)
                --     while not HasModelLoaded(objhash)
                -- end

                -- local obj = CreateObject(objhash, pcoords, true, true, true)

                -- Citizen.InvokeNative(0x2B02DB082258625F, ped, obj, "p_washboard01x_PH_L_HAND", GetHashKey('WORLD_HUMAN_WASHBOARD'), "WORLD_HUMAN_WASHBOARD_FEMALE_A", 1)
                -- TaskUseScenarioPoint(ped, closest, "PROP_HUMAN_WOOD_CHOP_PICKUPLSIDE2", -1.0, true, false, 0, false, -1.0, true)
                -- Citizen.InvokeNative(0x2208438012482A1A, ped, false, false)
                -- Wait(5000)
                -- print('feed')
                -- TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("PROP_HUMAN_WOOD_CHOP_PICKUPLSIDE2"), 0, true, 0, -1.0, false)
                end
            end
        end
    end
)

local prompts = {}

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if GetCurrentResourceName() == resourceName then
            for _, scenario in pairs(oldscenarios) do
                NativeDeleteScenarioPoint(scenario)
            end

            for _, scenario in pairs(GetPopulationFeedBagPickup()) do
                NativeDeleteScenarioPoint(scenario)
            end

            for _, scenario in pairs(GetPopulationFeedBagPutdown()) do
                NativeDeleteScenarioPoint(scenario)
            end

            for _, scenario in pairs(GetPopulationManurePickup()) do
                NativeDeleteScenarioPoint(scenario)
            end
            
            for _, prompt in pairs(prompts) do
                PromptDelete(prompt)
            end
        end
    end
)

function NativeCreateScenarioPoint(scenarioTypeHash, scenarioCoords, scenarioHeading)
    return Citizen.InvokeNative(0x94B745CE41DB58A1, scenarioTypeHash, scenarioCoords, scenarioHeading, 0.0, 0.0, 0)
end

function NativeCreateScenarioPointAttachedToEntity(entity, scenarioTypeHash)
    return Citizen.InvokeNative(0x794AB1379A74064D, entity, scenarioTypeHash, 0.0, 0.0, 0.0, 1, 4.0, 0.0, 0)
end

function NativeDeleteScenarioPoint(scenario)
    Citizen.InvokeNative(0x81948DFE4F5A0283, scenario)
end

function NativeGetScenarioPointCoords(scenario)
    return Citizen.InvokeNative(0xA8452DD321607029, scenario, Citizen.ResultAsVector())
end

function NativeDoesScenarioPointExist(scenario)
    return Citizen.InvokeNative(0x841475AC96E794D1, scenario)
end

function _NativeGetPlayerAnim()
    return Citizen.InvokeNative(0xC22AA08A8ADB87D4, PlayerPedId())
end

function _NativeGetScenarioPointPedIsUsing()
    return Citizen.InvokeNative(0xDF7993356F52359A, PlayerPedId(), 1)
end

function NativeFindClosestActiveScenarioPointOfType(scenarioTypeHash, position, radius)
    return Citizen.InvokeNative(0xF533D68FF970D190, position, scenarioTypeHash, radius, 0, false, Citizen.ResultAsInteger())
end

function PumpScenario()
end

function NewPrompt()
    local prompt = PromptRegisterBegin()
    table.insert(prompts, prompt)
    return prompt
end

-- local rewardPrompt()
-- local r_prompt =
-- end

Citizen.CreateThread(
    function()
        local possibleScenarioTypes = {
            "PROP_HUMAN_WOOD_CHOP_AND_SHARPEN_AXE"
        }

        -- Citizen.InvokeNative(0x79559BAD83CCD038, PlayerPedId(), 8,  GetHashKey("NMBS_PLAYER_GETUPS"), 0, 0, 1090519040)

        while true do
            Citizen.Wait(0)

            local ped = PlayerPedId()

            for _, scenarioType in pairs(possibleScenarioTypes) do
                local typeHash = GetHashKey(scenarioType)
                local scenario = Citizen.InvokeNative(0xF533D68FF970D190, GetEntityCoords(PlayerPedId()), typeHash, 1.5, 0, false, Citizen.ResultAsInteger())

                if scenario ~= 0 then
                    if _NativeGetScenarioPointPedIsUsing() == scenario then
                        print("started using")
                        Wait(5000)
                        -- while _NativeGetScenarioPointPedIsUsing() == scenario do
                        Citizen.Wait(0)

                        print("using")
                        -- askStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_PLAYER_DYNAMIC_KNEEL"), 0, true, 0, -1.0, false)
                        -- TaskUseScenarioPoint(ped, scenario, "PROP_HUMAN_WOOD_CHOP_PICKUPLSIDE2", -1.0, true, false, 0, false, -1.0, true)
                        -- Citizen.InvokeNative(0xB35370D5353995CB, ped, GetHashKey("PROP_HUMAN_WOOD_CHOP_PICKUPLSIDE2"), 1048576000)
                        -- end
                        print("stopped using")
                    end
                end
            end
        end
    end
)

function HandleScenario_bucket_pickup()
end


Citizen.CreateThread(
    function()

        while true do

            PopulateFeedBagPickup()
            PopulateFeedBagPutdown()

            PopulateManurePickup()

            Citizen.Wait(2500)
        end
    end
)