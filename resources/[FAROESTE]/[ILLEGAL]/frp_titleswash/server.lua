local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent('FRP:TITLESWASH:washMoney')
AddEventHandler('FRP:TITLESWASH:washMoney', function()
    local _source = source
    local User = API.getUserFromSource(source)
    local Character = User:getCharacter()
	local Inventory = Character:getInventory()

	local accountMoney = 0
	
	accountMoney = Inventory:getItemAmount("titles")

	if accountMoney < 99 then
		User:notify("error", "Você não possuí titulos para vender.")
	else
		Inventory:addItem("money", 50)
		Inventory:removeItem(-1, "titles", 1)
		User:notify("item", "money", 50/100)
	end
end)