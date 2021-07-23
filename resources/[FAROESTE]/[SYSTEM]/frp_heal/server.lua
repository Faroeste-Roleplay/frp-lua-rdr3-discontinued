local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent("frp_heal:heallife")
AddEventHandler(
    "frp_heal:heallife",
    function(price)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        if Inventory:getItemAmount("money") < price then
            User:notify("error", "Dinheiro insuficiente!")
            return
        end
        User:notify("successo", "Você foi curado")
        User:notify("item", "money", -price) 
        Inventory:removeItem(-1, "money", price)
        TriggerClientEvent("heal:player", _source)
    end
)
