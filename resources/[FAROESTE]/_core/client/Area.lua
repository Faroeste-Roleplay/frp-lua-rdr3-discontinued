local registeredAreas = {}

local areasPlayerIsInside = {}

RegisterNetEvent("FRP:AREA:PlayerEnteredArea")
RegisterNetEvent("FRP:AREA:PlayerLeftArea")

function cAPI.RegisterAreas(areas)
    for areaId, _ in pairs(areas) do
        cAPI.RegisterArea(areaId, _)
    end
end

function cAPI.RegisterArea(areaId, ...)
    local params = {}
    local vectors = {}

    for _, v in pairs(...) do
        if type(v) == "vector3" then
            table.insert(vectors, v)
        else
            params[_] = v
        end
    end

    local area = pArea(params)
    area.addBulk(table.unpack(vectors))

    registeredAreas[areaId] = area

    if areasPlayerIsInside[areaId] ~= nil then
        areasPlayerIsInside[areaId] = nil
        TriggerServerEvent("FRP:AREA:PlayerLeftArea", areaId)
        TriggerEvent("FRP:AREA:PlayerLeftArea", areaId)
    end

    return area
end

-- function cAPI.GetAreaPlayerIsIn()
--     return areaPlayerIsInside
-- end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(100)
            for areaId, area in pairs(registeredAreas) do
                if area.isInside() then
                    if not areasPlayerIsInside[areaId] then
                        areasPlayerIsInside[areaId] = true
                        TriggerServerEvent("FRP:AREA:PlayerEnteredArea", areaId)
                        TriggerEvent("FRP:AREA:PlayerEnteredArea", areaId)
                    end
                else
                    if areasPlayerIsInside[areaId] then
                        areasPlayerIsInside[areaId] = nil
                        TriggerServerEvent("FRP:AREA:PlayerLeftArea", areaId)
                        TriggerEvent("FRP:AREA:PlayerLeftArea", areaId)
                    end
                end
            end
        end
    end
)
