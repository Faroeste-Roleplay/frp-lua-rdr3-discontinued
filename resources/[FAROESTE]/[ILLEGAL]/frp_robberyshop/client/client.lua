local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local isRobberyActive = false
local robberyTime = 0
local robberyBlip = nil
local robberyMoney = 0
local robberyAmmount = 0
local h
local atmCoords

-- Detect Robbery
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)

			for k, v in pairs(Config.ATMS) do
				local player = PlayerPedId()
				local x, y, z = table.unpack(GetEntityCoords(player))
				--	local bz,cz = Citizen.InvokeNative(0x24FA4267BB8D2431,v.x,v.y,v.z,1)

				local distance = GetDistanceBetweenCoords(v.x, v.y, v.z, x, y, z, true)

				if isRobberyActive then
					DrawText("Faltam " .. robberyTime .. " segundos~w~ para finalizar o roubo", 0.85, 0.96, 0.4, 0.4, false, 255, 255, 255, 120, 1, 7)
					if robberyTime < 30 then
						DrawText("Aperte " .. Config.robberyCancelKey .. " para cancelar o andamento do roubo", 0.85, 0.93, 0.4, 0.4, false, 255, 255, 255, 120, 1, 7)
						if IsControlJustPressed(0, 0xD8F73058) or GetEntityHealth(player) <= 100 then
							isRobberyActive = "fail"
							ClearPedTasksImmediately(PlayerPedId())
							FreezeEntityPosition(PlayerPedId(), false)
						end
					end
				else
					if distance <= 1.2 then
						DrawText3D(v.x, v.y, v.z + 0.5, "Aperte [ENTER] para roubar")

						if IsControlJustPressed(0, 0xC7B5340A) and not IsPedInAnyVehicle(player) then
							if NetworkIsSessionActive() == 1 then
								TriggerServerEvent("FRP:ROBREG:checkTheRobbery", {v.id, v.x, v.y, v.z, v.h, v.seconds})
							else
								cAPI.notify("error", "Sessão solo!")
							end
						end
					end
				end
			end
		end
	end
)

RegisterNetEvent("FRP:ROBREG:cancelfreeze")
AddEventHandler(
	"FRP:ROBREG:cancelfreeze",
	function()
		FreezeEntityPosition(PlayerPedId(), false)

		cAPI.AddWantedTime(true, 30)

		-- local coords = GetEntityCoords(PlayerPedId()) + (GetEntityForwardVector(PlayerPedId()) * 0.7)
		-- local object = CreateObject(model, coords, true, true, false, false, true)
		-- PlaceObjectOnGroundProperly(object)

		-- Citizen.InvokeNative(0x3BBDD6143FF16F98, PlayerPedId(), object, "p_hayBale03x_PH_R_HAND", "PROP_PLAYER_CASH_REGISTER_OPEN", 0, 0)
	end
)

-- Countdown
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)

			if isRobberyActive then
				if isRobberyActive ~= "fail" then
					robberyTime = math.floor(robberyTime - 1)
					robberyAmmount = math.ceil(robberyAmmount + robberyMoney)

					TriggerServerEvent("FRP:ROBREG:giveRobbedMoney", robberyMoney)

					if robberyTime <= 0 then
						ClearPedTasks(PlayerPedId())
						TriggerServerEvent("FRP:ROBREG:finishedTheRobbery", robberyAmmount)
						isRobberyActive = false
						robberyMoney = 0
						robberyAmmount = 0
					end
				else
					ClearPedTasks(PlayerPedId())
					FreezeEntityPosition(PlayerPedId(), false)
					TriggerServerEvent("FRP:ROBREG:cancelTheRobbery", robberyAmmount)
					isRobberyActive = false
					robberyMoney = 0
					robberyAmmount = 0
				end
			end
		end
	end
)

RegisterNetEvent("FRP:ROBREG:startTheRobbery")
AddEventHandler(
	"FRP:ROBREG:startTheRobbery",
	function(atmInfo)
		ClearPedTasks(PlayerPedId())

		isRobberyActive = true
		robberyTime = atmInfo[6]
		robberyMoney = math.ceil(math.random(Config.moneyReward.min, Config.moneyReward.max) / robberyTime)

		robberyAmmount = 0

		local id = atmInfo[1]
		x, y, z = atmInfo[2], atmInfo[3], atmInfo[4]
		h = atmInfo[5]

		SetEntityHeading(PlayerPedId(), h)
		SetEntityCoords(PlayerPedId(), x, y, z - 1, false, false, false, false)
		--	SetPedComponentVariation(PlayerPedId(),5,45,0,2)
		SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)

		StartAnim1()

		if IsPedMale(PlayerPedId()) then
			setSatchel(0xEA272E11)
		else
			setSatchel(0xFCAF241B)
		end
	end
)

