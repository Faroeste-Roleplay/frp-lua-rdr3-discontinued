local butchers = {
    vec3(-1753.07, -394.78, 156.18), --Cabana de Açougue de Strawberry
    vec3(-341.08, 767.16, 116.71), --Cabana de Açougue de Valentine
    vec3(1296.28, -1279.22, 75.84), --Cabana de Açougue de Rhodes
    vec3(-5507.733, -2947.984, -1.861), --Cabana de Açougue de Tumbleweed
    vec3(-930.643, -1392.803, 50.365)
}

local closestButcherIndex

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            closeToButcher = false

            local ped = PlayerPedId()
            local pedVec = GetEntityCoords(ped)

            local closestDist

            for _, v in pairs(butchers) do
                local dist = #(pedVec - v)
                if (dist <= 50 and closestDist == nil) or (closestDist ~= nil and dist < closestDist) then
                    closestDist = dist
                    closestButcherIndex = _
                end
            end
        end
    end
)

local lastCarriable

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            if lastCarriable ~= nil then
                local ped = PlayerPedId()

                local carrier = NativeGetCarrierAsPed(lastCarriable)

                if not DoesEntityExist(lastCarriable) or (carrier ~= 0 and carrier ~= ped) then
                    lastCarriable = nil
                else
                    local pedVec = GetEntityCoords(ped)

                    local carriableVec = GetEntityCoords(lastCarriable)

                    if #(pedVec - carriableVec) >= 500 then
                        lastCarriable = nil
                    end
                end
            end

            if closestButcherIndex ~= nil then
                local carriedEntity = GetPedCarriedEntity()
                local type = GetEntityType(carriedEntity)
                -- 1 : animal
                -- 3 : pelt
                if carriedEntity ~= false and (type == 1 or type == 3) and not IsPedHuman(carriedEntity) then
                    lastCarriable = carriedEntity
                end

                if carriedEntity == false and lastCarriable ~= nil then
                    local carriableVec = GetEntityCoords(lastCarriable)

                    local butcherVec = butchers[closestButcherIndex]

                    if #(carriableVec - butcherVec) <= 2.5 and NativeGetCarrierAsPed(lastCarriable) == 0 then
                        Citizen.InvokeNative(0x18FF3110CF47115D, lastCarriable, 2, false)
                        TriggerServerEvent("FRP:BUTCHER:TryToSell", type, GetEntityModel(lastCarriable), lastCarriable, GetAnimalCarcassQuality(lastCarriable))

                        lastCarriable = nil
                    end
                end
            end
        end
    end
)

RegisterNetEvent("FRP:BUTCHER:EntityAccepted")
AddEventHandler(
    "FRP:BUTCHER:EntityAccepted",
    function(entity)
        if DoesEntityExist(entity) then
            -- if GetEntityModel(entity) == entModel then
            Citizen.InvokeNative(0x18FF3110CF47115D, entity, 2, false)

            while GetEntityAlpha(entity) > 0 do
                Citizen.Wait(1500)
                SetEntityAlpha(entity, GetEntityAlpha(entity) - 51)
            end

            SetEntityAsMissionEntity(entity, true, true)
            DeleteEntity(entity)
            DeletePed(entity)
        -- end
        end
    end
)

RegisterNetEvent("FRP:BUTCHER:EntityNotAccepted")
AddEventHandler(
    "FRP:BUTCHER:EntityNotAccepted",
    function(entity)
        if DoesEntityExist(entity) then
            -- if GetEntityModel(entity) == entModel then
            Citizen.InvokeNative(0x18FF3110CF47115D, entity, 2, true)
        -- end
        end
    end
)

function GetPedCarriedEntity()
    return Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
end

function GetAnimalCarcassQuality(Ped)
    local ret = Citizen.InvokeNative(0x88EFFED5FE8B0B4A, Ped)
    return ret ~= false and ret or 0
end

function NativeGetCarrierAsPed(entity)
    return Citizen.InvokeNative(0x09B83E68DE004CD4, entity, Citizen.ResultAsInteger())
end
