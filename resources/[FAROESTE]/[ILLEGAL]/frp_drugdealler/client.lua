local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

cAPI = Proxy.getInterface('API')
API = Tunnel.getInterface('API')

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local porcentagem = 0
local CoordenadaX = 2384.511
local CoordenadaY = -1163.893
local CoordenadaZ = 45.498



-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = {['x'] = 2715.192,  ['y'] = -968.919,  ['z'] =  44.882},
	[2] = {['x'] = 2753.752,  ['y'] = -916.901,  ['z'] =  44.077},
	[3] = {['x'] = 2563.352,  ['y'] = -916.587,  ['z'] =  43.084},
	[4] = {['x'] = 2748.204,  ['y'] = -1171.547, ['z'] =  52.515},
	[5] = {['x'] = 2862.136,  ['y'] = -1150.998, ['z'] =  47.119},
	[6] = {['x'] = 2547.547,  ['y'] = -1114.459, ['z'] =  53.715},
	[7] = {['x'] = 2373.469,  ['y'] = -1164.849, ['z'] =  47.474},
	[8] = {['x'] = 2387.023,  ['y'] = -1263.916, ['z'] =  46.479}
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZAndNormalFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

			if distance <= 30.0 and not StartDrugs then
				Citizen.InvokeNative(0x2A32FAA57B937173,0x6903B113, CoordenadaX,CoordenadaY,CoordenadaZ-0.97, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 20, 0, 0, 2, 0, 0, 0, false)    
				if distance <= 1.2 then
					DrawText("PRESSIONE  ~b~ALT~w~  PARA PEGAR AS ROTAS" , 0.925, 0.96, 0.25, 0.25, false, 255, 255, 255, 145, 1, 7)
					if IsControlJustPressed(0, 0xE8342FF2) then
						servico = true
						selecionado = math.random(1,8)
						CriandoBlip(locs,selecionado)
					end
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZAndNormalFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z, 1)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

			if distance <= 30.0 then
				Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.97, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 20, 0, 0, 2, 0, 0, 0, false)    
				if distance <= 1.2 then
					DrawText("PRESSIONE  ~b~E~w~  PARA ENTREGAR" , 0.925, 0.96, 0.25, 0.25, false, 255, 255, 255, 145, 1, 7)
					if IsControlJustPressed(0, 0xE8342FF2) then
						TriggerServerEvent("FRP:CONTRABANDO:checkPayment")
						Citizen.Wait(1000)
						if checkPayment then	
							Citizen.Wait(1)
							porcentagem = math.random(100)
							if porcentagem >= 90 then
								TriggerServerEvent("FRP:CONTRABANDO:ocorrencia")
							end
							RemoveBlip(blip)
							print(backentrega)
							backentrega = selecionado
							while true do
								if backentrega == selecionado then
									selecionado = math.random(1,8)
								else
									break
								end
								Citizen.Wait(1)
							end
							CriandoBlip(locs,selecionado)
							checkPayment = false
						end
					end
				end
			end
		end
	end
end)

RegisterCommand("callp", function()

	TriggerServerEvent("FRP:CONTRABANDO:ocorrencia")

end)

RegisterNetEvent('FRP:CONTRABANDO:checkPayment')
AddEventHandler('FRP:CONTRABANDO:checkPayment', function(bool)
	checkPayment = bool
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if servico then
			if IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blip)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre, font)
	SetTextScale(w, h)
	SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
	if enableShadow then
		SetTextDropshadow(1, 0, 0, 0, 255)
	end
	Citizen.InvokeNative(0xADA9255D, font)
	DisplayText(CreateVarString(10, "LITERAL_STRING", str), x, y)
end


function CriandoBlip(locs,selecionado)
	ClearGpsMultiRoute()
	Wait(500)	
	StartGpsMultiRoute(76603059, true, true)
	liv = AddPointToGpsMultiRoute(locs[selecionado].x, locs[selecionado].y, locs[selecionado].z)
	SetGpsMultiRouteRender(true)  

	blip = N_0x554d9d53f696d002(1664425300, locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blip, -1103135225, 1)
	SetBlipScale(blip, 0.1)
	Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Entrega')
end