function setSatchel(model)
	if HasModelLoaded(model) then
		Citizen.InvokeNative(0xFA28FE3A6246FC3, parseInt(model))
	end
	Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), parseInt(model), true, true, true)
end

RegisterNetEvent("FRP:ROBREG:warnThePolice")
AddEventHandler(
	"FRP:ROBREG:warnThePolice",
	function(AtmX, AtmY, AtmZ)
		Wait(10000)
		--	if cAPI.hasGroupOrInheritance('trooper') or cAPI.hasGroupOrInheritance('sheriff') then
		Citizen.InvokeNative(0x67C540AA08E4A6F5, "Match_End_Timer", "RDRO_Countdown_Sounds", true, 0)
		atmCoords = vector3(AtmX, AtmY, AtmZ)

		local zone = GetCurrentTownName()
		--	TriggerEvent('chatMessage', _U('police_title'), Config.policeColor, string.format( Locales[Config.Locale]['police_warning_location'], location ) )
		TriggerEvent("FRP:NOTIFY:Simple", "SHERIFF:<br>Roubo à uma Loja! Vá até o local e impeça os assaltantes em " .. zone, 10000)
		TriggerEvent("FRP:ROBREG:InfoSheriff", AtmX, AtmY, AtmZ)
		--	end
	end
)

-- RegisterNetEvent('FRP:ROBREG:createRobBlip')
-- AddEventHandler('FRP:ROBREG:createRobBlip',function(targetAtm)
-- 	local x,y,z = targetAtm[1],targetAtm[2],targetAtm[3]
-- 	if not DoesBlipExist(robberyBlip) then
-- 		robberyBlip = AddBlipForCoord(x,y,z)
-- 		SetBlipScale(robberyBlip,0.7)
-- 		SetBlipSprite(robberyBlip,1)
-- 		SetBlipColour(robberyBlip,59)
-- 		BeginTextCommandSetBlipName('STRING')
-- 		AddTextComponentString( _U('police_warning_blip_title') )
-- 		EndTextCommandSetBlipName(robberyBlip)
-- 		SetBlipAsShortRange(robberyBlip,false)
-- 		SetBlipRoute(robberyBlip,true)
-- 	end
-- end)

RegisterNetEvent("FRP:ROBREG:InfoSheriff")
AddEventHandler(
	"FRP:ROBREG:InfoSheriff",
	function(x, y, z)
		AllowSonarBlips(true)
		StartGpsMultiRoute(76603059, true, true)
		--StartGpsMultiRoute(76603059, true, true)					-- Add the points
		AddPointToGpsMultiRoute(x, y, z)
		SetGpsMultiRouteRender(true)
		TriggerEvent("FRP:ROBREG:ClearGps")
		local time = 60
		Citizen.CreateThread(
			function()
				while time > 0 do
					Wait(1500)
					ForceSonarBlipsThisFrame()
					local coords = GetEntityCoords(PlayerPedId())
					TriggerSonarBlip(348490638, x, y, z)
					time = time - 1
				end
			end
		)
	end
)

RegisterNetEvent("FRP:ROBREG:ClearGps")
AddEventHandler(
	"FRP:ROBREG:ClearGps",
	function()
		Wait(60000)
		ClearGpsMultiRoute()
	end
)

function DrawText(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre, font)
	SetTextScale(w, h)
	SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
	SetTextDropshadow(1, 0, 0, 0, 255)
	Citizen.InvokeNative(0xADA9255D, font)
	DisplayText(CreateVarString(10, "LITERAL_STRING", str), x, y)
end

function DrawText3D(x, y, z, text)
	local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
	local px, py, pz = table.unpack(GetGameplayCamCoord())
	SetTextScale(0.35, 0.35)
	SetTextFontForCurrentCommand(1)
	SetTextColor(255, 255, 255, 215)
	local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
	SetTextCentre(1)
	DisplayText(str, _x, _y)
	local factor = (string.len(text)) / 150
	DrawSprite("generic_textures", "hud_menu_4a", _x, _y + 0.0125, 0.015 + factor, 0.03, 0.1, 100, 1, 1, 190, 0)
end

RegisterNetEvent("FRP:ROBREG:PlayAlarm")
AddEventHandler(
	"FRP:ROBREG:PlayAlarm",
	function(x, y, z)
		print(x, y, z)
		Wait(20000)
		Citizen.CreateThread(
			function()
				if isRobberyActive ~= "fail" then
					Citizen.InvokeNative(0x0F2A2175734926D8, "BELL_ALARM", "BRT2_Sounds")
					local Alarm = Citizen.InvokeNative(0xE368E8422C860BA7, "BELL_ALARM", "BRT2_Sounds", -2)
					while not Alarm do
						Citizen.Wait(10)
						Citizen.InvokeNative(0x0F2A2175734926D8, "BELL_ALARM", "BRT2_Sounds")
					end
					local PlaySound = Citizen.InvokeNative(0xCCE219C922737BFA, "BELL_ALARM", x, y, z, "BRT2_Sounds", 1, 1, 1, 0)
					Wait(10000)
					Citizen.InvokeNative(0x353FC880830B88FA, PlaySound)
				end
			end
		)
	end
)

