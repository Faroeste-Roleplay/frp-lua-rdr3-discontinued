RegisterNetEvent("FRP:ME:DisplayAboveHeadText")
AddEventHandler(
    "FRP:ME:DisplayAboveHeadText",
    function(text, targetServerId)
        local playerPed = PlayerPedId()
        local targetPlayerPed = GetPlayerPed(GetPlayerFromServerId(targetServerId))

        if DoesEntityExist(targetPlayerPed) then
            local dist = #(GetEntityCoords(playerPed) - GetEntityCoords(targetPlayerPed))

            if dist <= 100.0 then
                local shouldDisplay = true

                Citizen.CreateThread(
                    function()
                        Citizen.Wait(7000)
                        shouldDisplay = false
                    end
                )

                Citizen.CreateThread(
                    function()
                        while shouldDisplay do
                            Citizen.Wait(0)

                            targetPlayerPed = GetPlayerPed(targetPlayer)

                            if DoesEntityExist(targetPlayerPed) then
                                local bonePosition = GetPedBoneCoords(targetPlayerPed, 21030, 0, 0, 0)

                                DrawText3D(bonePosition.x, bonePosition.y, bonePosition.z + 0.30, text)
                            else
                                break
                            end
                        end
                    end
                )
            end
        end
    end
)

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
     --   shouldDisplayText(str, _x, _y)
        local factor = (string.len(text)) / 225
        --DrawSprite("feeds", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 35, 35, 35, 190, 0)
        DrawSprite("feeds", "toast_bg", _x, _y + 0.0125, 0.015 + factor, 0.03, 0.1, 100, 1, 1, 190, 0)
    end
end
