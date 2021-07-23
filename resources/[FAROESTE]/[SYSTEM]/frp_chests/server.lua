local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")
dbAPI = Proxy.getInterface("API_DB")

local tempPCapacity = {}

RegisterNetEvent("FRP:CHESTS:AskForSync")
RegisterNetEvent("FRP:CHESTS:StartPlayerPlacement")
RegisterNetEvent("FRP:CHESTS:EndPlayerPlacement1")
RegisterNetEvent("FRP:CHESTS:Open")

AddEventHandler(
    "FRP:CHESTS:AskForSync",
    function()
        local _source = source
        API.syncChestsWithPlayer(_source)
    end
)

AddEventHandler(
    "FRP:CHESTS:StartPlayerPlacement",
    function(source, capacity)
        local _source = source
        tempPCapacity[_source] = capacity
        TriggerClientEvent("FRP:CHESTS:StartPlayerPlacement", _source, capacity)
    end
)

AddEventHandler(
    "FRP:CHESTS:EndPlayerPlacement1",
    function(capacity, x, y, z, h)
        local _source = source

        if tempPCapacity[_source] == nil then
            return
        end

        capacity = tempPCapacity[_source]

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local Inventory = Character:getInventory()

        local item_id = getItemIdFromCapacity(capacity)
        local ItemData = API.getItemDataFromId(item_id)

        if x == nil and y == nil and z == nil and h == nil then
            Inventory:addItem(item_id, 1)
        end

        Wait(100)

        -- if Inventory:getItemAmount(item_id) < 1 then
        --     User:notify('Você não tem 1x ' .. ItemData:getName() .. ' no inventário')
        --     return
        -- end

        -- Inventory:removeItem(item_id, 1)

        tempPCapacity[_source] = nil

        local charid = Character:getId()
        local position = {x, y, z, h}
        local query = dbAPI.query("FCRP/CreateChest", {charid = charid, position = json.encode(position), type = 1, capacity = capacity})
        if #query > 0 then
            local chestId = rowsWithId[1].id
            local Chest = API.Chest(chestId)
            Chest.owner_char_id = charid
            Chest.position = position
            Chest.type = 1
            Chest.capacity = capacity, API.cacheChest(Chest)
        end
    end
)

AddEventHandler(
    "FRP:CHESTS:Open",
    function(chestId)
        local _source = source

        if chestId:match("house") == nil then
            local Chest = API.getChestFromChestId(chestId)
            local User = API.getUserFromSource(_source)
            -- local Character = User:getCharacter()
            -- local primaryInventory = User:getPrimaryInventoryViewing()
            -- local secondaryInventory = User:getSecondaryInventoryViewing()

            local chestInventory = Chest:getInventory(User)

            if chestInventory == nil then
                User:notify("Você não pode abrir este baú")
                return
            end

            User:viewInventory()
            User:viewInventoryAsSecondary(chestInventory)
        end
    end
)

AddEventHandler(
    "playerDropped",
    function(reason)
        local _source = source
        tempPCapacity[_source] = nil
        -- local User = API.getUserFromSource(_source)
    end
)

AddEventHandler(
    "playerConnecting",
    function(name, setReason)
        local _source = source
        TriggerClientEvent("FRP:CHESTS:SyncMultipleChests", _source, tempChests)
    end
)

AddEventHandler(
    "FRP:playerSpawned",
    function(source, user_id, isFirstSpawn)
        if isFirstSpawn then
            API.syncChestsWithPlayer(source)
        end
    end
)

function getItemIdFromCapacity(capacity)
    if capacity == 25 then
        return "chest_small"
    end

    if capacity == 50 then
        return "chest_medium"
    end

    if capacity == 100 then
        return "chest_large"
    end

    return nil
end
