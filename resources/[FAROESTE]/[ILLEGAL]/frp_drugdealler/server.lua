local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

--local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------

local quantidade = {}

function Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(1,3)
	end
end
RegisterServerEvent("FRP:CONTRABANDO:checkPayment")
AddEventHandler(
    "FRP:CONTRABANDO:checkPayment",
	function()
	Quantidade()
	local _source = source
	local User = API.getUserFromSource(_source)
	local Character = User.getCharacter()
	local Inventory = Character:getInventory()
	if User ~= nil then
		if Inventory:getItemAmount('opio') >= quantidade[_source] then
			Inventory:removeItem(-1, "opio", quantidade[_source])			
			User:notify("item", "opio", -quantidade[_source])
			Inventory:addItem("money", math.random(25,35)*quantidade[_source])
			User:notify("item", "money", math.random(25,35)*quantidade[_source])
			quantidade[_source] = nil
			TriggerClientEvent("FRP:CONTRABANDO:checkPayment", _source, true)
		else
			User:notify("error", "Você precisa de " .. quantidade[_source].. "x Ópio.")
		end
	end
end)

RegisterServerEvent("FRP:CONTRABANDO:ocorrencia")
AddEventHandler(
    "FRP:CONTRABANDO:ocorrencia",
	function()		
	local _source = source
	local User = API.getUserFromSource(_source)
	local Character = User.getCharacter()
	local x,y,z = cAPI.getPosition(_source)
	if User ~= nil then
		--User:notify("alert", "Os oficiais foram acionados.")
		local PoliceON = API.getUsersByGroup("trooper")
		for i = 1, #PoliceON do
		--	vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
			TriggerClientEvent("FRP:TOAST:New", PoliceON[i].getSource(), "alert", "Recebemos uma denuncia do tráfico de Ópio, verifique o ocorrido.")
            TriggerClientEvent("FRP:WANTED:denuncia", PoliceON[i].getSource(), vector3(x,y,z))
        end
	end
end)