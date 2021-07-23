local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterNetEvent("VP:DOCUMENTS:getCharInfo")
AddEventHandler("VP:DOCUMENTS:getCharInfo", function(source)
    local _source = source
    local User = API.getUserFromSource(_source)
    local Character = User:getCharacter()   

    local data = {
        ['charid'] = User:getId(),
        ['name'] = Character:getName(),
        ['age'] = Character:getAge(),
    }
   TriggerClientEvent("VP:DOCUMENTS:opening", _source, data)
end)

RegisterNetEvent("VP:DOCUMENTS:requestCharInfo")
AddEventHandler("VP:DOCUMENTS:requestCharInfo", function(TargetSource)
    local _source = source
    local User = API.getUserFromSource(_source)
    local Character = User:getCharacter()

  --  local TargetSource = API.getUserFromUserId(parseInt(targetUserId)):getSource()
    local UserTarget = API.getUserFromSource(TargetSource)
    local CharacterTarget = UserTarget:getCharacter()
    
    local yes = cAPI.request(TargetSource, "O " ..Character:getName().." solicitou sua identificação, deseja mostrar ?", 30)

    if yes then 
        local data = {
            ['charid'] = UserTarget:getId(),
            ['name'] = CharacterTarget:getName(),
            ['age'] = CharacterTarget:getAge(),
        }
        TriggerClientEvent("VP:DOCUMENTS:opening", _source, data)
    else
        User:notify("O cidadão recusou, mostrar sua identidade")
    end

end)