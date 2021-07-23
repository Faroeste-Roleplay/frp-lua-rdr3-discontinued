local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local ReviveEnable = false
local target = nil
local sort = nil
RegisterCommand(
    "checar",
    function(source, args, rawCommand)
        local _source = source
        local User = API.getUserFromSource(source)
		local Character = User:getCharacter()
		local medic = Character:hasGroupOrInheritance("medic")
		local police = Character:hasGroupOrInheritance("trooper")
		local Inventory = User:getCharacter():getInventory()

		sort = math.random(1,2)
        if medic or police then
			TriggerClientEvent('VP:MEDIC:checkdeath', _source)
			ReviveEnable = false
		end
    end
)

RegisterCommand(
    "reanimar",
    function(source, args, rawCommand)
        local _source = source
        local User = API.getUserFromSource(source)
		local Character = User:getCharacter()
		local medic = Character:hasGroupOrInheritance("medic")
		local police = Character:hasGroupOrInheritance("trooper")
		local Inventory = User:getCharacter():getInventory()

		sort = math.random(1,2)

		if medic or police then
			--if ReviveEnable then
				TriggerClientEvent('VP:MEDIC:revivecheck', _source)
			--else
   			--	TriggerClientEvent('VP:NOTIFY:Simple', _source, 'Esta pessoa já está morta.', 5000)
			--end
		end
    end
)

RegisterCommand(
    "tratar",
    function(source, args, rawCommand)
        local _source = source
        local User = API.getUserFromSource(source)
		local Character = User:getCharacter()
		local medic = Character:hasGroupOrInheritance("medic")
		local Inventory = User:getCharacter():getInventory()

		if medic then
			TriggerClientEvent('VP:MEDIC:TreatmentCheck', _source)
		end		
    end
)

RegisterServerEvent('VP:MEDIC:checkcallback')
AddEventHandler('VP:MEDIC:checkcallback', function(target)
	TriggerClientEvent('VP:RESPAWN:CheckDeath', target)
end)

RegisterServerEvent('VP:MEDIC:TreatmentCallback')
AddEventHandler('VP:MEDIC:TreatmentCallback', function(target)
	TriggerClientEvent('VP:RESPAWN:Treatment', target)
	ReviveEnable = false
end)

RegisterServerEvent('VP:MEDIC:revivecallback')
AddEventHandler('VP:MEDIC:revivecallback', function(target)
	TriggerEvent('VP:MEDIC:revive', source, target)
	ReviveEnable = false
end)

RegisterServerEvent('VP:MEDIC:StatusDeath')
AddEventHandler('VP:MEDIC:StatusDeath', function(target, data)
	TriggerEvent('VP:MEDIC:ReceiveStatus', target, data)
end)

RegisterServerEvent('VP:MEDIC:ReceiveStatus')
AddEventHandler('VP:MEDIC:ReceiveStatus', function(target, data)
	print(json.encode(data))
	if data[2] ~= nil then
		if data[2] then					
			TriggerClientEvent('VP:NOTIFY:Simple', target, 'Esta pessoa falaceu.', 5000)
			ReviveEnable = false
			return
		else
			TriggerClientEvent('VP:NOTIFY:Simple', target, 'Esta pessoa está com batimentos.', 5000)
			ReviveEnable = true	
		end
	else
		TriggerClientEvent('VP:NOTIFY:Simple', target, 'Não identificado a causa da morte.', 5000)
		ReviveEnable = false
	end	
	--TriggerClientEvent('VP:MEDIC:ReceiveStatus', target, data)
end)


RegisterServerEvent('VP:MEDIC:revive')
AddEventHandler('VP:MEDIC:revive', function(source, target)	
	local _source = source
	local User = API.getUserFromSource(_source)
	local Character = User:getCharacter()
	local Inventory = User:getCharacter():getInventory()	

	if sort == 1 and ReviveEnable == false then
		ReviveEnable = true
		print('na sorte')
	end

	if ReviveEnable then
		TriggerClientEvent('VP:MEDIC:revive', _source)
		Wait(10000)
		TriggerClientEvent('VP:RESPAWN:PlayerUp', target)
		Character:varyExp(10)
		Inventory:addItem('money', 500)	
		TriggerClientEvent('VP:NOTIFY:Simple', _source, 'Reanimado com sucesso.', 5000)
		print('Reanimado com sucesso.')
	else
		TriggerClientEvent('VP:MEDIC:revive', _source)
		Wait(10000)
	--	TriggerClientEvent('VP:RESPAWN:PlayerUp', target)
		TriggerClientEvent('VP:NOTIFY:Simple', _source, 'Infelizmente faleceu.', 5000)
	end
end)



