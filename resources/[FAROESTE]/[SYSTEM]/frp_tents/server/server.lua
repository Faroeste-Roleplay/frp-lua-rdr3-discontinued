local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

Tents = {}

inv = {}

-- TriggerEvent('crz_inventory:use', function(invcall)
--     inv = invcall
-- end)

RegisterServerEvent('FRP:TENTS:createdTent')
AddEventHandler('FRP:TENTS:createdTent', function(tent, model, pos, rot, heading)
    local _source = source
    local User = API.getUserFromSource(source)
    local Character = User:getCharacter()
    local Inventory = Character:getInventory()

    Inventory:removeItem(-1, tent, 1)
    Tents.addNew(_source, model, pos, rot, heading)
end)


RegisterServerEvent('FRP:TENTS:removeTents')
AddEventHandler('FRP:TENTS:removeTents', function(tentId, id)
    local src = source
    Tents.removeTent(src, tonumber(tentId), tonumber(id))
end)



RegisterServerEvent('FRP:TENTS:spawnTents')
AddEventHandler('FRP:TENTS:spawnTents', function()
    local src = source
    local User = API.getUserFromSource(src)
    local Character = User:getCharacter()
    local NotSpawned = false

    while not NotSpawned do  
        Citizen.Wait(1000)
        TriggerClientEvent('FRP:TENTS:spawnCliTents', GetHostId(), Tents.getAllTents(), Character:getId())
        NotSpawned = true
    end
end)

function Tents.addNew(src, model, pos, rot, heading)
    local _source = source
    local User = API.getUserFromSource(source)
    local Character = User:getCharacter()
    local Inventory = Character:getInventory()

    local _source = source
    local User = API.getUserFromSource(source)
    local Character = User:getCharacter()

    local charid = Character:getId()

    local position = {
        ["x"] = math.floor(pos.x*100)*0.01, -- DEUS PODEROSO
        ["y"] = math.floor(pos.y*100)*0.01, -- DEUS PODEROSO
        ["z"] = math.floor(pos.z*100)*0.01, -- DEUS PODEROSO
        ["rotx"] = math.floor(rot.x*100)*0.01,
        ["roty"] = math.floor(rot.y*100)*0.01,
        ["rotz"] = math.floor(rot.z*100)*0.01,
        ["h"] = math.floor(heading*100)*0.01
    }

    API.AddTents(charid, model, position)
end

function Tents.getTents(source, callback)
    local _source = source
    local User = API.getUserFromSource(source)
    local Character = User:getCharacter()        
    local charid = Character:getId()

    return API.GetTents(charid)
end


function Tents.getAllTents(src, callback) 
    return API.GetAllTents()
end

function Tents.removeTent(src, id, itemId)

    return API.RemoveTents(src, id, itemId)

    -- MySQL.Async.fetchAll("DELETE FROM FRP:TENTS WHERE id = @id", {['@id'] = id}, function(rows)
    --     if rows then
    --         inv.addItem(src, itemId, 1, 0, 0) 
    --     end        
    -- end)

end