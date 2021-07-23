local viewerOn = false

function ToggleViewer()
    viewerOn = not viewerOn

    local DRAW_LINE = GetHashKey("DRAW_LINE")

    local RANGE = 50.0

    local crosshair_size = 0.15

    if viewerOn then
        Citizen.CreateThread(
            function()
                while viewerOn do
                    Citizen.Wait(0)

                    local playerPed = PlayerPedId()
                    local playerPedPosition = GetEntityCoords(playerPed)

                    local cameraRotation = GetGameplayCamRot()
                    local direction = RotationToDirection(cameraRotation)

                    local a = GetGameplayCamCoord()
                    local b = vec3(a.x + direction.x * RANGE, a.y + direction.y * RANGE, a.z + direction.z * RANGE)

                    local distab = #(a - b)

                    DrawText3D(b.x, b.y, b.z, "X", 255, 255, 255, 255, 7, 0)

                    local selectedImaps = {}

                    for imapHash, d in pairs(all_imaps_list) do
                        local imapPosition = vec3(d.x, d.y, d.z)
                        if #(playerPedPosition - imapPosition) <= RANGE then
                            local hex = "0x" .. DEC_HEX(imapHash)

                            if math.abs(#(a - imapPosition) + #(imapPosition - b) - distab) <= 0.025 then
                                table.insert(selectedImaps, imapHash)
                            else
                                if IsImapActive(imapHash) then
                                    DrawText3D(d.x, d.y, d.z, "" .. hex, 165, 235, 124, 120, 10, 0)
                                else
                                    DrawText3D(d.x, d.y, d.z, "" .. hex, 237, 124, 116, 120, 10, 0)
                                end
                            end
                        end
                    end

                    for _, imapHash in pairs(selectedImaps) do
                        local d = all_imaps_list[imapHash]
                        local imapPosition = vec3(d.x, d.y, d.z)

                        local hex = "0x" .. DEC_HEX(imapHash)

                        DrawText3D(d.x, d.y, d.z + ((_ - 1) * 0.7), "" .. hex, 0, 100, 255, 200, 10, 0)
                    end

                    if IsControlJustPressed(0, 0xDFF812F9) then
                        for _, imapHash in pairs(selectedImaps) do
                            if IsImapActive(imapHash) then
                                RemoveImap(imapHash)
                            else
                                RequestImap(imapHash)
                            end
                        end
                    end
                end
            end
        )
    end
end

-- -2547.854,406.829,150.491

function DEC_HEX(IN)
    local B, K, OUT, I, D = 16, "0123456789ABCDEF", "", 0
    while IN > 0 do
        I = I + 1
        IN, D = math.floor(IN / B), (IN % B) + 1
        OUT = string.sub(K, D, D) .. OUT
    end
    return OUT
end

do
    ToggleViewer()
end

function RotationToDirection(rotation)
    local adjustedRotation = {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    local direction = {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }
    return direction
end

function DrawText3D(x, y, z, text, r, g, b, a, scale_multiplier, font)
    if text == "" then
        text = "UNKNOWN"
    end
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
    local dist = #(GetGameplayCamCoord() - vector3(x, y, z))
    if scale_multiplier == nil then
        scale_multiplier = 2
    end
    local scale = (1 / dist) * scale_multiplier
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextColor(r, g, b, a)
        if font ~= nil then
            Citizen.InvokeNative(0xADA9255D, font)
        end
        SetTextDropshadow(0, 0, 0, 0, 255)
        Citizen.InvokeNative(0xBE5261939FBECB8C, true)
        Citizen.InvokeNative(0xd79334a4bb99bad1, Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", text, Citizen.ResultAsLong()), _x, _y)
    end
end
