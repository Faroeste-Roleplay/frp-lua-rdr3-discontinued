local isEating = false

function ActionEat()
    local playerHorse = cAPI.GetPlayerHorse()
    TaskStartScenarioInPlace(playerHorse, GetHashKey("WORLD_ANIMAL_DONKEY_GRAZING"), 20000, true, false, false, false)
    isEating = true

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
                --     cAPI.notify("alert", "Cavalo parou de comer porque a animação acabou")
                --     break
                -- end

                -- if v == 100 then
                --     cAPI.notify("alert", "Cavalo parou de comer porque o core está cheio")
                --     break
                -- end
            end

            ClearPedTasks(playerHorse)
            isEating = false
        end
    )
end

function CanHorseEat()
    return HasVegetationNearHorseHead() and NativeGetHorseStaminaCore() < 100 and isEating == false
end

function HasVegetationNearHorseHead()
    local playerHorse = cAPI.GetPlayerHorse()
    local min, max = GetModelDimensions(GetEntityModel(playerHorse))

    local horseCoords = GetEntityCoords(playerHorse)

    local z = min.z

    local A = GetOffsetFromEntityInWorldCoords(playerHorse, vec3(min.x, max.y, z))

    local boneIndex = GetEntityBoneIndexByName(playerHorse, "skel_head")
    local bonePosition = GetWorldPositionOfEntityBone(playerHorse, boneIndex)

    local groundCoords = vec3(bonePosition.xy, A.z)

    local shapeTestRay = StartShapeTestRay(bonePosition, groundCoords, 256, playerHorse, 0)

    local retVal, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(shapeTestRay)

    if hit == 0 then
        return false
    end

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
