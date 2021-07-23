local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local AnimalModelToItem = {
    [`A_C_Egret_01`] = "feather_1",
    [`A_C_Heron_01`] = "feather_2",
    [-1076508705] = "feather_5",
}

RegisterNetEvent("FRP:GATHERING:Gathered")
AddEventHandler(
    "FRP:GATHERING:Gathered",
    function(entityModelHash, isHuman, entityQuality)
        local _source = source

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if Character == nil then
            return
        end

        local Inventory = Character:getInventory()

        local item = 'meat_poor'
        local itemAmount = 1

        if not isHuman then
            if AnimalModelToItem[entityModelHash] then
                item = AnimalModelToItem[entityModelHash] 
            else
                if entityQuality == 2 then
                    item = 'meat_perfect'
                elseif  entityQuality == 1 then
                    item = 'meat_good'
                elseif  entityQuality == 0 then
                    item = 'meat_poor'
                end
            end
        else
            item = 'money'
            itemAmount = 1
        end

        if Inventory:addItem(item, 1) then
            User:notify("item", item, itemAmount)
        else
            User:notify("Bolsa sem espaço!")
        --     TriggerClientEvent("FRP:LOOTING:LooteableDenied", _source, GetHashKey('p_whitefleshymeat01xa'))
        end
    end
)
