local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local spawncoords
local head
-- /////////////// MENU DO DEPARTAMENTO
Citizen.CreateThread(
	function()
		WarMenu.CreateMenu("DpOfficerMenu", "Departamento")
		WarMenu.SetSubTitle("DpOfficerMenu", "Opções")
		WarMenu.CreateSubMenu("vehicle", "DpOfficerMenu", "Transporte.")

		while true do
			Citizen.Wait(0)
			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)

			if cAPI.hasGroupOrInheritance("trooper") or cAPI.hasGroupOrInheritance("sheriff") then
				for k, v in pairs(Config.Coords.Vehicles) do
					if #(coords - vector3(v.Spawner.x, v.Spawner.y, v.Spawner.z)) < 3.0 then
						if not IsPedInAnyVehicle(PlayerPedId(), true) then
							DrawTxt("Aperte (ALT) para pegar uma carroça", 0.85, 0.95, 0.4, 0.4, true, 255, 255, 255, 255, true, 10000)
							if IsControlJustPressed(0, 0xE8342FF2) then
								WarMenu.OpenMenu("DpOfficerMenu")
								spawncoords = vector3(v.Spawner.x, v.Spawner.y, v.Spawner.z)
								head = v.Spawner.h
							end
						end
					end
				end
				for k, v in pairs(Config.Coords.Vehicles) do
					if #(coords - vector3(v.DV.x, v.DV.y, v.DV.z)) < 5.0 then
						if IsPedInAnyVehicle(PlayerPedId(), true) then
							DrawTxt("Aperte (ALT) para GUARGAR a carroça", 0.85, 0.95, 0.4, 0.4, true, 255, 255, 255, 255, true, 10000)
							if IsControlJustPressed(0, 0xE8342FF2) then -- Hold ALT
								DeleteVehicle(GetVehiclePedIsIn(PlayerPedId(), false))
							end
						end
					end
				end
			end

			if WarMenu.IsMenuOpened("DpOfficerMenu") then
				if WarMenu.MenuButton("Transportes", "vehicle") then
				end
				WarMenu.Display()
			elseif WarMenu.IsMenuOpened("vehicle") then
				if WarMenu.Button("Carroça 2") then
					print(spawncoords, head)
					SpawnVehicle("POLICEWAGON01X", spawncoords, head)
				elseif WarMenu.Button("Carroça Cela") then
					SpawnVehicle("WAGONPRISON01X", spawncoords, head)
				elseif WarMenu.Button("Carrça Carga") then
					SpawnVehicle("supplywagon", spawncoords, head)
				end
				WarMenu.Display()
			end
		end
	end
)

function SpawnVehicle(Vmodel, coords, head)
	local veh = GetHashKey(Vmodel)
	Citizen.CreateThread(
		function()
			RequestModel(veh)

			while not HasModelLoaded(veh) do
				Wait(1000)
				print("Loading Model: " .. Vmodel .. "Loading Hash: " .. veh)
			end
			if HasModelLoaded(veh) then
				local car = CreateVehicle(veh, coords, head, true, true, false, true)
				print("Model spawned Succes: " .. Vmodel)
			end
		end
	)
end

-- local prompt_patdown

-- local lastTargetPlayerServerId

-- function pp()
-- 	prompt_patdown = PromptRegisterBegin()
-- 	PromptSetControlAction(prompt_patdown, 0x05CA7C52)
-- 	PromptSetText(prompt_patdown, CreateVarString(10, "LITERAL_STRING", "Revistar"))
-- 	PromptSetEnabled(prompt_patdown, true)
-- 	PromptSetVisible(prompt_patdown, false)
-- 	PromptSetHoldMode(prompt_patdown, true)
-- 	PromptSetGroup(prompt_patdown, PlayerPedId())
-- 	PromptRegisterEnd(prompt_patdown)
-- end

