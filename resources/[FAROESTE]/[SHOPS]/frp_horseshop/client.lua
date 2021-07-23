local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

cAPI = Proxy.getInterface('API')
API = Tunnel.getInterface('API')

-- local keys = {['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ['ENTER'] = 0xC7B5340A, ['E'] = 0xDFF812F9}

 promptGroup = GetRandomIntInRange(0, 0xffffff)
local prompt

-- local tempHorse

 shops = {
	{
		enteringSpot = {-366.08, 787.01, 116.17},
		horseSpot = {}
	},
	{
		enteringSpot = {-874.02, -1364.78, 43.53},
		horseSpot = {}
	},
	{
		enteringSpot = {-1777.02, -440.15, 154.96},
		horseSpot = {}
	},
	{
		enteringSpot = {2502.5, -1455.33, 46.31},
		horseSpot = {}
	},
	{
		enteringSpot = {2970.73, 1427.97, 44.71},
		horseSpot = {}
	}	
}





buyableHorses = {
	[1] = {
		['Text'] = 'Tennesseewalker Chestnut ~pa~40$',
		['SubText'] = '',
		['Model'] = 'A_C_HORSE_TENNESSEEWALKER_CHESTNUT',
		priceMoney = 40,
		priceGold = 1
	},
	[2] = {
		['Text'] = 'SHIRE RAVENBLACK ~pa~60$',
		['SubText'] = '',
		['Model'] = 'A_C_HORSE_SHIRE_RAVENBLACK',
		priceMoney = 60,
		priceGold = 1
	},
	[3] = {
		['Text'] = 'APPALOOSA LEOPARD ~pa~100$',
		['SubText'] = '',
		['Model'] = 'A_C_HORSE_APPALOOSA_LEOPARD',
		priceMoney = 100,
		priceGold = 2
	},
	[4] = {
		['Text'] = 'Mr Bill W ~pa~60$',
		['SubText'] = '',
		['Model'] = 'A_C_HORSE_GANG_BILL',
		priceMoney = 150,
		priceGold = 10
	},
	[5] = {
		['Text'] = 'Kentuckysaddle Black ~pa~70$',
		['SubText'] = '',
		['Model'] = 'A_C_HORSE_KENTUCKYSADDLE_BLACK',
		priceMoney = 35,
		priceGold = 1
	},
	[6] = {
		['Text'] = 'THOROUGHBRED BRINDLE ~pa~150$',
		['SubText'] = '',
		['Model'] = 'A_C_HORSE_THOROUGHBRED_BRINDLE',
		priceMoney = 150,
		priceGold = 10
	},
	[7] = {
		['Text'] = 'Turcomano ~pa~3500$',
		['SubText'] = '',
		['Model'] = 'A_C_HORSE_TURKOMAN_DARKBAY',
		priceMoney = 3500,
		priceGold = 30
	},
	[8] = {
		['Text'] = 'Árabe negro ~pa~5000$',
		['SubText'] = '',
		['Model'] = 'A_C_HORSE_ARABIAN_BLACK',
		priceMoney = 7000,
		priceGold = 70
	},
	[9] = {
		['Text'] = 'Árabe branco ~pa~10000$',
		['SubText'] = '',
		['Model'] = 'A_C_HORSE_ARABIAN_ROSEGREYBAY',
		priceMoney = 10000,
		priceGold = 10
	},
	[10] = {
		['Text'] = 'MUSTANG GRULLODUN ~pa~250$',
		['SubText'] = '',
		['Model'] = 'A_C_HORSE_MUSTANG_GRULLODUN',
		priceMoney = 250,
		priceGold = 2
	},
	[11] = {
		['Text'] = 'MUSTANG WILDBAY ~pa~250$',
		['SubText'] = '',
		['Model'] = 'A_C_HORSE_MUSTANG_WILDBAY',
		priceMoney = 250,
		priceGold = 2
	},
	[12] = {
		['Text'] = 'MISSOURI FOX ~pa~350$',
		['SubText'] = '',
		['Model'] = 'A_C_HORSE_MISSOURIFOXTROTTER_AMBERCHAMPAGNE',
		priceMoney = 350,
		priceGold = 3
	},
	[13] = {
		['Text'] = 'TURKOMAN GOLD ~pa~3500$',
		['SubText'] = '',
		['Model'] = 'A_C_HORSE_TURKOMAN_GOLD',
		priceMoney = 3500,
		priceGold = 35
	},
	[14] = {
		['Text'] = 'AMERICANSTANDARDBRED ~pa~350$',
		['SubText'] = '',
		['Model'] = 'A_C_HORSE_AMERICANSTANDARDBRED_PALOMINODAPPLE',
		priceMoney = 350,
		priceGold = 3
	}
}

myHorses = {}

function tryToBuyHorse(horseModel, buyWithGold)
	local horseName = cAPI.prompt('Nomeie seu Cavalo:', 'Cavalo')
	WarMenu.CloseMenu()
	if horseName ~= '' then
		TriggerServerEvent('FRP:HORSESHOP:Buy', horseModel, horseName, buyWithGold)
	end
end

-- function spawnTempHorse(selectedId)
-- 	-- vVar25 = { ENTITY::GET_OFFSET_FROM_ENTITY_GIVEN_WORLD_COORDS(uParam1->f_167.f_1768, ENTITY::GET_ENTITY_COORDS(uParam0->f_1769, true, false)) };
-- 	-- CAM::POINT_CAM_AT_ENTITY(uParam0->f_4.f_1206, uParam0->f_1768, 0.1336f, vVar25.y, vVar25.z, true);
-- 	-- Horse camera is forward vector * vec3(1, 1, 1)
-- 	tempHorse = CreatePed(selectedHorseHash, horseSpot, false, false)
-- end

function setupHorsePrompt()
	if not PromptIsValid(prompt) then
		prompt = PromptRegisterBegin()
		PromptSetControlAction(prompt, 0xE8342FF2)
		--PromptSetText(prompt, CreateVarString(10, 'LITERAL_STRING', 'Comprar Cavalo'))
		PromptSetEnabled(prompt, 1)
		PromptSetVisible(prompt, 1)
		PromptSetHoldMode(prompt, 1)

		PromptSetGroup(prompt, promptGroup)
		PromptRegisterEnd(prompt)
	end
end




Citizen.CreateThread(
	function()
		for _, values in pairs(shops) do
			local b = N_0x554d9d53f696d002(-515518185, values[1], values[2], values[3])
			SetBlipScale(b, 0.2)
			Citizen.InvokeNative(0x9CB1A1623062F402, b, 'Estábulo')
			print(json.encode(values.enteringSpot))
		end		
		while true do
			Citizen.Wait(10)

			local ped = PlayerPedId()
			local pCoords = GetEntityCoords(ped)

			for _, values in pairs(shops) do
				
				local x, y, z = table.unpack(values.enteringSpot)
				if #(pCoords - vec3(x, y, z)) <= 5 then
					if IsPedOnMount(ped) then
						PromptSetText(prompt, CreateVarString(10, 'LITERAL_STRING', 'Guardar Cavalo'))
						local horseGroupName = CreateVarString(10, 'LITERAL_STRING', 'Loja')
						PromptSetActiveGroupThisFrame(promptGroup, horseGroupName)
						if PromptHasHoldModeCompleted(prompt) then
							Citizen.Wait(1000)
							cAPI.DestroyHorse()						
						end				
					elseif not WarMenu.IsMenuOpened('horses') then
						PromptSetText(prompt, CreateVarString(10, 'LITERAL_STRING', 'Comprar Cavalo'))
						local horseGroupName = CreateVarString(10, 'LITERAL_STRING', 'Loja')
						PromptSetActiveGroupThisFrame(promptGroup, horseGroupName)
						if PromptHasHoldModeCompleted(prompt) then
							Citizen.Wait(1000)
							WarMenu.OpenMenu('horses')
						end					
					end
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		Citizen.Wait(1000)
		setupHorsePrompt()
	end
)

RegisterNetEvent('FRP:HORSESHOP:ReceiveHorsesData')
AddEventHandler(
	'FRP:HORSESHOP:ReceiveHorsesData',
	function(data)
		myHorses = data
	end
)


Citizen.CreateThread(
	function()
		WarMenu.CreateMenu('horses', 'Estabulo')
		WarMenu.SetSubTitle('horses', 'Selecione uma Opção')
		WarMenu.CreateSubMenu('horse_shop', 'horses', 'Comprar Cavalo')
		WarMenu.CreateSubMenu('my_horses', 'horses', 'Meus Cavalos')
		while true do
			if WarMenu.IsMenuOpened('horses') then
				WarMenu.MenuButton('Comprar Cavalo', 'horse_shop')

				if WarMenu.MenuButton('Meus Cavalos', 'my_horses') then
					TriggerServerEvent('FRP:HORSESHOP:AskForMyHorses')
				end

				-- if WarMenu.IsMenuAboutToBeClosed() then
				-- 	if DoesEntityExist(tempHorse) then
				-- 		DeleteVehicle(tempHorse)
				-- 		if DoesEntityExist(tempHorse) then
				-- 			DeletePed(tempHorse)
				-- 		end
				-- 	end
				-- end

				WarMenu.Display()
			end

			if WarMenu.IsMenuOpened('horse_shop') then
				for _, horseData in pairs(buyableHorses) do
					if not IsControlPressed(2, 0) then
						if WarMenu.Button(horseData['Text'], '~pa~$' .. horseData['priceMoney']) then
							tryToBuyHorse(horseData['Model'], false)
						end
					else
						if WarMenu.Button(horseData['Text'], '~g~' .. horseData['priceGold'] .. ' ouros') then
							tryToBuyHorse(horseData['Model'], false)
						end
					end
				end

				WarMenu.Display()
			end

			if WarMenu.IsMenuOpened('my_horses') then
				for _, horseData in pairs(myHorses) do
				--	print(json.encode(horseData))
					if WarMenu.Button(horseData.name .. ' ' .. horseData.model .. ' ' or 'false') then	
								
						TriggerServerEvent('FRP:HORSESHOP:SelectHorseWithId', horseData.id)
					end
				end

				WarMenu.Display()
			end

			Citizen.Wait(0)
		end
	end
)


-- AddEventHandler(
--     'onResourceStop',
--     function(resourceName)
--         if resourceName == GetCurrentResourceName() then
--             for _, prompt in pairs(prompts) do
--                 PromptDelete(prompt)
-- 			end		
--         end
--     end
-- )
