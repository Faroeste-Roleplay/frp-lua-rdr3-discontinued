local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterServerEvent('FRP:IDENTITY:DisplayCharSelection')
AddEventHandler(
    'FRP:IDENTITY:DisplayCharSelection',
    function(User)
        if User == nil then
            return
        end

        local appearence = {}

        if User:getCharacters() ~= nil then
            for i = 1, #User:getCharacters() do
                
                local userId = User:getCharacters()[i].charid
                table.insert(appearence,User:getCharacterAppearenceFromId(userId))     
            end            
        end
        
        TriggerClientEvent('FRP:IDENTITY:DisplayCharSelection', User:getSource(), User:getCharacters(), appearence)
    end
)

RegisterServerEvent('FRP:IDENTITY:DisplayCharSelectionWithUser')
AddEventHandler(
    'FRP:IDENTITY:DisplayCharSelectionWithUser',
    function(User)
        if User == nil then
            return
        end
        
        local appearence = {}

        for i = 1, #User:getCharacters() do
            local userId = User:getCharacters()[i].charid
            table.insert(appearence,User:getCharacterAppearenceFromId(userId))
        end
        
        TriggerClientEvent('FRP:IDENTITY:DisplayCharSelection', User:getSource(), User:getCharacters(), appearence)
    end
)

RegisterServerEvent('FRP:IDENTITY:selectCharacter')
AddEventHandler(
    'FRP:IDENTITY:selectCharacter',
    function(cid)
        local _source = source
        local User = API.getUserFromSource(_source)
        User:setCharacter(cid)
    end
)

RegisterServerEvent('FRP:IDENTITY:deleteCharacter')
AddEventHandler(
    'FRP:IDENTITY:deleteCharacter',
    function(cid)
        local _source = source
        local User = API.getUserFromSource(_source)
        User:deleteCharacter(cid)
        TriggerEvent('FRP:IDENTITY:DisplayCharSelection', source, _source)
    end
)
