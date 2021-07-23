local IsJailed = false
local unjail = false
JailTime = 0
fastTimer = 0
local JailLocation = 3372.48, -667.09, 46.41

RegisterNetEvent('FRP:JAIL:jail')
AddEventHandler('FRP:JAIL:jail', function(jailTime)

	if IsJailed then -- don't allow multiple jails
		return
	end


	JailTime = jailTime
	local playerPed = PlayerPedId()
	if DoesEntityExist(playerPed) then
		Citizen.CreateThread(function()
			print('a2')
			local pP = PlayerPedId()
			local entity = GetPlayerPed()
			local pedplayer = GetEntityModel(entity)
    		local maleped = -171876066			
			print(tostring(pedplayer))	
			-- Assign jail skin to user		
				Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x9925C067, 0) -- HAT REMOVE
				Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
				Wait(100)		
				Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x2026C46D, 0) -- Set target category, here the hash is for hats
				Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
				Wait(100)	
				Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x485EE834, 0) -- Set target category, here the hash is for hats
				Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
				Wait(100)	
				Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x1D4C528A, 0) -- Set target category, here the hash is for hats
				Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
				Wait(100)
				Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x777EC6EF, 0) -- Set target category
				Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- REMOVE COMPONENT
				Wait(100)	
				Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7505EF42, 0) -- Set target category, here the hash is for hats            
				Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
				Wait(100)
				Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x662AC34, 0) -- Set target category, here the hash is for hats
				Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
				Wait(100)
				Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xEABE0032, 0) -- Set target category, here the hash is for hats
				Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
				Wait(100)
				Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x5FC29285, 0) -- Set target category, here the hash is for hats
				Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
				Wait(100)
				Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x9B2C8B89, 0) -- Set target category, here the hash is for hats
				Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
				Wait(100)

				if pedplayer == maleped then
					--print('HOMEM SKIN')	
					Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),0x5BA76CCF,true,true,true) -- CAMISA	
					Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),0x216612F0,true,true,true) -- CALÇA
					Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),0xF082E23A,true,true,true) -- SAPATO		

				else
					Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),0x6AB27695,true,true,true) -- CAMISA	
					Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),0x75BC0CF5,true,true,true) -- PANTS
					Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),0x56906647,true,true,true) -- SAPATO
					--print('MULHER SKIN')
				end
			-- Clear player
			--ClearPedBloodDamage(playerPed)
--			ClearPedLastWeaponDamage(playerPed)
			
			print(playerPed)
			SetEntityCoords(playerPed,  3372.48, -667.09, 46.41)

			IsJailed = true
			unjail = false

			while JailTime > 0 and not unjail do
				print('a3')
				playerPed = PlayerPedId()
				SetEntityInvincible(PlayerPed, false)				
				RemoveAllPedWeapons(PlayerPedId(), false, true)
				if IsPedInAnyVehicle(playerPed, false) then
					ClearPedTasksImmediately(playerPed)
				end
				if JailTime % 100 == 0 then
					TriggerServerEvent('FRP:JAIL:updateRemaining', JailTime)
				end
				Citizen.Wait(20000)
				-- Is the player trying to escape?
				if Vdist(GetEntityCoords(playerPed), 3372.48, -667.09, 46.41) > 70 then
					SetEntityCoords(playerPed, 3372.48, -667.09, 46.41)
					--TriggerEvent('chat:addMessage', { args = { _U('judge'), _U('escape_attempt') }, color = { 147, 196, 109 } })
				end				
				JailTime = JailTime - 20
			end
			TriggerServerEvent('FRP:JAIL:unjailTime', -1)
			--SetEntityCoords(playerPed, 3372.48, -667.09, 46.41)
			IsJailed = false
		end)
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if JailTime > 1 and IsJailed then
			if fastTimer < 0 then
				fastTimer = JailTime
			end
			DrawTxt('PRESO: ' .. tonumber(string.format("%.0f", fastTimer)) .. ' segundos para você ser libertado.', 0.70, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
			fastTimer = fastTimer - 0.01
		else
			Citizen.Wait(1000)
		end
	end
end)

RegisterNetEvent('FRP:JAIL:unjail')
AddEventHandler('FRP:JAIL:unjail', function(source)
	unjail = true
	JailTime = 0
	fastTimer = 0
	local playerPed = PlayerPedId()
	SetEntityInvincible(PlayerPed, false)
	SetEntityCoords(playerPed, 2929.51, -1252.1, 42.28)
end)

-- When script starts
Citizen.CreateThread(function()
	local retval, ped = PlayerPedId()
	local spawned =	NetworkIsPlayerActive(ped, Citizen.ResultAsInteger())
	Citizen.Wait(7000)
	if spawned then
		print(spawned)
		TriggerServerEvent('FRP:JAIL:checkJail')
	end
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end


