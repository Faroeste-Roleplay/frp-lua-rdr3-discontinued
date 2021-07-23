local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterNetEvent("redemrp_Deliveryjob:payout")
AddEventHandler(
    "redemrp_Deliveryjob:payout",
    function(cash, gold, xp)
        local _source = source

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if Character == nil then
            return
        end

        Character:varyExp(xp)

        local Inventory = Characater:getInventory()

        if Inventory:addItem("money", cash) then
            User:notify("item", "money", cash)
        end

        if Inventory:addItem("gold", gold) then
            User:notify("item", "gold", gold)
        end
    end
)