function StartAnim1()
	Citizen.CreateThread(
		function()
			local dict = "mech_pickup@loot@cash_register@open"
			local playerPed = PlayerPedId()
			local pos = GetEntityCoords(playerPed)
			local prop = GetHashKey("P_KNIFE02X")
			RequestAnimDict(dict)

			while not HasAnimDictLoaded(dict) do
				Citizen.Wait(10)
			end
			if not HasModelLoaded(prop) then
				RequestModel(prop)
			end
			while not HasModelLoaded(prop) do
				Citizen.Wait(1)
			end

			SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), 1, 0, 0, 0)
			local boneIndex = GetEntityBoneIndexByName(playerPed, "SKEL_R_HAND")
			TaskPlayAnim(PlayerPedId(), dict, "enter_picklock_step_in", 1.0, 8.0, -1, 1, 0, false, false, false)
			Citizen.Wait(1000)
			local tempObj2 = CreateObject(prop, pos.x, pos.y, pos.z, true, true, false)
			AttachEntityToEntity(tempObj2, playerPed, boneIndex, 0.05, -0.07, -0.05, -140.0, 60.0, 0.0, true, true, false, true, 1, true)
			FreezeEntityPosition(PlayerPedId(), true)
			Citizen.Wait(6000)
			DeleteObject(tempObj2)
			StartAnim2()
		end
	)
end

function StartAnim2()
	local anim2 = false
	if isRobberyActive ~= "fail" and not anim2 then
		SetEntityCoords(PlayerPedId(), x, y, z - 1, false, false, false, false)
		SetEntityHeading(PlayerPedId(), h)
	end
	anim2 = true
	while isRobberyActive do
		local dict = "mech_pickup@loot@cash_register@grab"
		RequestAnimDict(dict)
		TaskPlayAnim(PlayerPedId(), dict, "ohho", 4.0, -4.0, -1, 32, 0.0, false, 0, false, 0, false)
		Citizen.Wait(4600)
	end
end

function GetCurrentTownName()
	local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, atmCoords, 1)

	if town_hash == GetHashKey("Annesburg") then
		return "Annesburg"
	elseif town_hash == GetHashKey("Armadillo") then
		return "Armadillo"
	elseif town_hash == GetHashKey("Blackwater") then
		return "Blackwater"
	elseif town_hash == GetHashKey("BeechersHope") then
		return "BeechersHope"
	elseif town_hash == GetHashKey("Braithwaite") then
		return "Braithwaite"
	elseif town_hash == GetHashKey("Butcher") then
		return "Butcher"
	elseif town_hash == GetHashKey("Caliga") then
		return "Caliga"
	elseif town_hash == GetHashKey("cornwall") then
		return "Cornwall"
	elseif town_hash == GetHashKey("Emerald") then
		return "Emerald"
	elseif town_hash == GetHashKey("lagras") then
		return "lagras"
	elseif town_hash == GetHashKey("Manzanita") then
		return "Manzanita"
	elseif town_hash == GetHashKey("Rhodes") then
		return "Rhodes"
	elseif town_hash == GetHashKey("Siska") then
		return "Siska"
	elseif town_hash == GetHashKey("StDenis") then
		return "Saint Denis"
	elseif town_hash == GetHashKey("Strawberry") then
		return "Strawberry"
	elseif town_hash == GetHashKey("Tumbleweed") then
		return "Tumbleweed"
	elseif town_hash == GetHashKey("valentine") then
		return "Valentine"
	elseif town_hash == GetHashKey("VANHORN") then
		return "Vanhorn"
	elseif town_hash == GetHashKey("Wallace") then
		return "Wallace"
	elseif town_hash == GetHashKey("wapiti") then
		return "Wapiti"
	elseif town_hash == GetHashKey("AguasdulcesFarm") then
		return "Aguasdulces Farm"
	elseif town_hash == GetHashKey("AguasdulcesRuins") then
		return "Aguasdulces Ruins"
	elseif town_hash == GetHashKey("AguasdulcesVilla") then
		return "Aguasdulces Villa"
	elseif town_hash == GetHashKey("Manicato") then
		return "Manicato"
	elseif town_hash == false then
		return "Cidade Fantasma"
	end
end
