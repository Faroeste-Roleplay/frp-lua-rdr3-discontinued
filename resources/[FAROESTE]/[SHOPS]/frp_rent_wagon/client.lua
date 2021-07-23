keys = {
    ['G'] = 0x760A9C6F,
    ['S'] = 0xD27782E3,
    ['W'] = 0x8FD015D8,
	['H'] = 0x24978A28,
	['G'] = 0x5415BE48,
	['E'] = 0xDFF812F9
}

Citizen.CreateThread(function()
 WarMenu.CreateMenu('Shopcarroca', 'Aluguel de Carroça')
 WarMenu.SetSubTitle('Shopcarroca', 'Lista de Carroça')
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		if WarMenu.IsMenuOpened('Shopcarroca') then
				if WarMenu.Button('Carroça 2 pessoas 10$') then
				TriggerServerEvent('carroca:buyvehicle', 10, 'BUGGY01')
				elseif WarMenu.Button('Carroça 1 Pessoa 10$') then
				TriggerServerEvent('carroca:buyvehicle', 10, 'CART01')
				elseif WarMenu.Button('Carroça 1 Pessoa 10$') then
				TriggerServerEvent('carroca:buyvehicle', 10, 'CART02')
				elseif WarMenu.Button('Carroça de supli. peq. 10$') then
				TriggerServerEvent('carroca:buyvehicle', 10, 'CART03')
				elseif WarMenu.Button('Carroça 4 Pessoas 15$') then
				TriggerServerEvent('carroca:buyvehicle', 15, 'COACH6')
				elseif WarMenu.Button('Carroça Cabine Fechada 4P 20$') then
				TriggerServerEvent('carroca:buyvehicle', 20, 'COACH5')
				elseif WarMenu.Button('Carroça Cabine Fechada 6P 20$') then
				TriggerServerEvent('carroca:buyvehicle', 20, 'COACH3')
				elseif WarMenu.Button('Carroça transporte Aberta 20$') then
				TriggerServerEvent('carroca:buyvehicle', 20, 'WAGON03X')
				elseif WarMenu.Button('Carroça Transporte de Luxo 30$') then
				TriggerServerEvent('carroca:buyvehicle', 30, 'STAGECOACH001X')
				elseif WarMenu.Button('Carroça Transporte de Supli. 20$') then
				TriggerServerEvent('carroca:buyvehicle', 20, 'supplywagon')
				WarMenu.Display()	
			end		
			WarMenu.Display()	
		end
	for k,v in pairs(Config.Coords) do
			if Vdist(coords, v) < 2 then
				DrawTxt(Config.Shoptext,  0.78, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
				if IsControlJustReleased(0, keys['E']) then
					WarMenu.OpenMenu('Shopcarroca')
				end
			end
		end
	end
end)

RegisterNetEvent('Message:cancel')	
AddEventHandler('Message:cancel', function()
local timer = 200
	while timer > 0 do
		Citizen.Wait(0)
		DrawTxt(Config.NoMoney, 0.50, 0.90, 0.6, 0.6, true, 161, 3, 0, 255, true, 10000)
		timer = timer - 1
	end
end)

RegisterNetEvent('carrocaspawn:vehicle')
AddEventHandler('carrocaspawn:vehicle', function(vehicle)
		local veiculo = vehicle	
		WarMenu.CloseMenu()
		SpawnVehicle(vehicle, GetPlayerPed())	   		   
    	local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)	
end)

function SpawnVehicle(Vmodel,ply)
    local veh = GetHashKey(Vmodel)
    local coords = GetEntityCoords(ply)
    local head = GetEntityHeading(ply)
    Citizen.CreateThread(function()
        RequestModel(veh)
        while not HasModelLoaded(veh) do
            Wait(1000)
            print("Loading Model: "..Vmodel.."Loading Hash: "..veh)
        end
        local car = CreateVehicle(veh,tonumber(coords.x+10),tonumber(coords.y+5),coords.z-2.5,head,true,true,false,true)
			print("Model spawned Succes: "..Vmodel)
			-- SetModelAsNoLongerNeeded(veh)
			SetPedIntoVehicle(PlayerPedId(), car, -1)
		
    end)
end


function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    --Citizen.InvokeNative(0x66E0276CC5F6B9DA, 2)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end
