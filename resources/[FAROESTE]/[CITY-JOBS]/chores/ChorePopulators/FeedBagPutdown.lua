local positions = {
    vec3(-744.510,-1369.972,43.256)
}

local scenarios = {}

function PopulateFeedBagPutdown()
    local ped = PlayerPedId()
    local pedPosition = GetEntityCoords(ped)

    local scenarioType = "WORLD_HUMAN_FEEDBAG_PUTDOWN"
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

function GetPopulationFeedBagPutdown()
    return scenarios
end