-- function HandlePrompts()
-- 	if PromptHasHoldModeCompleted(prompt_patdown) and lastTargetPlayerServerId ~= nil then
-- 		PromptSetEnabled(prompt_patdown, false)
-- 		Citizen.CreateThread(
-- 			function()
-- 				Citizen.Wait(1000)
-- 				PromptSetEnabled(prompt_patdown, true)
-- 			end
-- 		)
-- 		TriggerServerEvent("FRP:SHERIFF:TryToPatDown", lastTargetPlayerServerId)
-- 	end
-- end

-- function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
-- 	local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
-- 	SetTextScale(w, h)
-- 	SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
-- 	SetTextCentre(centre)
-- 	if enableShadow then
-- 		SetTextDropshadow(1, 0, 0, 0, 255)
-- 	end
-- 	Citizen.InvokeNative(0xADA9255D, 10)
-- 	DisplayText(str, x, y)
-- end

-- Citizen.CreateThread(
-- 	function()
-- 		pp()
-- 		while true do
-- 			Citizen.Wait(0)
-- 			local y, entity = GetPlayerTargetEntity(PlayerId())

-- 			local foundPlayer = false

-- 			if entity ~= 0 then
-- 				for _, pid in pairs(GetActivePlayers()) do
-- 					if NetworkIsPlayerActive(pid) then
-- 						foundPlayer = true

-- 						local pped = GetPlayerPed(pid)
-- 						if entity == pped then
-- 							local serverId = GetPlayerServerId(pid)
-- 							if lastTargetPlayerServerId == nil or lastTargetPlayerServerId ~= serverId then
-- 								lastTargetPlayerServerId = serverId

-- 								PromptSetVisible(prompt_patdown, true)
-- 								PromptSetGroup(prompt_patdown, PromptGetGroupIdForTargetEntity(entity))

-- 								local pPosition = GetEntityCoords(PlayerPedId())
-- 								local tPosition = GetEntityCoords(pped)

-- 								local dist = #(pPosition - tPosition)
-- 								if dist <= 1.5 and (cAPI.hasGroupOrInheritance("trooper") or IsEntityPlayingAnim(pped, "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs", "handsup_register_owner", 3)) then
-- 									PromptSetEnabled(prompt_patdown, true)
-- 								else
-- 									PromptSetEnabled(prompt_patdown, false)
-- 								end

-- 								break
-- 							end
-- 						end
-- 					end
-- 				end

-- 				if foundPlayer then
-- 					HandlePrompts()
-- 				end
-- 			end
-- 			if foundPlayer == false then
-- 				lastTargetPlayerServerId = nil
-- 				PromptSetVisible(prompt_patdown, false)
-- 			end
-- 		end
-- 	end
-- )

--[[ /////////////// MENU DO OFICIAL
Citizen.CreateThread(
	function()
		WarMenu.CreateMenu("OfficerMenu", "Menu do Oficial")
		WarMenu.SetSubTitle("OfficerMenu", "Opções")
		WarMenu.CreateSubMenu("citizen", "OfficerMenu", "Interação Cidadão")
		WarMenu.CreateSubMenu("vehiclec", "OfficerMenu", "Interação Veiculo")
		
		while true do
			Citizen.Wait(0)
			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)
			if WarMenu.IsMenuOpened("OfficerMenu") then
				if WarMenu.MenuButton("Interação Cidadão", "citizen") then
				end
				if WarMenu.MenuButton("Interação Veiculo", "vehiclec") then
				end
				if PoliceCheck then
					if WarMenu.Button("Anunciar Procurado") then
					-- FUNCTION HERE
					end
				end
				WarMenu.Display()
			elseif WarMenu.IsMenuOpened("citizen") then
				if WarMenu.Button("Algemar") then
					TriggerEvent("FRP:SHERIFF:cuffcheck")
				elseif WarMenu.Button("Soltar") then
					TriggerServerEvent("FRP:SHERIFF:soltar")
				elseif WarMenu.Button("Colocar no veículo") then
					TriggerEvent("FRP:SHERIFF:putinvehicle")
				elseif WarMenu.Button("Tirar do veículo") then
					TriggerEvent("FRP:SHERIFF:outvehicle")
				elseif WarMenu.Button("Multar") then
				--	FUNCTION HERE
				end
				WarMenu.Display()
			elseif WarMenu.IsMenuOpened("vehiclec") then
				if WarMenu.Button("Revistar") then
					--	FUNCTION HERE
				elseif WarMenu.Button("Multar") then
				--	FUNCTION HERE
				end
				WarMenu.Display()
			end
		end
	end
) ]]
-- RegisterNetEvent("FRP:SHERIFF:giveweapon")
-- AddEventHandler(
-- 	"FRP:SHERIFF:giveweapon",
-- 	function(weapon)
-- 		Citizen.CreateThread(
-- 			function()
-- 				local weapon = GetHashKey(weapon)
-- 				local playerPed = PlayerPedId()
-- 				Wait(1000)
-- 				GiveDelayedWeaponToPed(playerPed, weapon, 100, true, 2)
-- 			end
-- 		)
-- 	end
-- )

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
	local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
	SetTextScale(w, h)
	SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
	if enableShadow then
		SetTextDropshadow(1, 0, 0, 0, 255)
	end
	Citizen.InvokeNative(0xADA9255D, 10)
	DisplayText(str, x, y)
