local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent("FRP:DELIVERY:pay")
AddEventHandler(
    "FRP:DELIVERY:pay",
    function(payment)
        
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        Inventory:addItem('money', payment)
    end
)

-- RegisterServerEvent("FRP:DELIVERY:paiefinale") --Paie "bonus" lors de la fin de service
-- AddEventHandler("FRP:DELIVERY:paiefinale", function()
--     local _source = source
--     local User = API.getUserFromSource(_source)
--     local Inventory = User:getCharacter():getInventory()

--     local payment = math.random(1, 5)
    
--     Inventory:addItem('money', payment*100)

--     TriggerClientEvent('FRP:NOTIFY:Simple', source, 'Aqui está uma bonificação $'.. payment, 10000)  

-- end)