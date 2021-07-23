
local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

local blip 

RegisterNetEvent('TREASURE:create')
AddEventHandler('TREASURE:create', function(x,y,z)
	TriggerEvent('FRP:NOTIFY:Simple', 'Há um tesouro perdido no mapa, procure pela mancha vermelha.', 10000)
	blip = Citizen.InvokeNative(0x45F13B7E0A15C880, 693035517, x, y, z, 150.0)	
	Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Tesouro Perdido')		
end)

RegisterNetEvent('TREASURE:createPedDefender')
AddEventHandler('TREASURE:createPedDefender', function(x,y,z, animal, qtd)
	local pedModelHash = GetHashKey(animal)
	
	if not HasModelLoaded(pedModelHash) then
		RequestModel(pedModelHash)
		while not HasModelLoaded(pedModelHash) do
			Citizen.Wait(10)
		end
	end

	for i = 1, tonumber(qtd) do
		local ped = CreatePed(pedModelHash, x+math.random(1,8), y, z, GetEntityHeading(PlayerPedId()), 1, 0)
		Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
		Citizen.InvokeNative(0x58A850EAEE20FAA3, ped)
	--	Citizen.InvokeNative(0xE054346CA3A0F315, ped, x, y, z, 10, 0, 0)
	--	ClearPedSecondaryTask(ped)
		SetEntityAsMissionEntity(ped)
		--SetRelationshipBetweenGroups(5, ped, `PLAYER`)
		ClearPedSecondaryTask(ped)
		SetPedOutfitPreset(ped, math.random(1,8))

		if animal == "G_M_M_UNISWAMP_01" then

			SetPedAsGroupMember(ped, GetDefaultRelationshipGroupHash("G_M_M_UNISWAMP_01"))
			AddRelationshipGroup("GANG_NIGHT_FOLK")
			SetPedRelationshipGroupHash(ped, GetHashKey("GANG_NIGHT_FOLK"))
	
			local weapons = {
				[1] = {["WEAPON_MELEE_KNIFE_JAWBONE"] = 3},
				[2] = {["WEAPON_MELEE_MACHETE"] = 3},
				[3] = {["WEAPON_MELEE_CLEAVER"] = 10},
				[4] = {["WEAPON_MELEE_KNIFE"]= 3}
		   }

		   for WeaponHash, Quantity in pairs(weapons[math.random(1,4)]) do
			Citizen.InvokeNative(0xB282DC6EBD803C75, ped, GetHashKey(WeaponHash), 500, true, 0)
		   end
		end
		 
		SetPedFleeAttributes(ped, 0, 0)
		SetPedCombatAttributes(ped, 46, 1)
		SetPedCombatAbility(ped, 100)
		SetPedCombatMovement(ped, 2)
		SetPedCombatRange(ped, 2)
		SetAmbientVoiceName(ped, "ALIENS")
		DisablePedPainAudio(ped, true)
	 
		--SetPedIsDrunk(ped, true)
		--RequestAnimSet("move_m@drunk@verydrunk")
		--while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
			--Wait(1)
		--end
		Citizen.Trace("Load animation set\n")
		--SetPedMovementClipset(ped, "move_m@drunk@verydrunk", 1.0)	

		TaskCombatHatedTargets(ped , 16)
		
		Wait(500)

	end
end)

Citizen.CreateThread(
	function()
	while true do
		Citizen.Wait(1)
		SetRelationshipBetweenGroups(5, "PLAYER", "GANG_NIGHT_FOLK")
		SetRelationshipBetweenGroups(5, "GANG_NIGHT_FOLK", "PLAYER")
	end
end
)


Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(8000)
            local IsPedAir = IsEntityInAir(pigeon, 1)
            local playc = GetEntityCoords(PlayerPedId())
            if pigeon ~= nil then
                if not IsPedAir and Notified and dst > 4 then
                    TaskFlyToCoord(pigeon, 0, playc.x, playc.y, playc.z, 1, 0)
                 --   TaskGoToEntity(pigeon, PlayerPedId(), -1, 2.5, 2, 0, 0)    
                end
            end
        end
    end
)       

RegisterNetEvent('TREASURE:killblip')
AddEventHandler('TREASURE:killblip', function()
	RemoveBlip(blip)
end)

Citizen.CreateThread(function()
    while true do
        Wait(1000)
		local game = NetworkIsGameInProgress()
		if game == 1 then
			TriggerServerEvent('TREASURE:playerActivated')
			return
		end
    end
end)