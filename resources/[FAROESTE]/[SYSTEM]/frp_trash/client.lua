local trash = {
    "prop_bin_01a",
    50927092, -- lixeira
    -1177561480, -- carroça velha
}
local trash2 = {}

Citizen.CreateThread(function()
    Citizen.Wait(100)

    while true do
        local sleepThread = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local x
        for i = 1, #trash do
            if type(trash[i]) == "string" then
                x = Citizen.InvokeNative(0xE143FA2249364369, playerCoords, 2.0, GetHashKey(trash[i]), false, false, false)
            else
                x = Citizen.InvokeNative(0xE143FA2249364369, playerCoords, 2.0, trash[i], false, false, false)
            end
            local entity = nil
            if DoesEntityExist(x) then
                entity = x
                lixo    = GetEntityCoords(entity)   

                if DoesEntityExist(entity) <= 1.5 then
                    sleepThread = 5
                    DrawText3D(lixo.x, lixo.y, lixo.z + 1.5, 'Vasculhar [~g~E~s~]')  

                    if IsControlJustReleased(0, 0x9FA5AD07) then
                        if not trash2[entity] then
                            trash2[entity] = true

                            OpenTrashCan()
                        else
                            notify("Você já vasculhou este lixo!")
                        end
                    end
                end
            end
        end
        Citizen.Wait(sleepThread)
    end
end)

function OpenTrashCan()
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("PROP_PLAYER_LOOT_WALL_STASH"), -1, true, false, false, false)

    Citizen.Wait(10000)
    TriggerServerEvent("FRP:TRASH:receive")
    ClearPedTasks(PlayerPedId())
end

function notify(_message)
	local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", _message, Citizen.ResultAsLong())
	SetTextScale(0.15, 0.15)
	SetTextCentre(1)
	Citizen.InvokeNative(0xFA233F8FE190514C, str)
	Citizen.InvokeNative(0xE9990552DEC71600)
end

-- DrawText3D = function(x, y, z, text)
-- 	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
-- 	local px,py,pz=table.unpack(GetGameplayCamCoords())
  
-- 	local scale = 0.45
   
-- 	if onScreen then
-- 		SetTextScale(scale, scale)
-- 		SetTextFont(4)
-- 		SetTextProportional(1)
-- 		SetTextColour(255, 255, 255, 215)
-- 		SetTextOutline()
-- 		SetTextEntry("STRING")
-- 		SetTextCentre(1)
-- 		AddTextComponentString(text)
--         DrawText(_x,_y)
--         local factor = (string.len(text)) / 370
--         DrawRect(_x, _y + 0.0150, 0.030 + factor , 0.030, 66, 66, 66, 150)
-- 	end
-- end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    if onScreen then
        SetTextScale(0.25, 0.25)
        SetTextFontForCurrentCommand(1)
        SetTextColor(255, 255, 255, 215)
        SetTextCentre(1)
        DisplayText(str, _x, _y)
        local factor = (string.len(text)) / 225
        --DrawSprite("feeds", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 35, 35, 35, 190, 0)
        DrawSprite("feeds", "toast_bg", _x, _y + 0.0125, 0.015 + factor, 0.03, 0.1, 1, 1, 1, 190, 0)
    end
end
