local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent("FRP:DELIVERY:pay")
AddEventHandler("FRP:DELIVERY:pay",function(payment)
    local _source = source
    local User = API.getUserFromSource(_source)
    local Inventory = User:getCharacter():getInventory()
    Inventory:addItem('money', payment)
end)