end

-- Variables
local handcuffed = false
local officer = -1
local id = "This user did not set their ID!"

------------------------------------------------------------------------
-- ALGEMAS E CHAVES
------------------------------------------------------------------------
local cuffed = false
local dict = "TASK_ARREST_PED"
local anim = "idle"
local flags = 49
local ped = PlayerPedId()
local changed = false
local prevMaleVariation = 0
local prevFemaleVariation = 0
local femaleHash = GetHashKey("mp_female")
local maleHash = GetHashKey("mp_male")
local IsLockpicking = false
local handcuffed = false

RegisterCommand(
	"revistar",
	function()
		local player, distance = GetClosestPlayer()
		if player ~= nil then
			local nearestPed = GetPlayerPed(player)		
			if distance ~= -1 and distance <= 3.0 then
				if IsEntityPlayingAnim(nearestPed, "script_proc@robberies@homestead@lonnies_shack@deception", "hands_up_loop", 3) then
					TriggerServerEvent("FRP:SHERIFF:TryToPatDown", GetPlayerServerId(player))
				end
			end
		end
	end,
	false
)

RegisterNetEvent("FRP:SHERIFF:putinvehicle")
AddEventHandler(
	"FRP:SHERIFF:putinvehicle",
	function()
		local nearestPlayer = cAPI.getNearestPlayer(1.5)
		if nearestPlayer ~= nil then
			if IsPedCuffed(GetPlayerPed(player)) then
				handcuffed = nearestPlayer
			else
				handcuffed = nil
			end
		else
			handcuffed = nil
		end

		local player, distance = GetClosestPlayer()
		if distance ~= -1 and distance <= 3.0 then
			if player == handcuffed then
			else
				TriggerServerEvent("FRP:SHERIFF:puting", GetPlayerServerId(player))
			end
		else
		end
	end
)

RegisterNetEvent("FRP:SHERIFF:vehiclep")
AddEventHandler(
	"FRP:SHERIFF:vehiclep",
	function()
		local coords = GetEntityCoords(PlayerPedId())
		if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
			local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
			if DoesEntityExist(vehicle) then
				local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
				local freeSeat = nil

				for i = maxSeats - 1, 0, -1 do
					if IsVehicleSeatFree(vehicle, i) then
						freeSeat = i
						break
					end
				end
				if freeSeat ~= nil then
					SetPedIntoVehicle(PlayerPedId(), vehicle, 2)
					TriggerEvent("chatMessage", "SISTEMA", {255, 255, 255}, "Você foi colocado dentro do veículo")
				--DragStatus.IsDragged = false
				end
			end
		end
	end
)

