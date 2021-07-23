local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local robberyTimer = 0
local cops = 0
local copsIds = {}

RegisterServerEvent("FRP:ROBREG:checkTheRobbery")
AddEventHandler(
	"FRP:ROBREG:checkTheRobbery",
	function(atmInfo)
		local atmInfo = atmInfo
		--
		local User = API.getUserFromSource(source)
		local Character = User:getCharacter()
		local Inventory = Character:getInventory()

		local PoliceON = API.getUsersByGroup("trooper")

		-- local xPlayers = GetPlayers()

		-- for i=1, #xPlayers, 1 do
		-- 	local UserCheck = API.getUserFromSource(tonumber(xPlayers[i]))
		-- 	local CharacterCheck = UserCheck:getCharacter()
		-- 	if CharacterCheck:hasGroupOrInheritance('trooper') then
		-- 		cops = math.floor(cops + 1)
		-- 		copsIds[i] = xPlayers[i]
		-- 	end
		-- end

		if #PoliceON < Config.copsRequired then
			TriggerClientEvent("FRP:NOTIFY:Simple", source, "Esta loja não pode ser roubada, não há policiais disponíveis.", 10000)
		elseif (os.time() - Config.ATMS[atmInfo[1]]["wasRobbed"]) <= Config.robberyInterval then
			--	TriggerClientEvent('Notify', source, 'negado',  Locales[Config.Locale]['empty_atm'] .. timeInterval .. timeUnit )
			local timeInterval = Config.robberyInterval - (os.time() - Config.ATMS[atmInfo[1]]["wasRobbed"])
			local timeUnit

			if math.floor(timeInterval / 60) < 1 then
				timeUnit = "s"
			else
				timeInterval = math.floor(timeInterval / 60)
				timeUnit = "m"
			end

			print(timeInterval)

			TriggerClientEvent("FRP:NOTIFY:Simple", source, "Este caixa está vazio, aguarde " .. timeInterval .. timeUnit, 10000)
		else
			--TriggerClientEvent('FRP:ROBREG:PlayAlarm', source, atmInfo[2], atmInfo[3], atmInfo[4])
			-- local faca = Inventory:getItemAmount("melee_knife")
			-- if faca < 1 then
			-- 	TriggerClientEvent('FRP:NOTIFY:Simple', source, "Você não pussi uma faca.", 10000)
			-- 	return
			-- end
			Config.ATMS[atmInfo[1]]["wasRobbed"] = os.time()

			TriggerClientEvent("FRP:ROBREG:startTheRobbery", source, atmInfo)

			for i = 1, #PoliceON do
				TriggerClientEvent("FRP:ROBREG:warnThePolice", PoliceON[i].getSource(), atmInfo[2], atmInfo[3], atmInfo[4])
			end
		end
	end
)

RegisterServerEvent("FRP:ROBREG:finishedTheRobbery")
AddEventHandler(
	"FRP:ROBREG:finishedTheRobbery",
	function(money)
		-- for k,v in pairs(copsIds) do
		-- 	local copPlayer = GetPlayerIdentifier(tonumber(v), 0)

		-- 	if copPlayer then
		-- 		local playerId = tonumber(v)
		-- 		TriggerClientEvent('FRP:ROBREG:removeRobBlip', -1)

		-- 	--	TriggerClientEvent('chatMessage', playerId, _U('police_title'), Config.policeColor, _U('police_warning_finished'))
		-- --		TriggerClientEvent('Police', playerId, 'importante2', _U('police_warning_finished'))
		-- 	end
		-- end
		--TriggerClientEvent('FRP:ROBREG:removeRobBlip', -1)
		TriggerClientEvent("FRP:ROBREG:cancelfreeze", source)
		TriggerClientEvent("FRP:NOTIFY:Simple", source, "Você roubou " .. money .. ".", 10000)

		local User = API.getUserFromSource(source)

		if User then
			TriggerEvent("FRP:COMBATLOG:AddUserCombatReason", User:getId(), 300, "Roubo a Registradora")
		end

		--	TriggerClientEvent('Notify', source, 'importante',  Locales[Config.Locale]['robbery_stolen_warning']  )
		--	TriggerClientEvent('esx:showNotification', source, string.format( Locales[Config.Locale]['robbery_stolen_warning'], money ) )
	end
)

RegisterServerEvent("FRP:ROBREG:cancelTheRobbery")
AddEventHandler(
	"FRP:ROBREG:cancelTheRobbery",
	function(money)
		-- for k,v in pairs(copsIds) do
		-- 	local copPlayer = GetPlayerIdentifier(tonumber(v), 0)
		-- 	if copPlayer then
		-- 		local playerId = tonumber(v)
		-- 		TriggerClientEvent('FRP:ROBREG:removeRobBlip', playerId)
		-- 		--TriggerClientEvent('chatMessage', playerId, _U('police_title'), Config.policeColor, _U('police_warning_cancelled'))
		-- 		TriggerClientEvent('Police', playerId, 'importante2', _U('police_warning_cancelled'))
		-- 	end
		-- end

		TriggerClientEvent("FRP:ROBREG:cancelfreeze", source)
		TriggerClientEvent("FRP:NOTIFY:Simple", source, "O roubo foi cancelado, você conseguiu apenas $ " .. money .. ".", 10000)

		--	TriggerClientEvent('Notify', source, 'negado',  Locales[Config.Locale]['robbery_stolen_cancel'] ..money )
		--TriggerClientEvent('esx:showNotification', source, string.format( Locales[Config.Locale]['robbery_stolen_cancel'], money ))

		local User = API.getUserFromSource(source)

		if User then
			TriggerEvent("FRP:COMBATLOG:AddUserCombatReason", User:getId(), 300, "Roubo a Registradora")
		end
	end
)

RegisterServerEvent("FRP:ROBREG:giveRobbedMoney")
AddEventHandler(
	"FRP:ROBREG:giveRobbedMoney",
	function(money)
		local User = API.getUserFromSource(source)
		local Character = User:getCharacter()
		local Inventory = Character:getInventory()
		Inventory:addItem("money", money * 100)
	end
)
