AddEventHandler(
    "FRP:EVENTS:PedFinishedGatheringEntity",
    function(ped, entity, bool_unk)
        if IsEntityAPed(entity) then
            local isHuman = IsPedHuman(entity)

            if ped == PlayerPedId() then

                local timeout = 15000
                local wait = 100

                while timeout > 0 do
                    Citizen.Wait(wait)
                    timeout = timeout - wait

                    if NativeIsEntityGathered(entity) then
                        TriggerServerEvent("FRP:GATHERING:Gathered", GetEntityModel(entity), isHuman, GetAnimalCarcassQuality(entity))
                        break
                    end
                end
            end
        end
    end
)

function GetAnimalCarcassQuality(entity)
    local ret = Citizen.InvokeNative(0x88EFFED5FE8B0B4A, entity)
    return ret ~= false and ret or 0
end

function NativeIsEntityGathered(entity)
    return Citizen.InvokeNative(0x8DE41E9902E85756, entity)
end