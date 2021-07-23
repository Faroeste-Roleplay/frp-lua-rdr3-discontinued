function VaryPlayerHorseHealth(value, makeSound, secondsTillVary)
    local playerHorse = cAPI.GetPlayerHorse()
    if playerHorse ~= nil and playerHorse ~= 0 then
        Citizen.CreateThread(
            function()
                if secondsTillVary ~= nil and secondsTillVary > 0 then
                    valuePerTick = value / secondsTillFillUp
                    while secondsTillFillUp > 0 do
                        Citizen.InvokeNative(0xC6258F41D86676E0, playerHorse, 0, GetAttributeCoreValue(playerHorse, 0) + valuePerTick)
                        -- SetAttributeCoreValue
                        SetEntityHealth(playerHorse, GetEntityHealth(playerHorse) + valuePerTick)

                        secondsTillFillUp = secondsTillFillUp - 1
                        Citizen.Wait(1000)

                        if secondsTillFillUp <= 0 then
                            NativeSetAttributeOverpowerAmount(playerHorse, 0, 0.0, false)
                        end
                    end
                else
                    NativeSetAttributeOverpowerAmount(playerHorse, 0, GetAttributeCoreValue(playerHorse, 0) + value, makeSound or false)
                    Citizen.InvokeNative(0xC3D4B754C0E86B9E, playerHorse, value)
                    NativeSetAttributeOverpowerAmount(playerHorse, 0, 0.0, false)
                end
            end
        )
    end
end

function VaryPlayerHorseStamina(value, makeSound, secondsTillVary)
    -- local playerHorse = cAPI.GetPlayerHorse()
    -- if playerHorse ~= nil and playerHorse ~= 0 then
    -- Citizen.InvokeNative(0xC3D4B754C0E86B9E , playerHorse, -1000.0)
    -- print('core ', Citizen.InvokeNative(0x775A1CA7893AA8B5 , playerHorse, Citizen.ResultAsFloat()))
    -- Citizen.InvokeNative(0xC6258F41D86676E0, playerHorse, 1, GetAttributeCoreValue(playerHorse, 1) + value)-- SetAttributeCoreValue
    -- end
end

function NativeSetAttributeOverpowerAmount(ped, coreIndex, value, makeSound)
    Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, coreIndex, value, makeSound)
end

function NativeGetPlayerHorseMaxStamina()
    return Citizen.InvokeNative(0xCB42AFE2B613EE55, cAPI.GetPlayerHorse())
end

function NativeGetPlayerHorseStamina()
    return Citizen.InvokeNative(0x775A1CA7893AA8B5,  cAPI.GetPlayerHorse())
end

function NativeGetHorseHealthCore()
    return GetAttributeCoreValue(cAPI.GetPlayerHorse(), 0)
end

function NativeGetHorseStaminaCore()
    return GetAttributeCoreValue(cAPI.GetPlayerHorse(), 1)
end

function NativeSetHorseStaminaCore(value)
    Citizen.InvokeNative(0xC6258F41D86676E0, cAPI.GetPlayerHorse(), 1, value)
end

function NativeChargePlayerHorseStamina(value)
    --    local percentOfStamina = (value / 100) * NativeGetPlayerHorseMaxStamina()
    --    print(percentOfStamina, NativeGetPlayerHorseMaxStamina)
    -- return Citizen.InvokeNative(0xC3D4B754C0E86B9E , playerHorse, value)
end

function NativeGetPlayerHorse()
    return Citizen.InvokeNative(0xB48050D326E9A2F3, PlayerId(), Citizen.ResultAsInteger())
end

function DrawLine(v1, v2, r, g, b, a)
    Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,v1, v2, r,g,b,a)
end
