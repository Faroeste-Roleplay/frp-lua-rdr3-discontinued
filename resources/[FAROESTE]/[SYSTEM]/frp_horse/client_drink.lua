local isDrinking = false

function ActionDrink()
    local playerHorse = cAPI.GetPlayerHorse()
    TaskStartScenarioInPlace(playerHorse, GetHashKey("WORLD_ANIMAL_DONKEY_DRINK_GROUND"), 20000, true, false, false, false)
    isDrinking = true

    Citizen.CreateThread(
        function()
            while true do
                Wait(250)

                local v = NativeGetHorseStaminaCore()
                NativeSetHorseStaminaCore(v + 1)

                if GetScriptTaskStatus(playerHorse, 0x3B3A458F, 0) ~= 1 or v >= 100 then
                    break
                end

                -- if GetScriptTaskStatus(playerHorse, 0x3B3A458F, 0) ~= 1 then
                --     cAPI.notify("alert", "Cavalo parou de beber porque a animação acabou")
                --     break
                -- end

                -- if v == 100 then
                --     cAPI.notify("alert", "Cavalo parou de beber porque o core está cheio")
                --     break
                -- end
            end

            ClearPedTasks(playerHorse)
            isDrinking = false
        end
    )
end

function CanHorseDrink()
    return HasWaterNearHorseHead() and NativeGetHorseStaminaCore() < 100 and isDrinking == false
end

function HasWaterNearHorseHead()
    local playerHorse = cAPI.GetPlayerHorse()
    local min, max = GetModelDimensions(GetEntityModel(playerHorse))

    local horseCoords = GetEntityCoords(playerHorse)

    local z = min.z

    local A = GetOffsetFromEntityInWorldCoords(playerHorse, vec3(min.x, max.y, z))

    local boneIndex = GetEntityBoneIndexByName(playerHorse, "skel_head")
    local bonePosition = GetWorldPositionOfEntityBone(playerHorse, boneIndex)

    local groundCoords = vec3(bonePosition.xy, A.z)

    local waterPosition = vec3(table.unpack(exports["frp_horse"]:js_native(bonePosition.x, bonePosition.y, bonePosition.z, groundCoords.x, groundCoords.y, groundCoords.z)))

    if waterPosition.x == 127 and waterPosition.y == 0 and waterPosition.z == 0 then
        return false
    end

    -- local w = waterPosition - groundCoords

    -- print(w)

    -- if math.abs(w.z) < 1.0 then
    if IsPedSwimming(playerHorse) then
        return false
    end
    -- end

    return true
end

-- WORLD_ANIMAL_HORSE_DRINK_GROUND
-- WORLD_ANIMAL_HORSE_DRINK_GROUND_DOMESTIC
-- WORLD_ANIMAL_HORSE_GRAZING
-- WORLD_ANIMAL_HORSE_GRAZING_CAMP
-- WORLD_ANIMAL_HORSE_GRAZING_DOMESTIC
-- WORLD_ANIMAL_HORSE_INJURED_ON_GROUND
-- WORLD_ANIMAL_HORSE_INJURED_ON_GROUND_RIGHT
-- WORLD_ANIMAL_HORSE_RESTING_DOMESTIC
-- WORLD_ANIMAL_HORSE_SLEEPING
-- WORLD_ANIMAL_HORSE_SLEEPING_DOMESTIC
-- WORLD_ANIMAL_HORSE_WALLOW
