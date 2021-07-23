local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

-- RegisterServerEvent('FRP:SHERIFF:checkjob')
-- AddEventHandler('FRP:SHERIFF:checkjob', function()
-- 	local _source = source
-- 	local User = API.getUserFromSource(_source)
-- 	local Character = User:getCharacter()
-- 	local job = Character:hasGroupOrInheritance('trooper')

-- 	if job then

-- 	else
-- 		TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um oficial')
-- 	end
-- end)

RegisterServerEvent("FRP:SHERIFF:checkjob")
AddEventHandler(
	"FRP:SHERIFF:checkjob",
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
			TriggerClientEvent("FRP:SHERIFF:trooperCheck", _source, trooper)
		end
		if sheriff then
			TriggerClientEvent("FRP:SHERIFF:SheriffCheck", _source, sheriff)
		end
	end
)

RegisterServerEvent("FRP:SHERIFF:soltar")
AddEventHandler(
	"FRP:SHERIFF:soltar",
	function()
		local _source = source
		local User = API.getUserFromSource(_source)
		local Character = User:getCharacter()
		local trooperjob = Character:hasGroupOrInheritance("trooper")

		--TriggerClientEvent('FRP:SHERIFF:result', _source, trooperjob)

		local trooperjob = Character:hasGroupOrInheritance("trooper")
		if trooperjob == false then
			TriggerEvent("FRP:SHERIFF:soltar", target)
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
 				TriggerClientEvent('FRP:WANTED:RewardClient', _source, args[1], args[2])
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
				TriggerClientEvent("FRP:SHERIFF:playercheck", source)
				--xPlayer.removeInventoryItem('handcuffs', 1)
				--	else
				--	 TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um oficial')
				--	end
			end
		)
	end
)

RegisterServerEvent("FRP:SHERIFF:puting")
AddEventHandler(
	"FRP:SHERIFF:puting",
	function(target)
		TriggerClientEvent("FRP:SHERIFF:vehiclep", target)
		--TriggerClientEvent("ic_sound:source",target,'cuff',0.1)
		-- TriggerClientEvent("ic_sound:source",source,'cuff',0.1)
	end
)

RegisterServerEvent("FRP:SHERIFF:outing")
AddEventHandler(
	"FRP:SHERIFF:outing",
	function(target)
		TriggerClientEvent("FRP:SHERIFF:vehicleout", target)
	end
)

RegisterServerEvent("FRP:SHERIFF:putInVehicle")
AddEventHandler(
	"FRP:SHERIFF:putInVehicle",
	function(target)
		local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.job.name == "trooper" then
		else
			print(("FRP:SHERIFF: %s attempted to put in vehicle (not cop)!"):format(xPlayer.identifier))
		end
	end
)

RegisterCommand(
	"testservjob",
	function(source)
		TriggerEvent("FRP:SHERIFF:checkjob", source)
	end
)

RegisterServerEvent("FRP:SHERIFF:cuffing")
AddEventHandler(
	"FRP:SHERIFF:cuffing",
	function(target)
		local _source = source
		TriggerClientEvent("FRP:SHERIFF:cuff", target)
		--TriggerClientEvent("ic_sound:source",target,'cuff',0.1)
		--TriggerClientEvent("ic_sound:source",source,'cuff',0.1)
	end
)

-- RegisterServerEvent("FRP:SHERIFF:unlocking")
-- AddEventHandler(
-- 	"FRP:SHERIFF:unlocking",
-- 	function(source)
-- 		TriggerClientEvent("FRP:SHERIFF:uncuff", source)
-- 	end
-- )

RegisterServerEvent("FRP:SHERIFF:soltar")
AddEventHandler(
	"FRP:SHERIFF:soltar",
	function(target)
		TriggerClientEvent("FRP:SHERIFF:nyckelcheck", target)
	end
)


RegisterServerEvent("FRP:SHERIFF:unlocking")
AddEventHandler(
	"FRP:SHERIFF:unlocking",
	function(target)
		local _source = source
		TriggerClientEvent("FRP:SHERIFF:uncuff", target)
		TriggerClientEvent("ic_sound:source", target, "uncuff", 0.1)
	end
)

RegisterNetEvent("FRP:SHERIFF:TryToPatDown")
AddEventHandler(
	"FRP:SHERIFF:TryToPatDown",
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
 			TriggerClientEvent('FRP:SHERIFF:cuffcheck', source)
 			handcuffs = true
 		else
 			TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um oficial')
		 end
		 
 		if handcuffs == true then
 			TriggerEvent('FRP:SHERIFF:prender', target)
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
			TriggerClientEvent("FRP:SHERIFF:nyckelcheck", source)			
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
			TriggerClientEvent("FRP:SHERIFF:putinvehicle", source)
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
			TriggerClientEvent("FRP:SHERIFF:outvehicle", source)
		else
			TriggerClientEvent('chatMessage', source, 'SISTEMA', {255, 255, 255}, 'Você não é um oficial')
		end
	end
)


-- RegisterServerEvent('FRP:SHERIFF:checkjob')
-- AddEventHandler('FRP:SHERIFF:checkjob', function(source, playerjob)
-- local _source = source

-- TriggerEvent("redemrp:getPlayerFromId", _source, function(user)

-- 	playerjob = user.getJob()

-- 	TriggerClientEvent('FRP:SHERIFF:checkjob', _source, playerjob)
-- 	end)
-- end)

-- RegisterServerEvent('FRP:SHERIFF:soltar')
-- AddEventHandler('FRP:SHERIFF:prender', function(target)
-- 	TriggerClientEvent('FRP:SHERIFF:nyckelcheck', target)
-- end)

-- RegisterCommand('soltar', function(target)

-- 	TriggerClientEvent('FRP:SHERIFF:nyckelcheck', target)
-- 	--xPlayer.removeInventoryItem('handcuffs', 1)
-- end)

-- RegisterServerEvent('FRP:SHERIFF:remove')
-- AddEventHandler('FRP:SHERIFF:remove', function()
-- 	local _source = source
-- 	TriggerEvent("redemrp:getPlayerFromId", _source, function(user)
-- 	--xPlayer.removeInventoryItem('handcuffs', 1)
-- end)
-- end)

-- RegisterServerEvent('FRP:SHERIFF:give')
-- AddEventHandler('FRP:SHERIFF:give', function()
-- 	local _source = source
-- 	TriggerEvent("redemrp:getPlayerFromId", _source, function(user)
-- 	--xPlayer.addInventoryItem('handcuffs', 1)
-- end)
-- end)

--  --[[
-- ESX.RegisterUsableItem('key', function(target)
--     TriggerClientEvent('FRP:SHERIFF:nyckelcheck', target)
--     --TriggerClientEvent("ic_sound:source",target,'uncuff',0.1)
--  --   TriggerClientEvent("ic_sound:source",target,'uncuff',0.1)

-- end)]]

-- --[[
-- ESX.RegisterUsableItem('blowpipe', function(source)
-- 	local xPlayer = ESX.GetPlayerFromId(target)
-- 	TriggerClientEvent('FRP:SHERIFF:unlockingcuffs', source)
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
