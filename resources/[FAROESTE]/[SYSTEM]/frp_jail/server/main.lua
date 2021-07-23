local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterCommand(
    "jail",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
		local Character = User:getCharacter()
		if Character:hasGroup("police") or Character:hasGroup("admin") and args[1] then
			if args[1] then				
				print(API.getUserFromUserId(tonumber(args[1])):getSource())
                TriggerEvent('VP:JAIL:sendToJail', API.getUserFromUserId(tonumber(args[1])):getSource(), tonumber(args[2] * 60))
            end
        end
    end
)

RegisterCommand(
    "unjail",
    function(source, args, rawCommand)
        local User = API.getUserFromSource(source)
		local Character = User:getCharacter()
		if Character:hasGroup("police") or Character:hasGroup("admin") and args[1] then
			if args[1] then
				TriggerEvent('VP:JAIL:unjailQuest', API.getUserFromUserId(tonumber(args[1])):getSource())
            end
        end
    end
)

-- send to jail and register in database
RegisterServerEvent('VP:JAIL:sendToJail')
AddEventHandler('VP:JAIL:sendToJail', function(target, jailTime)
	local User = API.getUserFromSource(target)
	
	local Character = User:getCharacter()
	local nome = Character:getName()

	TriggerClientEvent('VP:JAIL:jail', User, jailTime)

	local check = Character:getJail(Character:getId())

	if check == '' then	
		Character:setJail(Character:getId(), jailTime)
		TriggerClientEvent('VP:JAIL:jail', User, tonumber(jailTime))
	else
		Character:updJail(Character:getId(), jailTime)
		TriggerClientEvent('VP:JAIL:jail', User, json.encode(check[1].jail_time))
	end

	print(nome .. ' foi preso por ' .. jailTime)
end)


-- should the player be in jail?
RegisterServerEvent('VP:JAIL:checkJail')
AddEventHandler('VP:JAIL:checkJail', function()
	local _source = source
	local User = API.getUserFromSource(_source)
	local Character = User:getCharacter()

	if Character == nil then
		return
	end
	
	local nome = Character:getName()
	local check = Character:getJail(Character:getId())

	
	if check ~= '' then		
		TriggerClientEvent('VP:JAIL:jail', _source, tonumber(check[1].jail_time))
	end
	
end) 

-- unjail via command
RegisterServerEvent('VP:JAIL:unjailQuest')
AddEventHandler('VP:JAIL:unjailQuest', function(source)
	if source ~= nil then
		unjail(source)
	end
end)

-- unjail after time served
RegisterServerEvent('VP:JAIL:unjailTime')
AddEventHandler('VP:JAIL:unjailTime', function()
	unjail(source)
end)


RegisterServerEvent('VP:JAIL:updateRemaining')
AddEventHandler('VP:JAIL:updateRemaining', function(jailTime)
	local _source = source
	local User = API.getUserFromSource(_source)
	local Character = User:getCharacter()	
	local nome = Character:getName()

	Character:updJail(Character:getId(), jailTime)
end)



function unjail(target)
	local _source = target
	local User = API.getUserFromSource(_source)
	local Character = User:getCharacter()	
	local nome = Character:getName()

	Character:remJail(Character:getId())
	
--	TriggerClientEvent('chat:addMessage', -1, { args = { _U('judge'), _U('unjailed', GetPlayerName(target)) }, color = { 147, 196, 109 } })

	cAPI.SetPedModel(User:getSource(), json.decode(Character:getModel()))
	Wait(1000)
	cAPI.setDados(User:getSource(), Character:getmetaData())
	Wait(500)                
	cAPI.SetPedClothinges(User:getSource(), Character:getClothes())

	TriggerClientEvent('VP:JAIL:unjail', target)

	print(nome .. ' foi solto por ')
end
