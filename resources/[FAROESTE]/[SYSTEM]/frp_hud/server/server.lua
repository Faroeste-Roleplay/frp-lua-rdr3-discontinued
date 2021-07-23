local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
API_DB = Proxy.getInterface("API_DB")
cAPI = Tunnel.getInterface("API")

AddEventHandler(
    "FRP:INVENTORY:UPDATE:AddItem",
    function(Inventory, itemId)

        if itemId == 'map' then
            local _source = source
            local User = API.getUserFromSource(_source)
            local user_inventory = User:getCharacter():getInventory()
            local map_amount = user_inventory:getItemAmount()        
         
            if Inventory:getId() == user_Inventory:getId() then
                if map_amount >= 1 then
                    TriggerClientEvent('FRP:HUD:RevealMap', _source, true)
                end
            end

        end

end)

AddEventHandler(
    "FRP:INVENTORY:UPDATE:RemoveItem",
    function(Inventory, itemId)

        if itemId == 'map' then
            local _source = source
            local User = API.getUserFromSource(_source)
            local user_inventory = User:getCharacter():getInventory()
            local map_amount = user_inventory:getItemAmount()        
         
            if user_inventory:getId() == user_Inventory:getId() then
                if map_amount < 1 then
                    TriggerClientEvent('FRP:HUD:RevealMap', _source, false)
                end
            end
        end
end)


RegisterServerEvent('FRP:HUD:request')
AddEventHandler('FRP:HUD:request', function()
	local _source = source
	local User = API.getUserFromSource(_source)
    local Character = User:getCharacter()
    local Inventory = Character:getInventory()

	if Character == nil then
		return
	end
	
    local level = Character:getLevel()
    local xp = Character:getExp()
    local id = User:getId()
    local dolar = Inventory:getItemAmount("money") / 100
    local gold = Inventory:getItemAmount("gold") / 100

	
    local data = {
        ["xp"] = xp,
        ["id"] = id,
        ["dolar"] = dolar,
        ["gold"] = gold,
        ["level"] = level,
    }

	TriggerClientEvent('FRP:HUD:show', _source, data)
end) 


RegisterCommand("reveal", function(source, args)
    TriggerClientEvent('FRP:HUD:RevealMap', source, args[1])
end)