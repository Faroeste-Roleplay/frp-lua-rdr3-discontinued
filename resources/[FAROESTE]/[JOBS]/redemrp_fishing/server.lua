local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")


RegisterServerEvent("redemrp_fishing:AddFish")
AddEventHandler("redemrp_fishing:AddFish", function(name , weight)
	local _source = source
    local User = API.getUserFromSource(_source)
    local Character = User:getCharacter()
	local Inventory = Character:getInventory()

	if API.getItemDataFromName(name) then
		Inventory:removeItem(-1, name, 1)
	end
end)

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end


RegisterServerEvent("redemrp_fishing:Sell")
AddEventHandler("redemrp_fishing:Sell", function()
	local _source = source
    local User = API.getUserFromSource(_source)
    local Character = User:getCharacter()
	local Inventory = Character:getInventory()

	local ItemData = data.getItem(_source, "smallfish")
	local ItemData2 = data.getItem(_source, "mediumfish")
	local ItemData3 = data.getItem(_source, "largefish")
	
	

	if Inventory:getItemAmount("smallfish") > 0 then
		local final = API.getItemDataFromName("smallfish"):getWeight() * Inventory:getItemAmount("smallfish")
		if API.getItemDataFromName("smallfish"):getWeight() < 0.6 then
			Inventory:addItem("money", final*3.5)
			User:addXP(final*3.5)
			Inventory:removeItem(-1, "smallfish", Inventory:getItemAmount("smallfish"))
		elseif API.getItemDataFromName("smallfish"):getWeight() < 3.0  then
			Inventory:addItem("money", final*2.5)
			User:addXP(final*2.5)
			Inventory:removeItem(-1, "smallfish", Inventory:getItemAmount("smallfish"))
		end
	end
	
	if Inventory:getItemAmount("mediumfish" > 0 then
		local final = API.getItemDataFromName("mediumfish"):getWeight() * Inventory:getItemAmount("mediumfish")
			Inventory:addItem("money", final*2)
			User:addXP(final*2)
			Inventory:removeItem(-1, "mediumfish", Inventory:getItemAmount("mediumfish"))
	end
	
	if Inventory:getItemAmount("largefish") > 0 then
		local final = API.getItemDataFromName("largefish"):getWeight() * Inventory:getItemAmount("largefish")		
		Inventory:addItem("money", final*1.5)
		User:addXP(final*1.5)
		Inventory:removeItem(-1, "largefish", Inventory:getItemAmount("largefish"))
	end
end)



RegisterServerEvent("redemrp_fishing:RemoveBait")
AddEventHandler("redemrp_fishing:RemoveBait", function(name)
	local _source = source
    local User = API.getUserFromSource(_source)
    local Character = User:getCharacter()
	local Inventory = Character:getInventory()

	Inventory:removeItem(-1, name, 1)	
end)

RegisterServerEvent("RegisterUsableItem:p_baitBread01x")
AddEventHandler("RegisterUsableItem:p_baitBread01x", function(source)
    local _source = source
    TriggerClientEvent("redemrp_fishing:UseBait", _source, "p_baitBread01x")
	
end)

RegisterServerEvent("RegisterUsableItem:p_baitCorn01x")
AddEventHandler("RegisterUsableItem:p_baitCorn01x", function(source)
    local _source = source
    TriggerClientEvent("redemrp_fishing:UseBait", _source, "p_baitCorn01x")
end)

RegisterServerEvent("RegisterUsableItem:p_baitCheese01x")
AddEventHandler("RegisterUsableItem:p_baitCheese01x", function(source)
    local _source = source
    TriggerClientEvent("redemrp_fishing:UseBait", _source, "p_baitCheese01x")
end)


RegisterServerEvent("RegisterUsableItem:p_finishedragonfly01x")
AddEventHandler("RegisterUsableItem:p_finishedragonfly01x", function(source)
    local _source = source
    TriggerClientEvent("redemrp_fishing:UseBait", _source, "p_finishedragonfly01x")
end)


RegisterServerEvent("RegisterUsableItem:p_baitCricket01x")
AddEventHandler("RegisterUsableItem:p_baitCricket01x", function(source)
    local _source = source
    TriggerClientEvent("redemrp_fishing:UseBait", _source, "p_baitCricket01x")
end)

RegisterServerEvent("RegisterUsableItem:p_FinisdFishlure01x")
AddEventHandler("RegisterUsableItem:p_FinisdFishlure01x", function(source)
    local _source = source
    TriggerClientEvent("redemrp_fishing:UseBait", _source, "p_FinisdFishlure01x")
end)

RegisterServerEvent("RegisterUsableItem:p_finishdcrawd01x")
AddEventHandler("RegisterUsableItem:p_finishdcrawd01x", function(source)
    local _source = source
    TriggerClientEvent("redemrp_fishing:UseBait", _source, "p_finishdcrawd01x")
end)
