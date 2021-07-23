local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

---------------------------
-- MEDIC MANAGEMENT API --
---------------------------
-- Variables

RegisterNetEvent('FRP:MEDIC:checkdeath')
AddEventHandler('FRP:MEDIC:checkdeath', function()
  local player, distance = GetClosestPlayer()

  if distance ~= -1 and distance <= 3.0 then
    TriggerServerEvent('FRP:MEDIC:checkcallback', GetPlayerServerId(player))
   -- TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Curou o (' .. GetPlayerName(player) .. ')')
  else
    TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Ninguem por perto')
  end
end)

RegisterNetEvent('FRP:MEDIC:TreatmentCheck')
AddEventHandler('FRP:MEDIC:TreatmentCheck', function()
  local player, distance = GetClosestPlayer()

  if distance ~= -1 and distance <= 3.0 then
    TriggerServerEvent('FRP:MEDIC:TreatmentCallback', GetPlayerServerId(player))
   -- TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Curou o (' .. GetPlayerName(player) .. ')')
  else
    TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Ninguem por perto')
  end
end)

RegisterNetEvent('FRP:MEDIC:revivecheck')
AddEventHandler('FRP:MEDIC:revivecheck', function()
  local player, distance = GetClosestPlayer()

  if distance ~= -1 and distance <= 3.0 then
    TriggerServerEvent('FRP:MEDIC:revivecallback', GetPlayerServerId(player))
   -- TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Curou o (' .. GetPlayerName(player) .. ')')
  else
    TriggerEvent('chatMessage', 'SISTEMA', {255, 255, 255}, 'Ninguem por perto')
  end
end)

-- RegisterNetEvent('FRP:MEDIC:ReceiveStatus')
-- AddEventHandler('FRP:MEDIC:ReceiveStatus', function(data)     
-- 	if data.InstaDeath ~= nil then		
-- 		if data.InstaDeath == true then
-- 			print('este player está em coma.')
-- 		end
-- 		print(data.InstaDeath)
-- 	end

-- 	if data.deathCause ~= nil then
-- 		print(data.deathCause)
-- 	end

-- 	if data.VitalPartDamage ~= nil then
-- 		if data.VitalPartDamage == true then
-- 			print('está gravemente ferido.')
-- 		end
-- 		print(data.VitalPartDamage)
-- 	end

-- 	if data.BodyPartDamage ~= nil then		
-- 		print('Foi atingido em ' .. json.encode(data.BodyPartDamage))
-- 		print(data.BodyPartDamage)
-- 	end
-- end)

RegisterNetEvent('FRP:MEDIC:revive')
AddEventHandler('FRP:MEDIC:revive', function(data)

    -- PUT HERE ANIMATION

    print('playanim')

end)



function isNearPlayer()
	local player, distance = GetClosestPlayer()
	if distance ~= -1 and distance <= 2.0 then
	    return player, distance
	else
	    return false
	end
	return false
end

function GetPlayers()
    local players = {}

    for _,player in ipairs(GetActivePlayers()) do
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
    for i=1, #players, 1 do
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