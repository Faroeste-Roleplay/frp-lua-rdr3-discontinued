
local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')


RegisterNetEvent('FRP:ANIMALS:create')
AddEventHandler('FRP:ANIMALS:create', function(x,y,z)
	TriggerEvent('Distress', 'sucesso', 'Um animal lendário foi visto por essas redondesas.')
	local blip = Citizen.InvokeNative(0x45F13B7E0A15C880, 693035517, x, y, z, 100.0)
	Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Animal Lendário')
	Wait(30000)
	RemoveBlip(blip)
end)


RegisterNetEvent('FRP:ANIMALS:createPeds')
AddEventHandler('FRP:ANIMALS:createPeds', function(model, x,y,z)
	local pedModelHash = GetHashKey(model)
	if not HasModelLoaded(pedModelHash) then
		RequestModel(pedModelHash)
		while not HasModelLoaded(pedModelHash) do
			Citizen.Wait(10)
		end
	end
	local ped = CreatePed(pedModelHash, x+2, y+2, z, GetEntityHeading(PlayerPedId()), 1, 0)
	Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
	Citizen.InvokeNative(0x58A850EAEE20FAA3, ped)
	SetEntityAsMissionEntity(ped, true, true)
	TaskWanderStandard(ped, 40000, 0)

end)


RegisterCommand('empinar', function()
	--TaskHorseAction(GetMount(PlayerPedId()), 4, 0, 0)
end)

local attr

RegisterCommand('attr', function(source, args, rawCommand)
	attr = tonumber(args[1])
end, false)

Citizen.CreateThread(
	function()
		while true do
			local itemSet = CreateItemset(true)
			local size = Citizen.InvokeNative(0x59B57C4B06531E1E, GetEntityCoords(PlayerPedId()), 2.5, itemSet, 1)
			-- number xPos, number yPox, number zPos, float distance, int itemSet, int entityType

			if size ~= false and size > 0 then
				for index = 0, size - 1 do
					local entity = GetIndexedItemInItemset(index, itemSet)
					SetPedFleeAttributes(entity, attr, true)
				end
			end

			if IsItemsetValid(itemSet) then
				DestroyItemset(itemSet)
			end
			Citizen.Wait(10)
		end
	end
)

Citizen.CreateThread(function()
    while true do
        Wait(1000)
		local game = NetworkIsGameInProgress()
		if game == 1 then
			TriggerServerEvent('FRP:ANIMALS:playerActivated')
			return
		end
    end
end)

