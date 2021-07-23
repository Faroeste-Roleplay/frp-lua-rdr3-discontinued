local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local pocketables = {
    [`s_dis_flourite01x`] = "flourite",
    [`p_coal01x`] = "raw_coal",
    [`s_meteoriteshard01x`] = "raw_copper",
    [`s_pickup_goldbar01x`] = "raw_gold",
    [`s_dis_ammolite01x`] = "ammolite",
--     [165374176] = "beterraba",
--     [904358119] = "corn",
--     [161801294] = "gin_bottle",
--     [192341785] = 'moonshine_bottle'
-- -2094368529 -- joias
}

RegisterNetEvent("FRP:LOOTING:TryToLoot")
AddEventHandler(
    "FRP:LOOTING:TryToLoot",
    function(entityModel)
        local _source = source

        local User = API.getUserFromSource(_source)

        if not pocketables[entityModel] then
            User:notify("Você não pode pegar este item!")
            TriggerClientEvent("FRP:LOOTING:LooteableDenied", _source, entityModel)
            return
        end

        local Character = User:getCharacter()

        if Character == nil then
            return
        end

        local Inventory = Character:getInventory()

        local itemId = pocketables[entityModel]

        if Inventory:addItem(itemId, 1) then
        else
            User:notify("Espaço insuficiente!")
            TriggerClientEvent("FRP:LOOTING:LooteableDenied", _source, entityModel)
        end
    end
)
