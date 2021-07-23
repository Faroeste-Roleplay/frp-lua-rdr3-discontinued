local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

-- RegisterServerEvent('VP:SHERIFF:checkjob')
-- AddEventHandler('VP:SHERIFF:checkjob', function()
-- 	local _source = source
-- 	local User = API.getUserFromSource(_source)
-- 	local Character = User:getCharacter()
-- 	local job = Character:hasGroupOrInheritance('trooper')

-- 	if job then

-- 	else
-- 		TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um oficial')
-- 	end
-- end)

RegisterServerEvent("VP:SHERIFF:checkjob")
AddEventHandler(
	"VP:SHERIFF:checkjob",
	function()
		local _source = source
		local User = API.getUserFromSource(_source)
		local Character = User:getCharacter()

		if Character == nil then
			return
		end

		local trooper = Character:hasGroupOrInheritance("trooper")
		local sheriff = Character:hasGroupOrInheritance("sheriff")

		if trooper then
			TriggerClientEvent("VP:SHERIFF:trooperCheck", _source, trooper)
		end
		if sheriff then
			TriggerClientEvent("VP:SHERIFF:SheriffCheck", _source, sheriff)
		end
	end
)

RegisterServerEvent("VP:SHERIFF:soltar")
AddEventHandler(
	"VP:SHERIFF:soltar",
	function()
		local _source = source
		local User = API.getUserFromSource(_source)
		local Character = User:getCharacter()
		local trooperjob = Character:hasGroupOrInheritance("trooper")

		--TriggerClientEvent('VP:SHERIFF:result', _source, trooperjob)

		local trooperjob = Character:hasGroupOrInheritance("trooper")
		if trooperjob == false then
			TriggerEvent("VP:SHERIFF:soltar", target)
		else
			TriggerClientEvent("chatMessage", source, "SISTEMA", {255, 255, 255}, "Você não é um oficial")
		end
	end
)

RegisterCommand('wanted', 
    function(source, args, rawCommand)
    if args[1] ~= nil then        

    end
end)


 RegisterCommand('wanted', function(source, args)
 	local _source = source
 	local User = API.getUserFromSource(source)
 	local Character = User:getCharacter()		 
 		local trooperjob = Character:hasGroupOrInheritance('sheriff')
 		if trooperjob == true then
 			if args[1] ~= nil then
 				TriggerClientEvent('VP:WANTED:RewardClient', _source, args[1], args[2])
 			end
 		else
 			TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um oficial')
		end	
 end)



RegisterCommand(
	"colocar",
	function(source)
		local source = source
		TriggerEvent(
			"redemrp:getPlayerFromId",
			source,
			function(user)
				local trooperjob = user.getJob()
				--	if trooperjob == 'trooper' then
				TriggerClientEvent("VP:SHERIFF:playercheck", source)
				--xPlayer.removeInventoryItem('handcuffs', 1)
				--	else
				--	 TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um oficial')
				--	end
			end
		)
	end
)

RegisterServerEvent("VP:SHERIFF:puting")
AddEventHandler(
	"VP:SHERIFF:puting",
	function(target)
		TriggerClientEvent("VP:SHERIFF:vehiclep", target)
		--TriggerClientEvent("ic_sound:source",target,'cuff',0.1)
		-- TriggerClientEvent("ic_sound:source",source,'cuff',0.1)
	end
)

RegisterServerEvent("VP:SHERIFF:outing")
AddEventHandler(
	"VP:SHERIFF:outing",
	function(target)
		TriggerClientEvent("VP:SHERIFF:vehicleout", target)
	end
)

RegisterServerEvent("VP:SHERIFF:putInVehicle")
AddEventHandler(
	"VP:SHERIFF:putInVehicle",
	function(target)
		local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.job.name == "trooper" then
		else
			print(("VP:SHERIFF: %s attempted to put in vehicle (not cop)!"):format(xPlayer.identifier))
		end
	end
)

RegisterCommand(
	"testservjob",
	function(source)
		TriggerEvent("VP:SHERIFF:checkjob", source)
	end
)

RegisterServerEvent("VP:SHERIFF:cuffing")
AddEventHandler(
	"VP:SHERIFF:cuffing",
	function(target)
		local _source = source
		TriggerClientEvent("VP:SHERIFF:cuff", target)
		--TriggerClientEvent("ic_sound:source",target,'cuff',0.1)
		--TriggerClientEvent("ic_sound:source",source,'cuff',0.1)
	end
)

-- RegisterServerEvent("VP:SHERIFF:unlocking")
-- AddEventHandler(
-- 	"VP:SHERIFF:unlocking",
-- 	function(source)
-- 		TriggerClientEvent("VP:SHERIFF:uncuff", source)
-- 	end
-- )

RegisterServerEvent("VP:SHERIFF:soltar")
AddEventHandler(
	"VP:SHERIFF:soltar",
	function(target)
		TriggerClientEvent("VP:SHERIFF:nyckelcheck", target)
	end
)


RegisterServerEvent("VP:SHERIFF:unlocking")
AddEventHandler(
	"VP:SHERIFF:unlocking",
	function(target)
		local _source = source
		TriggerClientEvent("VP:SHERIFF:uncuff", target)
		TriggerClientEvent("ic_sound:source", target, "uncuff", 0.1)
	end
)

