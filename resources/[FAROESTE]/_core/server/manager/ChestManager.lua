local chests = {}
local chestsSyncData = {}

-- TABELA fcrp_CHESTS

-- id  charid  position       type    capacity
-- 1     1    {150, 20, 10, 10}   1      20

Citizen.CreateThread(
    function()
        local query = API_Database.query("FCRP/GetChests", {})

        if #query > 0 then
            for i = 1, #query do
                local queryData = query[i]

                local Chest = API.Chest(queryData["id"])
                Chest.owner_char_id = tonumber(queryData["charid"])
                Chest.position = json.decode(queryData["position"])
                Chest.type = tonumber(queryData["type"])
                Chest.capacity = tonumber(queryData["capacity"])

                chests[queryData["id"]] = Chest

                chestsSyncData[queryData["id"]] = {Chest.capacity, table.unpack(Chest.position)}
            end
        end
        for _, data in pairs(config_file_STATICCHESTS) do
            local chest_id, x, y, z, h, type, capacity, group = table.unpack(data)
            -- local query = API_Database.query("FCRP/CreateStaticChest", {position = json.encode({x, y, z, h}), type = type, capacity = capacity})
            -- if #query > 0 then
            local queryData = query[1]

            local Chest = API.Chest(chest_id)
            Chest.position = {x, y, z, h}
            Chest.type = type
            if group then
                Chest.groups = {group}
            end
            
            Chest.capacity = capacity

            chests[chest_id] = Chest

            chestsSyncData[chest_id] = {capacity, x, y, z, h}
        end

        TriggerClientEvent("FRP:CHESTS:SyncMultipleChests", -1, chestsSyncData)
    end
)

-- @param chest id
-- @return Chest Object
-- @exception returns nil if it doesnt exist/hasnt been loaded yet
function API.getChestFromChestId(chestId)
    return chests[chestId]
end

function API.syncChestsWithPlayer(source)
    local moreThanOne = false
    for k, v in pairs(chestsSyncData) do
        if v ~= nil then
            moreThanOne = true
            break
        end
    end

    if moreThanOne == true then
        TriggerClientEvent("FRP:CHESTS:SyncMultipleChests", source, chestsSyncData)
    end -- Vai mandar informaçoes de todos os CHESTS registrados da seguinte forma
    -- {
    --     [chestId1] = {capacity, x, y, z, h},
    --     [chestId2] = {capacity, x, y, z, h},
    --     [chestId3] = {capacity, x, y, z, h},
    --     [chestId4] = {capacity, x, y, z, h},
    -- }
    -- A capacity do CHEST determina o modelo de prop que será usado in-game
end

function API.cacheChest(Chest)
    local chest_id = Chest:getId()
    local chest_capacity = Chest:getCapacity()
    local x, y, z, h = table.unpack(Chest:getPosition())

    chests[chest_id] = Chest

    chestsSyncData[chest_id] = {chest_capacity, x, y, z, h} -- OUTPUT: -- {capacity, x, y, z}
    TriggerClientEvent("FRP:CHESTS:SyncChest", -1, chest_id, chest_capacity, x, y, z, h)
end
