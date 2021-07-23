+
local place = {
    {x = 895.39,y = -179.52,z = 74.7},
	{x = 895.39,y = -179.52,z = 73.7}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(place) do
            -- Marker (START)
           -- DrawMarker(27, place[k].x, place[k].y, place[k].z, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 0, 255, 50, 200, 0, 0, 0, 0)
			-- Marker (END)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(place) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, place[k].x, place[k].y, place[k].z)

            if dist <= 0.5 then
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					TriggerServerEvent('FRP:TITLESWASH:washMoney')
				end			
            end
        end
    end
end)