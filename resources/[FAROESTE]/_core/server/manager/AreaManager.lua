local registeredAreas = {}
local playersAreas = {}

function API.registerArea(areaId, ...)
    registeredAreas[areaId] = ...

    cAPI.RegisterArea(-1, ...)
end

function API.getPlayersAtArea(areaId)
    return playersAreas[areaId] or {}
end

RegisterNetEvent("FRP:AREA:PlayerEnteredArea")
RegisterNetEvent("FRP:AREA:PlayerLeftArea")

AddEventHandler(
    "API:playerSpawned",
    function(source, user_id, isFirstSpawn)
        if isFirstSpawn then
            cAPI.RegisterAreas(source, registeredAreas)
        end
    end
)

AddEventHandler(
    "onResourceStart",
    function(resourceName)
        if resourceName ~= GetCurrentResourceName() then
            return
        end

        Citizen.Wait(2000)

        cAPI.RegisterAreas(-1, registeredAreas)
    end
)

AddEventHandler(
    "FRP:AREA:PlayerEnteredArea",
    function(areaId)
        local _source = source

        if playersAreas[areaId] == nil then
            playersAreas[areaId] = {}
        end

        table.insert(playersAreas[areaId], _source)
    end
)

AddEventHandler(
    "FRP:AREA:PlayerLeftArea",
    function(areaId)
        local _source = source

        if playersAreas[areaId] ~= nil then
            for _, v in pairs(playersAreas[areaId]) do
                if v == _source then
                    playersAreas[areaId][_] = nil
                end
            end

            if #playersAreas[areaId] <= 0 then
                playersAreas[areaId] = nil
            end
        end
    end
)


AddEventHandler(
    'playerDropped',
    function(reason)
        local _source = source

        for areaId, v in pairs(playersAreas) do
            for _, player in pairs(v) do
                if _source == player then
                    playersAreas[areaId][_] = nil
                end
            end
            if #playersAreas[areaId] <= 0 then
                playersAreas[areaId] = nil
            end
        end
    end
)