RegisterNetEvent("VP:SHERIFF:TryToPatDown")
AddEventHandler(
	"VP:SHERIFF:TryToPatDown",
	function(playerToPatdown)

		if playerToPatdown == nil then
			return
		end

		local _source = source
		local User = API.getUserFromSource(_source)
		local Character = User:getCharacter()

		if Character == nil then
			return
		end

		-- if Character:hasGroupOrInheritance("trooper") then
		-- end

		local UserTarget = API.getUserFromSource(playerToPatdown)

		if UserTarget == nil then
			return
		end

		local CharacterTarget = UserTarget:getCharacter()

		if CharacterTarget == nil then
			return
		end

		local InventoryTarget = CharacterTarget:getInventory()

		User:viewInventory()
		User:viewInventoryAsSecondary(InventoryTarget)

		UserTarget:notify('alert', 'Você está sendo revistado!')
	end
)

 RegisterCommand('prender', function(source)
 	local _source = source
 	local User = API.getUserFromSource(source)
 	local Character = User:getCharacter()

		 handcuffs = false
		 
 		local trooperjob = Character:hasGroupOrInheritance('trooper')
 		if trooperjob == true then
 			TriggerClientEvent('VP:SHERIFF:cuffcheck', source)
 			handcuffs = true
 		else
 			TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um oficial')
		 end
		 
 		if handcuffs == true then
 			TriggerEvent('VP:SHERIFF:prender', target)
 		end
 end)

 
RegisterCommand(
	"soltar",
	function(source)
		local _source = source
		local User = API.getUserFromSource(source)
		local Character = User:getCharacter()
		
		local trooperjob = Character:hasGroupOrInheritance('trooper')
		if trooperjob == true then
			TriggerClientEvent("VP:SHERIFF:nyckelcheck", source)			
			handcuffs = true
		else
			TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um oficial')
		end



	end
)


 
RegisterCommand(
	"pv",
	function(source)

		local _source = source
		local User = API.getUserFromSource(source)
		local Character = User:getCharacter()
		
		local trooperjob = Character:hasGroupOrInheritance('trooper')
		if trooperjob == true then			
			TriggerClientEvent("VP:SHERIFF:putinvehicle", source)
		else
			TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um oficial')
		end
	end
)

RegisterCommand(
	"rv",
	function(source)
		local _source = source
		local User = API.getUserFromSource(source)
		local Character = User:getCharacter()
		
		local trooperjob = Character:hasGroupOrInheritance('trooper')
		if trooperjob == true then			
			TriggerClientEvent("VP:SHERIFF:outvehicle", source)
		else
			TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um oficial')
		end
	end
)


-- RegisterServerEvent('VP:SHERIFF:checkjob')
-- AddEventHandler('VP:SHERIFF:checkjob', function(source, playerjob)
-- local _source = source

-- TriggerEvent("redemrp:getPlayerFromId", _source, function(user)

-- 	playerjob = user.getJob()

-- 	TriggerClientEvent('VP:SHERIFF:checkjob', _source, playerjob)
-- 	end)
-- end)

-- RegisterServerEvent('VP:SHERIFF:soltar')
-- AddEventHandler('VP:SHERIFF:prender', function(target)
-- 	TriggerClientEvent('VP:SHERIFF:nyckelcheck', target)
-- end)

-- RegisterCommand('soltar', function(target)

-- 	TriggerClientEvent('VP:SHERIFF:nyckelcheck', target)
-- 	--xPlayer.removeInventoryItem('handcuffs', 1)
-- end)

-- RegisterServerEvent('VP:SHERIFF:remove')
-- AddEventHandler('VP:SHERIFF:remove', function()
-- 	local _source = source
-- 	TriggerEvent("redemrp:getPlayerFromId", _source, function(user)
-- 	--xPlayer.removeInventoryItem('handcuffs', 1)
-- end)
-- end)

-- RegisterServerEvent('VP:SHERIFF:give')
-- AddEventHandler('VP:SHERIFF:give', function()
-- 	local _source = source
-- 	TriggerEvent("redemrp:getPlayerFromId", _source, function(user)
-- 	--xPlayer.addInventoryItem('handcuffs', 1)
-- end)
-- end)

--  --[[
-- ESX.RegisterUsableItem('key', function(target)
--     TriggerClientEvent('VP:SHERIFF:nyckelcheck', target)
--     --TriggerClientEvent("ic_sound:source",target,'uncuff',0.1)
--  --   TriggerClientEvent("ic_sound:source",target,'uncuff',0.1)

-- end)]]

-- --[[
-- ESX.RegisterUsableItem('blowpipe', function(source)
-- 	local xPlayer = ESX.GetPlayerFromId(target)
-- 	TriggerClientEvent('VP:SHERIFF:unlockingcuffs', source)
-- 	xPlayer.removeInventoryItem('blowpipe', 1)
-- end) ]]

-- RegisterServerEvent('dragServer')
-- AddEventHandler('dragServer', function(closestID)
-- 	local _source = source
-- 	TriggerEvent("redemrp:getPlayerFromId", _source, function(user)
-- 		if user.getGroup() == "admin" then
-- 			TriggerClientEvent('dragClient', closestID, source)
-- 		end
-- 	end)
-- end)

-- RegisterServerEvent('unDragServer')
-- AddEventHandler('unDragServer', function(closestID)
-- 	local _source = source
-- 	TriggerEvent("redemrp:getPlayerFromId", _source, function(user)
-- 		if user.getGroup() == "admin" then
-- 			TriggerClientEvent('unDragClient', closestID)
-- 		end
-- 	end)
-- end)

-- RegisterServerEvent('putInServer')
-- AddEventHandler('putInServer', function(closestID)
-- 	local _source = source
-- 	TriggerEvent("redemrp:getPlayerFromId", _source, function(user)
-- 		if user.getGroup() == "admin" then
-- 			TriggerClientEvent('putInClient', closestID)
-- 		end
-- 	end)
-- end)