RegisterNetEvent("FRP:SHERIFF:outvehicle")
AddEventHandler(
	"FRP:SHERIFF:outvehicle",
	function()
		local nearestPlayer = cAPI.getNearestPlayer(1.5)
		if nearestPlayer ~= nil then
			if IsPedInAnyVehicle(GetPlayerPed(player)) then
				handcuffed = nearestPlayer
			else
				handcuffed = nil
			end
		else
			handcuffed = nil
		end

		local player, distance = GetClosestPlayer()
		if distance ~= -1 and distance <= 3.0 then
			if player == handcuffed then
			else
				print("chegouaqui")
				TriggerServerEvent("FRP:SHERIFF:outing", GetPlayerServerId(player))
			end
		else
		end
	end
)

RegisterNetEvent("FRP:SHERIFF:vehicleout")
AddEventHandler(
	"FRP:SHERIFF:vehicleout",
	function()
		local playerPed = PlayerPedId()

		if not IsPedSittingInAnyVehicle(playerPed) then
			return
		end

		local vehicle = GetVehiclePedIsIn(playerPed, false)
		TaskLeaveVehicle(playerPed, vehicle, 0, 0)
	end
)

RegisterNetEvent("FRP:SHERIFF:cuff")
AddEventHandler(
	"FRP:SHERIFF:cuff",
	function()
		ped = GetPlayerPed(-1)
		ped2 = PlayerPedId()

		-- if GetEntityModel(ped) == femaleHash then
		-- 	Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  tonumber(hash), true, true, true)
		-- --  prevFemaleVariation = GetPedDrawableVariation(ped, 7)
		-- 	SetPedComponentVariation(ped, 7, 25, 0, 0)
		-- elseif GetEntityModel(ped) == maleHash then
		-- --      prevMaleVariation = GetPedDrawableVariation(ped, 7)
		-- 	SetPedComponentVariation(ped, 7, 41, 0, 0)
		-- end

		SetEnableHandcuffs(ped2, true)
		handcuffed = true
		cuffed = not cuffed
		changed = true
	end
)

RegisterNetEvent("FRP:SHERIFF:uncuff")
AddEventHandler(
	"FRP:SHERIFF:uncuff",
	function()
		ped = GetPlayerPed(-1)
		ped2 = PlayerPedId()
		ClearPedTasks(ped)
		SetEnableHandcuffs(ped2, false)
		UncuffPed(ped2)
		--[[
	if GetEntityModel(ped) == femaleHash then -- mp female
		SetPedComponentVariation(ped, 7, prevFemaleVariation, 0, 0)
	elseif GetEntityModel(ped) == maleHash then -- mp male
		SetPedComponentVariation(ped, 7, prevMaleVariation, 0, 0)
	end ]]
		cuffed = not cuffed
		handcuffed = false
		changed = true
	end
)

RegisterNetEvent("FRP:SHERIFF:cuffcheck")
AddEventHandler(
	"FRP:SHERIFF:cuffcheck",
	function()
		local player, distance = GetClosestPlayer()
		if distance ~= -1 and distance <= 3.0 then
			if PlayerPedId() == handcuffed == true then
				TriggerEvent("chatMessage", "SISTEMA", {255, 255, 255}, "Já está algemado.")
			else
				TriggerServerEvent("FRP:SHERIFF:cuffing", GetPlayerServerId(player))
			end
			TriggerEvent("chatMessage", "SISTEMA", {255, 255, 255}, "Você Algemou. (" .. GetPlayerName(player) .. ")")
		else
			--  TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Ninguem por perto')
		end
	end
)

RegisterNetEvent("FRP:SHERIFF:nyckelcheck")
AddEventHandler(
	"FRP:SHERIFF:nyckelcheck",
	function()
		ped1 = GetClosestPlayer()
		local player, distance = GetClosestPlayer()
		local players = GetPlayerServerId(source)
		if distance ~= -1 and distance <= 3.0 then
			TriggerServerEvent("FRP:SHERIFF:unlocking", GetPlayerServerId(player))
			TriggerEvent("chatMessage", "SISTEMA", {255, 255, 255}, "Você soltou. (" .. GetPlayerName(player) .. ")")
			print("passou aqui uncuff")
		else
			--    TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Ninguem próximo está algemado')
		end
	end
)

