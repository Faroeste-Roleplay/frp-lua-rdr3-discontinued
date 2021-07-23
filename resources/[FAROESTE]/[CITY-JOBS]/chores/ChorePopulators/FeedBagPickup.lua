local positions = {
    vec3(-742.337, -1366.698, 43.357)
}

local scenarios = {}

function PopulateFeedBagPickup()
    local ped = PlayerPedId()
    local pedPosition = GetEntityCoords(ped)

    local scenarioType = "WORLD_HUMAN_FEEDBAG_PICKUP"
    local scenarioTypeHash = GetHashKey(scenarioType)

    for _, position in pairs(positions) do
        local hasCollision, groundZ, normal = GetGroundZAndNormalFor_3dCoord(position.x, position.y, position.z)

        if hasCollision then
            position = vec3(position.xy, groundZ)
            if NativeFindClosestActiveScenarioPointOfType(scenarioTypeHash, position, 2.0) == 0 then
                local scenario = NativeCreateScenarioPoint(scenarioTypeHash, position, 180.0)
                table.insert(scenarios, scenario)
            end
        end
    end
end

function GetPopulationFeedBagPickup()
    return scenarios
end

local usingScenario = false
local closestFeedingIndex
local closestFeedingPosition

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            if usingScenario == false then
                local ped = PlayerPedId()
                if Citizen.InvokeNative(0x2D0571BB55879DA2, ped) ~= GetHashKey("WORLD_HUMAN_FEEDBAG_PICKUP") then
                    local pPosition = GetEntityCoords(ped)

                    local cIndex
                    local cDist

                    for _, location in pairs(positions) do
                        -- if
                        local dist = #(pPosition - location)
                        if dist <= 10.0 then
                            if cDist == nil or dist < cDist then
                                cIndex = _
                                cDist = dist
                            end
                        end
                    end

                    closestFeedingIndex = cIndex

                    if closestFeedingIndex ~= nil then
                        closestFeedingPosition = positions[closestFeedingIndex]

                        HandleFeedbagPickup()
                    else
                        closestFeedingPosition = nil
                    end
                else
                    closestFeedingPosition = nil
                end
            end
        end
    end
)

function HandleFeedbagPickup()
    local ped = PlayerPedId()
    while closestFeedingPosition ~= nil do
        Citizen.Wait(0)

        local pPosition = GetEntityCoords(ped)

        local dist = #(pPosition - closestFeedingPosition)

        -- print(dist)

        if dist <= 1.5 then
            -- if PromptFeedbag() then
            if IsControlJustPressed(0, 0x7F8D09B8) then
                usingScenario = true
                print("yes")
                PromptDelete(prompt)
                prompt = nil

                local scenario = scenarios[closestFeedingIndex]

                -- print(scenario)

                TaskUseScenarioPoint(ped, scenario, 0, 0, true, false, 0, false, -1, false)

                -- local prop =

            -- TaskStartScenarioInPlace(ped, Citizen.InvokeNative(scenario), 0, true, 0, -1.0, false)
            -- break
            end
        end
    end
end

local prompt

function PromptFeedbag()
    if prompt == nil then
        prompt = NewPrompt()
        -- 0xE8342FF2
        PromptSetControlAction(prompt, 0x7F8D09B8)
        PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Pegar Alimento"))
        PromptSetStandardMode(prompt, true)
        PromptSetEnabled(prompt, 1)
        PromptSetVisible(prompt, 1)
        PromptSetStandardMode(prompt, 1)
        -- N_0x0c718001b77ca468(prompt, 3.0)
        -- PromptSetGroup(prompt, prompt_group)
        PromptRegisterEnd(prompt)
    end

    return PromptIsJustPressed(prompt)
end
