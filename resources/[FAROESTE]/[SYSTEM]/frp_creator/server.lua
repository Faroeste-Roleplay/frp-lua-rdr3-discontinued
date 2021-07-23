local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterNetEvent('VP:CREATOR:saveCreation')
AddEventHandler('VP:CREATOR:saveCreation', function(characterName, Age, SkinMdf)
    local _source = source
    local User = API.getUserFromSource(_source)
    local Character = User:createCharacter(characterName, Age)
    if Character ~= nil then
        Character:setSkinData(Character:getId(), json.encode(SkinMdf))

        Character:setData(Character:getId(), "metaData", "hunger", 100)
        Character:setData(Character:getId(), "metaData", "thirst", 100)
        Character:setData(Character:getId(), "metaData", "banco", 0)

        local encoded = json.encode({-1099.470,-1839.129,60.327})
        Character:setData(Character:getId(), "metaData", "position", encoded)       
        User:setCharacter(Character:getId()) -- Will draw itself      
    end
     Wait(1000)
    TriggerClientEvent('VP:CREATOR:FirstSpawn', _source)    
end)
