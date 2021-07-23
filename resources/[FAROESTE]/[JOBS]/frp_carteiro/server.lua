local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent("FRP:CARTEIRO:pay")
AddEventHandler(
    "FRP:CARTEIRO:pay",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        Inventory:addItem('money', 20*100)
    end
)