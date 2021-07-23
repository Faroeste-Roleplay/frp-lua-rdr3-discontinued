local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterNetEvent("gdhdrfgrdf")
AddEventHandler(
    "gdhdrfgrdf",
    function()
        local _source = source
        local item = "gold_nugget"
        local r = math.random(1, 10)

        local User = API.getUserFromSource(_source)

        if r < 5 then
            local Character = User:getCharacter()

            if Character == nil then
                return
            end

            local Inventory = Characater:getInventory()

            local rdn = math.random(1, 3)

            if Inventory:addItem("gold_nugget", rdn) then
                User:notify("item", "gold_nugget", rdn)
            else
                User:notify("error", "Bolsa sem espaço!")
            end
        else
            User:notify("error", "Você não achou nada!")
        end
    end
)
