local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent("bberry:buyvehicle")
AddEventHandler(
    "bberry:buyvehicle",
    function(price, vehicle, level)
        local _vehicle = vehicle
        local _level = level

        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()
        local Character = User:getCharacter()

        if Inventory:getItemAmount("money") < tonumber(price * 100) then
            print(Inventory:getItemAmount("money"))
            User:notify("error", "Doláres insuficientes")
            TriggerClientEvent("Message:cancel", source)
            return
        end
        Inventory:removeItem(-1, "money", tonumber(price * 100))
        TriggerClientEvent("spawn:vehicle", _source, vehicle)
    end
)
