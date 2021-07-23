local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterServerEvent('VP:IDENTITY:DisplayCharSelection')
AddEventHandler(
    'VP:IDENTITY:DisplayCharSelection',
    function(User)
        if User == nil then
            return
        end

        local appearence = {}

        for i = 1, #User:getCharacters() do
            local userId = User:getCharacters()[i].charid
            table.insert(appearence,User:getCharacterAppearenceFromId(userId))     
        end
        
        TriggerClientEvent('VP:IDENTITY:DisplayCharSelection', User:getSource(), User:getCharacters(), appearence)
    end
)

RegisterServerEvent('VP:IDENTITY:DisplayCharSelectionWithUser')
AddEventHandler(
    'VP:IDENTITY:DisplayCharSelectionWithUser',
    function(User)
        if User == nil then
            return
        end
        
        local appearence = {}

        for i = 1, #User:getCharacters() do
            local userId = User:getCharacters()[i].charid
            table.insert(appearence,User:getCharacterAppearenceFromId(userId))     
        end
        
        TriggerClientEvent('VP:IDENTITY:DisplayCharSelection', User:getSource(), User:getCharacters(), appearence)
    end
)

RegisterServerEvent('VP:IDENTITY:selectCharacter')
AddEventHandler(
    'VP:IDENTITY:selectCharacter',
    function(cid)
        local _source = source
        local User = API.getUserFromSource(_source)
        User:setCharacter(cid)
    end
)

RegisterServerEvent('VP:IDENTITY:deleteCharacter')
AddEventHandler(
    'VP:IDENTITY:deleteCharacter',
    function(cid)
        local _source = source
        local User = API.getUserFromSource(_source)
        User:deleteCharacter(cid)
        TriggerEvent('VP:IDENTITY:DisplayCharSelection', source, _source)
    end
)
