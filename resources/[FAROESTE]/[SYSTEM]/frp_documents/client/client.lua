local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

Showing = false

RegisterNetEvent("FRP:DOCUMENTS:opening")
AddEventHandler(
    "FRP:DOCUMENTS:opening",
    function(data)   
        SendNUIMessage(
            {
                action = "show",
                infos = data
            }
        )
        Wait(15000)
        Showing = false
end)

RegisterNetEvent("FRP:DOCUMENTS:close")
AddEventHandler(
    "FRP:DOCUMENTS:close",
    function(data)   
        SendNUIMessage(
            {
                action = "hide",
                infos = data
            }
        )
end)

RegisterCommand('meuid', function(source)
    if not Showing then
        TriggerServerEvent("FRP:DOCUMENTS:getCharInfo", GetPlayerServerId())
        Showing = true
    else
        TriggerEvent("FRP:DOCUMENTS:close")
        Showing = false
    end
end)

RegisterCommand('pedirid', function(source)
  --  local targetPlayerServerId = cAPI.getNearestPlayer(1.5)          
    local player, distance = GetClosestPlayer()

    if player ~= nil then
        local nearestPed = GetPlayerPed(player)		
        if distance ~= -1 and distance <= 3.0 then                    
            if not Showing then
                TriggerServerEvent("FRP:DOCUMENTS:requestCharInfo", GetPlayerServerId(player))
                Showing = true
            else
                TriggerEvent("FRP:DOCUMENTS:close")
                Showing = false
            end
        else
            cAPI.notify('error', 'Ninguem por perto')
        end
    end
end)

RegisterCommand('fecharid', function(source)
    TriggerEvent("FRP:DOCUMENTS:close")
    Showing = false
end)


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