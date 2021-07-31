local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local FirstSpawn = false
local car = nil
local ped = nil
local coords = vector3(2539.83,-1129.33,50.03)


RegisterCommand('first', function()
    TriggerEvent('FRP:CREATOR:FirstSpawn')
end)
--[[
RegisterCommand('goped', function()
   -- TriggerMusicEvent("REDLP_START")
  --  TriggerMusicEvent("REHR_START") -- MELHOR
  TriggerMusicEvent("REHR_START")
end)
RegisterCommand('first2', function()
    TriggerMusicEvent("MC_MUSIC_STOP")
end) ]]


RegisterNetEvent("FRP:CREATOR:FirstSpawn")
AddEventHandler(
    "FRP:CREATOR:FirstSpawn",
    function()
        if not FirstSpawn and Config.EnableCutscene then
            TriggerMusicEvent("REHR_START")            
            NetworkSetEntityInvisibleToNetwork(PlayerPedId(), true)           
            Wait(100)
            SetEntityCoords(PlayerPedId(), 2520.09,-358.05,41.61)
            Wait(2500)
            TriggerEvent('FRP:CREATOR:CreateVehicle', 'STAGECOACH001X')
            Wait(1000)
            TriggerEvent('FRP:CREATOR:CreatePedOnVehicle', 'CS_BivCoachDriver')
            Wait(3000)
            SetPedIntoVehicle(PlayerPedId(), car, 1)
            Wait(2000)               
            TriggerEvent('FRP:CREATOR:StartNotify')
            FirstSpawn = true
        else            
            TriggerEvent('FRP:CREATOR:StartNotify')            
            SetEntityCoords(PlayerPedId(), Config.FirstSpawnCoords)
            FirstSpawn = false
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(10)
            if FirstSpawn then	
                local pcoords = GetEntityCoords(PlayerPedId())                
                local dst = #(coords - pcoords)	   
                if dst < 5 then
                    RemovePedFromGroup(ped, GetPedGroupIndex(PlayerPedId()))
                    Wait(100)
                    DisableAllControlActions(0)                  
                    NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
                    SetEntityInvincible(PlayerPedId(), false)  
                    SetCinematicModeActive(0)                    
                    FirstSpawn = false
                    N_0x69d65e89ffd72313(false)    
                    Wait(1000)
                    TaskLeaveVehicle(PlayerPedId(), car, 0, 0) 
                    Wait(2000)                         
                    TaskVehicleDriveToCoord(ped, GetVehiclePedIsIn(ped, false), 2600.436,-1205.932,53.323, 10.0, 1.0, GetEntityModel(GetVehiclePedIsIn(PlayerPedId())), 67633207, 5.0, false)
                    TriggerEvent('FRP:NOTIFY:Simple', 'Você perdeu todas as suas roupas, tem uma loja de roupa do outro lado da rua, que tal ir lá se trocar?', 10000)
                    TriggerMusicEvent("MC_MUSIC_STOP")                    
                    Wait(10000)
                  --  TriggerEvent('FRP:NOTIFY:Simple', 'Digite /guiainiciante ver o Jornal Guia de Iniciante.', 10000)
                    DeleteVehicle(car)
					Citizen.InvokeNative(0x971D38760FBC02EF, ped, false)
                    DeleteEntity(ped)
                else               
                    N_0x69d65e89ffd72313(true)
                    SetCinematicModeActive(1)
                    DisableAllControlActions(1)
                end 
            end	
        end
    end
)

RegisterNetEvent("FRP:CREATOR:CreateVehicle")
AddEventHandler(
	"FRP:CREATOR:CreateVehicle",
	function(vModel)
		local veh = GetHashKey(vModel)
		local ply = GetPlayerPed()
		local coords = GetEntityCoords(ply)
		Citizen.CreateThread(
			function()
				RequestModel(veh)
				while not HasModelLoaded(veh) do
                    Wait(1000)                    
				end
				if HasModelLoaded(veh) then
                    car = CreateVehicle(veh, 2520.09, -358.05, 41.61, 268.89169, true, false)
					SetVehicleOnGroundProperly(car)
				end
			end
		)
	end
)

RegisterNetEvent("FRP:CREATOR:StartNotify")
AddEventHandler(
	"FRP:CREATOR:StartNotify",
    function()
    Wait(5000)
	TriggerEvent('FRP:NOTIFY:Simple', 'Saudações, caubói. Seja muito bem-vindo ao  Faroeste Roleplay, sinta-se livre para explorar as mais variadas regiões e descobrir os mistérios que esse novo mundo lhe aguarda. ', 12000)
    Wait(15000)
    TriggerEvent('FRP:NOTIFY:Simple', 'Leia o mural de regras~ para ficar por dentro de tudo o que é permitido no servidor, e para que assim evite dúvidas ou problemas futuros. ', 10000)
    Wait(15000)
    TriggerEvent('FRP:NOTIFY:Simple', 'Tome cuidado ao andejar pelo anoitecer no faroeste, somente os verdadeiramente aventureiros ficam depois do escurecer... dizem que é um mundo totalmente diferente sob a luz da Lua.', 12000)
    Wait(18000)
    TriggerEvent('FRP:NOTIFY:Simple', 'Aqui é Saint Dennis, a primeira cidade na qual você vai conhecer. Nela você poderá encontrar diversas lojas de departamento, como a loja de roupas, cabeleireiro, departamento de polícia, entre outros. Mas lembre-se de que há um mundo imenso para você explorar!', 18000)
end)

RegisterNetEvent("FRP:CREATOR:CreatePedOnVehicle")
AddEventHandler(
    "FRP:CREATOR:CreatePedOnVehicle",    
    function(pedModel)
        
        local pedModelHash = GetHashKey(pedModel)
		if not IsModelValid(pedModelHash) then
			return
		end

		if not HasModelLoaded(pedModelHash) then
			RequestModel(pedModelHash)
			while not HasModelLoaded(pedModelHash) do
				Citizen.Wait(10)
			end
        end
        
		ped = CreatePed(pedModelHash, coords, GetEntityHeading(PlayerPedId()), false, 0)        
        Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
        Citizen.InvokeNative(0x58A850EAEE20FAA3, ped)
		
		SetEntityNoCollisionEntity(PlayerPedId(), ped, false)
        SetEntityCanBeDamaged(ped, false)
        SetEntityInvincible(ped, true)
        Wait(1000)
        SetBlockingOfNonTemporaryEvents(ped, true)

        SetEntityAsMissionEntity(ped)

        -- SetModelAsNoLongerNeeded(pedModelHash)
        Citizen.Wait(150)
        SetPedAsGroupMember(ped, GetPedGroupIndex(PlayerPedId()))
		
		SetEntityAsMissionEntity(car, false, false)
        SetEntityAsMissionEntity(ped, false, false)
            
        npc_group = GetPedRelationshipGroupHash(ped)
        SetRelationshipBetweenGroups(1 , GetHashKey("PLAYER") , npc_group)

        SetPedIntoVehicle(ped, car, -1)
        TaskVehicleDriveToCoord(ped, GetVehiclePedIsIn(ped, false), 2539.83,-1129.33,50.03, 10.0, 1.0, GetEntityModel(GetVehiclePedIsIn(PlayerPedId())), 67633207, 5.0, false)
        Citizen.InvokeNative(0x971D38760FBC02EF, ped, true)
        
        Citizen.Wait(250)
	end
)

