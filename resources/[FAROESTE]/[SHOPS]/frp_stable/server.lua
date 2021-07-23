local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterNetEvent("FRP:STABLE:UpdateHorseComponents")
AddEventHandler(
    "FRP:STABLE:UpdateHorseComponents",
    function(components, idhorse)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        User:setHorse(idhorse)
        Character:setHorse(idhorse)

        local Horse = Character:getHorse()

        Horse:setComponents(components)
        cAPI.setHorseComponents(_source, components)
    end
)

RegisterNetEvent("FRP:STABLE:AskForMyHorses")
AddEventHandler(
    "FRP:STABLE:AskForMyHorses",
    function()
        local _source = source

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        local horses = Character:getHorses() or {}

        if #horses <= 0 then
            return
        end

        local Horse = Character:getHorse()
        local selectedHorseId
        if Horse ~= nil then
            selectedHorseId = Horse:getId()
        end

        for _, data in pairs(horses) do
            if selectedHorseId ~= nil and data.id == selectedHorseId then
                data.selected = true
            end
            data.charid = nil
        end

        -- for k,v in pairs(horses) do
           -- print(k,v)
        -- end        
        TriggerClientEvent("FRP:STABLE:ReceiveHorsesData", _source, horses)
        -- TriggerClientEvent("FRP:STABLE:callhorse", _source)
    end
)

RegisterNetEvent("FRP:STABLE:BuyHorse")
AddEventHandler(
    "FRP:STABLE:BuyHorse",
    function(data, name)

        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local Horses = Character:getHorses()
        local Inventory = Character:getInventory()

        if #Horses >= 1 then
            TriggerClientEvent('FRP:NOTIFY:Simple', _source, 'Limite de estabulo alcançado!', 5000)
            return
        end

        if data.IsGold then
            if Inventory:getItemAmount("gold") < data.Gold*100 then
                TriggerClientEvent('FRP:NOTIFY:Simple', _source, 'Gold insuficiente!', 5000)
                return
            end
            Inventory:removeItem(-1, "gold", data.Gold*100)
        else
            if Inventory:getItemAmount("money") < data.Dollar*100 then
                TriggerClientEvent('FRP:NOTIFY:Simple', _source, 'Dollar insuficiente!', 5000)
                return
            end
            Inventory:removeItem(-1, "money", data.Dollar*100)
        end

        Character:createHorse(data.ModelH, tostring(name))
    end
)

RegisterNetEvent("FRP:STABLE:SelectHorseWithId")
AddEventHandler(
    "FRP:STABLE:SelectHorseWithId",
    function(id)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        User:setHorse(id)

        -- Character:setHorse(id)
        
        local Horse = Character:getHorse()
        
        TriggerClientEvent('FRP:NOTIFY:Simple', _source, 'Cavalo selecionado', 5000)
    end
)


RegisterNetEvent("FRP:STABLE:SellHorseWithId")
AddEventHandler(
    "FRP:STABLE:SellHorseWithId",
    function(id)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local Inventory = Character:getInventory()     
        local Horse = Character:getHorse()

        if Horse == nil then            
            TriggerClientEvent('FRP:NOTIFY:Simple', _source, 'Você já vendeu este cavalo.', 5000)
            return
        end

        TriggerClientEvent('FRP:NOTIFY:Simple', _source, 'Cavalo vendido com sucesso.', 5000)  

        Character:removeHorse(tonumber(id))
        Character:deleteHorse(tonumber(id))
                
        Inventory:addItem("money", 1000)
    end
)

