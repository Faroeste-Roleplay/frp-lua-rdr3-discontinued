
RegisterNetEvent('BasicNeeds.utils')
AddEventHandler('BasicNeeds.utils', function(calledFunction, ...)
	local p = promise.new()

	p:resolve({...})

	local result = Citizen.Await(p)

    print(calledFunction)

    calledFunction(table.unpack(result))

end)


function VaryPlayerHealth(variation, variationTime)
    VaryPedHealth(PlayerPedId(), variation, variationTime)
end

    
function VaryPedHealth(ped, variation, variationTime)
    if variationTime == nil or variationTime <= 1 then
        SetEntityHealth(ped, GetEntityHealth(ped) + variation)
    else
        Citizen.CreateThread(
            function()
                variationPerTick = variation / variationTime
                while true do
                    local oldValue = GetEntityHealth(ped)
                    SetEntityHealth(ped, oldValue + variationPerTick)

                    variationTime = variationTime - 1

                    if variationTime <= 0 then
                        break
                    end

                    Citizen.Wait(1000)
                end
            end
        )
    end
end

--     -1000.0 - 1000.0
function VaryPedStamina(ped, variation, variationTime)
    if variationTime == nil or variationTime <= 1 then
        -- Citizen.InvokeNative(0xC3D4B754C0E86B9E, ped, variation) -- _CHARGE_PED_STAMINA
        Citizen.InvokeNative(0x675680D089BFA21F, ped, variation) -- _RESTORE_PED_STAMINA
    else
        Citizen.CreateThread(
            function()
                variationPerTick = variation / variationTime
                while variationTime > 0 do
                    local oldValue = GetPedStamina(ped)
                    -- Citizen.InvokeNative(0xC3D4B754C0E86B9E, ped, oldValue + variationPerTick) -- _CHARGE_PED_STAMINA
                    Citizen.InvokeNative(0x675680D089BFA21F, ped, variationPerTick) -- _RESTORE_PED_STAMINA

                    variationTime = variationTime - 1

                    if variationTime <= 0 then
                        break
                    end

                    Citizen.Wait(1000)
                end
            end
        )
    end
end

function VaryPedCore(ped, core, variation, variationTime, goldenEffect)
    if variationTime == nil or variationTime <= 1 then
        local oldCoreValue = GetAttributeCoreValue(ped, core)
        Citizen.InvokeNative(0xC6258F41D86676E0, ped, core, oldCoreValue + variation)
    else
        Citizen.CreateThread(
            function()
                valuePerTick = variation / variationTime
                while true do
                    local oldCoreValue = GetAttributeCoreValue(ped, core)
                    Citizen.InvokeNative(0xC6258F41D86676E0, ped, core, oldCoreValue + valuePerTick)

                    variationTime = variationTime - 1

                    if variationTime <= 0 then
                        break
                    end

                    Citizen.Wait(1000)
                end
            end
        )
    end
end