frp_action = {
    name = "",
    duration = 0,
    label = "",
    useWhileDead = false,
    canCancel = true,
    controlDisables = {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    },
    animation = {
        animDict = nil,
        anim = nil,
        flags = 0,
        task = nil,
    },
    prop = {
        model = nil,
    },
}

local isDoingAction = false
local disableMouse = false
local wasCancelled = false
local isAnim = false
local isProp = false
local prop_net = nil

RegisterNetEvent("frp_progressbar:client:progress")
AddEventHandler("frp_progressbar:client:progress", function(action, cb)
    frp_action = action

    if not IsEntityDead(GetPlayerPed(-1)) or frp_action.useWhileDead then
        if not isDoingAction then
            isDoingAction = true
            wasCancelled = false
            isAnim = false
            isProp = false

            SendNUIMessage({
                action = "frp_progress",
                duration = frp_action.duration,
                label = frp_action.label
            })

            Citizen.CreateThread(function ()
                while isDoingAction do
                    Citizen.Wait(0)
                    if IsControlJustPressed(0, 178) and frp_action.canCancel then
                        TriggerEvent("frp_progressbar:client:cancel")
                    end
                end
                if cb ~= nil then
                    cb(wasCancelled)
                end
            end)
        else
            print('Action Already Performing') -- Replace with alert call if you want the player to see this warning on-screen
        end
    else
        print('Cannot do action while dead') -- Replace with alert call if you want the player to see this warning on-screen
    end
end)

RegisterNetEvent("frp_progressbar:client:cancel")
AddEventHandler("frp_progressbar:client:cancel", function()
    isDoingAction = false
    wasCancelled = true

    TriggerEvent("frp_progressbar:client:actionCleanup")

    SendNUIMessage({
        action = "frp_progress_cancel"
    })
end)

RegisterNetEvent("frp_progressbar:client:actionCleanup")
AddEventHandler("frp_progressbar:client:actionCleanup", function()
    local ped = PlayerPedId()
    ClearPedTasks(ped)
    StopAnimTask(ped, frp_action.animDict, frp_action.anim, 1.0)
    DetachEntity(NetToObj(prop_net), 1, 1)
    DeleteEntity(NetToObj(prop_net))
    prop_net = nil
end)

-- Disable controls while GUI open
Citizen.CreateThread(function()
    while true do
        if isDoingAction then
            if not isAnim then
                if frp_action.animation ~= nil then
                    if frp_action.animation.task ~= nil then
                        TaskStartScenarioInPlace(PlayerPedId(), frp_action.animation.task, 0, true)
                    elseif frp_action.animation.animDict ~= nil and frp_action.animation.anim ~= nil then
                        if frp_action.animation.flags == nil then
                            frp_action.animation.flags = 1
                        end

                        local player = PlayerPedId()
                        if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
                            loadAnimDict( frp_action.animation.animDict )
                            TaskPlayAnim( player, frp_action.animation.animDict, frp_action.animation.anim, 3.0, 1.0, -1, frp_action.animation.flags, 0, 0, 0, 0 )     
                        end
                    else
                        TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)
                    end
                end

                isAnim = true
            end
            if not isProp and frp_action.prop ~= nil and frp_action.prop.model ~= nil then
                RequestModel(frp_action.prop.model)

                local toHash = GetHashKey(frp_action.prop.model)
                while not HasModelLoaded(toHash) do
                    Citizen.Wait(0)
                end

                local pCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, 0.0)
                local modelSpawn = CreateObject(toHash, pCoords.x, pCoords.y, pCoords.z, true, true, true)

                local netid = ObjToNet(modelSpawn)
                SetNetworkIdExistsOnAllMachines(netid, true)
                NetworkSetNetworkIdDynamic(netid, true)
                SetNetworkIdCanMigrate(netid, false)
                AttachEntityToEntity(modelSpawn, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
                prop_net = netid

                isProp = true

                -- SetModelAsNoLongerNeeded(toHash)
            end

            DisableActions(GetPlayerPed(-1))
        end
        Citizen.Wait(0)
    end
end)

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function DisableActions(ped)
    if frp_action.controlDisables.disableMouse then
        DisableControlAction(0, 1, true) -- LookLeftRight
        DisableControlAction(0, 2, true) -- LookUpDown
        DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
    end

    if frp_action.controlDisables.disableMovement then
        DisableControlAction(0, 30, true) -- disable left/right
        DisableControlAction(0, 31, true) -- disable forward/back
        DisableControlAction(0, 36, true) -- INPUT_DUCK
        DisableControlAction(0, 21, true) -- disable sprint
    end

    if frp_action.controlDisables.disableCarMovement then
        DisableControlAction(0, 63, true) -- veh turn left
        DisableControlAction(0, 64, true) -- veh turn right
        DisableControlAction(0, 71, true) -- veh forward
        DisableControlAction(0, 72, true) -- veh backwards
        DisableControlAction(0, 75, true) -- disable exit vehicle
    end

    if frp_action.controlDisables.disableCombat then
        DisablePlayerFiring(ped, true) -- Disable weapon firing
        DisableControlAction(0, 24, true) -- disable attack
        DisableControlAction(0, 25, true) -- disable aim
        DisableControlAction(1, 37, true) -- disable weapon select
        DisableControlAction(0, 47, true) -- disable weapon
        DisableControlAction(0, 58, true) -- disable weapon
        DisableControlAction(0, 140, true) -- disable melee
        DisableControlAction(0, 141, true) -- disable melee
        DisableControlAction(0, 142, true) -- disable melee
        DisableControlAction(0, 143, true) -- disable melee
        DisableControlAction(0, 263, true) -- disable melee
        DisableControlAction(0, 264, true) -- disable melee
        DisableControlAction(0, 257, true) -- disable melee
    end
end

RegisterNUICallback('actionFinish', function(data, cb)
    -- Do something here
    isDoingAction = false
    TriggerEvent("frp_progressbar:client:actionCleanup")
    cb('ok')
end)

RegisterNUICallback('actionCancel', function(data, cb)
    -- Do something here
    cb('ok')
end)