RegisterNetEvent("FRP:SHERIFF:unlockingcuffs")
AddEventHandler(
	"FRP:SHERIFF:unlockingcuffs",
	function()
		local player, distance = GetClosestPlayer()
		local ped = GetPlayerPed(-1)

		if IsLockpicking == false then
			FreezeEntityPosition(player, true)
			FreezeEntityPosition(ped, true)
			TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WELDING", 0, true)
			IsLockpicking = true
			Wait(30000)
			IsLockpicking = false
			FreezeEntityPosition(player, false)
			FreezeEntityPosition(ped, false)
			ClearPedTasksImmediately(ped)
			TriggerServerEvent("FRP:SHERIFF:unlocking", GetPlayerServerId(player))
			TriggerEvent("fc_notify:start", "Algemas quebradas", 5, "success")
		else
			TriggerEvent("chatMessage", "SISTEMA", {255, 255, 255}, '"Você já está quebrando as algemas')
		end
	end
)
------------------------------------------------------------------------
-- ALGEMAS E CHAVES
------------------------------------------------------------------------
function GetPlayers()
	local players = {}
	for _, player in ipairs(GetActivePlayers()) do
		local ped = GetPlayerPed(player)
		if DoesEntityExist(ped) then
			table.insert(players, player)
		end
	end
	return players
end

function GetClosestPlayer()
	local players, closestDistance, closestPlayer = GetPlayers(), -1, -1
	local coords, usePlayerPed = coords, false
	local playerPed, playerId = PlayerPedId(), PlayerId()
	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		usePlayerPed = true
		coords = GetEntityCoords(playerPed)
	end
	for i = 1, #players, 1 do
		local target = GetPlayerPed(players[i])
		if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then
			local targetCoords = GetEntityCoords(target)
			local distance = #(coords - targetCoords)
			if closestDistance == -1 or closestDistance > distance then
				closestPlayer = players[i]
				closestDistance = distance
			end
		end
	end
	return closestPlayer, closestDistance
end

-- RegisterCommand(
-- 	"drag",
-- 	function(source, args, rawCommand)
-- 		closestPlayer, closestdistance = GetClosestPlayer()
-- 		if closest ~= nil and DoesEntityExist(GetPlayerPed(closestPlayer)) then
-- 			if closestdistance - 1 and closestdistance < 3 then
-- 				local closestID = GetPlayerServerId(closestPlayer)
-- 				TriggerEvent("chatMessage", "Police System", {255, 255, 255}, "You are dragging the nearest player. (" .. GetPlayerName(closestPlayer) .. ")")
-- 				TriggerServerEvent("dragServer", closestID)
-- 			else
-- 				TriggerEvent("chatMessage", "Police System", {255, 255, 255}, "Nearest player is too far away")
-- 			end
-- 		end
-- 	end
-- )

-- RegisterCommand(
-- 	"undrag",
-- 	function()
-- 		closest, distance = GetClosestPlayer()
-- 		if closest ~= nil and DoesEntityExist(GetPlayerPed(closest)) then
-- 			if distance - 1 and distance < 3 then
-- 				TriggerEvent("chatMessage", "Police System", {255, 255, 255}, "You are no longer dragging the nearest player. (" .. GetPlayerName(closest) .. ")")
-- 				local closestID = GetPlayerServerId(closest)
-- 				TriggerServerEvent("unDragServer", closestID)
-- 			else
-- 				TriggerEvent("chatMessage", "Police System", {255, 255, 255}, "Nearest player is too far away")
-- 			end
-- 		end
-- 	end
-- )

RegisterNetEvent("showIDClient")
AddEventHandler(
	"showIDClient",
	function()
		TriggerEvent("chatMessage", "ID", {255, 255, 255}, GetPlayerName(sourceID) .. " has showed you their ID.")
	end
)

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry("FMMC_KEY_TIP1", TextEntry .. ":")
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end
