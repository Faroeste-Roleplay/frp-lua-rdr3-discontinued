vp_action = {
    name = "",
    duration = 0,
    label = "",
    useWhileDead = false,
    canCancel = true,
	disarm = true,
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
        bone = nil,
        coords = { x = 0.0, y = 0.0, z = 0.0 },
        rotation = { x = 0.0, y = 0.0, z = 0.0 },
    },
    propTwo = {
        model = nil,
        bone = nil,
        coords = { x = 0.0, y = 0.0, z = 0.0 },
        rotation = { x = 0.0, y = 0.0, z = 0.0 },
    },
}

local isDoingAction = false
local disableMouse = false
local wasCancelled = false
local isAnim = false
local isProp = false
local isPropTwo = false
local prop_net = nil
local propTwo_net = nil
local runProgThread = false

function Progress(action, finish)
	Process(action, nil, nil, finish)
end

function ProgressWithStartEvent(action, start, finish)
	Process(action, start, nil, finish)
end

function ProgressWithTickEvent(action, tick, finish)
	Process(action, nil, tick, finish)
end

function ProgressWithStartAndTick(action, start, tick, finish)
	Process(action, start, tick, finish)
end

function Process(action, start, tick, finish)
	ActionStart()
    vp_action = action

    if not IsEntityDead(PlayerPedId()) or vp_action.useWhileDead then
        if not isDoingAction then
            isDoingAction = true
            wasCancelled = false
            isAnim = false
            isProp = false

            SendNUIMessage({
                action = "frp_progbar",
                duration = vp_action.duration,
                label = vp_action.label
            })

            Citizen.CreateThread(function ()
                if start ~= nil then
                    start()
                end
                while isDoingAction do
                    Citizen.Wait(1)
                    if tick ~= nil then
                        tick()
                    end
                    if IsControlJustPressed(0, 178) and vp_action.canCancel then
                        TriggerEvent("FRP:PROGBAR:client:cancel")
                    end

                    if IsEntityDead(PlayerPedId()) and not vp_action.useWhileDead then
                        TriggerEvent("FRP:PROGBAR:client:cancel")
                    end
                end
                if finish ~= nil then
                    finish(wasCancelled)
                end
            end)
        else
            exports['frp_notify']:SendAlert('error', 'Already Doing An Action', 1000)
        end
    else
        exports['frp_notify']:SendAlert('error', 'Cannot Perform An Action While Dead', 1000)
    end
end

function ActionStart()
    runProgThread = true
    Citizen.CreateThread(function()
        while runProgThread do
            if isDoingAction then
                if not isAnim then
                    if vp_action.animation ~= nil then
                        if vp_action.animation.task ~= nil then
                            TaskStartScenarioInPlace(PlayerPedId(), vp_action.animation.task, 0, true)
                        elseif vp_action.animation.animDict ~= nil and vp_action.animation.anim ~= nil then
                            if vp_action.animation.flags == nil then
                                vp_action.animation.flags = 1
                            end

                            local player = PlayerPedId()
                            if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
                                loadAnimDict( vp_action.animation.animDict )
                                TaskPlayAnim( player, vp_action.animation.animDict, vp_action.animation.anim, 3.0, 1.0, -1, vp_action.animation.flags, 0, 0, 0, 0 )     
                            end
                        else
                            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)
                        end
                    end

                    isAnim = true
                end
                if not isProp and vp_action.prop ~= nil and vp_action.prop.model ~= nil then
                    RequestModel(vp_action.prop.model)

                    while not HasModelLoaded(GetHashKey(vp_action.prop.model)) do
                        Citizen.Wait(0)
                    end

                    local pCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.0)
                    local modelSpawn = CreateObject(GetHashKey(vp_action.prop.model), pCoords.x, pCoords.y, pCoords.z, true, true, true)

                    local netid = ObjToNet(modelSpawn)
                    SetNetworkIdExistsOnAllMachines(netid, true)
                    NetworkSetNetworkIdDynamic(netid, true)
                    SetNetworkIdCanMigrate(netid, false)
                    if vp_action.prop.bone == nil then
                        vp_action.prop.bone = 60309
                    end

                    if vp_action.prop.coords == nil then
                        vp_action.prop.coords = { x = 0.0, y = 0.0, z = 0.0 }
                    end

                    if vp_action.prop.rotation == nil then
                        vp_action.prop.rotation = { x = 0.0, y = 0.0, z = 0.0 }
                    end

                    AttachEntityToEntity(modelSpawn, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), vp_action.prop.bone), vp_action.prop.coords.x, vp_action.prop.coords.y, vp_action.prop.coords.z, vp_action.prop.rotation.x, vp_action.prop.rotation.y, vp_action.prop.rotation.z, 1, 1, 0, 1, 0, 1)
                    prop_net = netid

                    isProp = true
                    
                    if not isPropTwo and vp_action.propTwo ~= nil and vp_action.propTwo.model ~= nil then
                        RequestModel(vp_action.propTwo.model)

                        while not HasModelLoaded(GetHashKey(vp_action.propTwo.model)) do
                            Citizen.Wait(0)
                        end

                        local pCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.0)
                        local modelSpawn = CreateObject(GetHashKey(vp_action.propTwo.model), pCoords.x, pCoords.y, pCoords.z, true, true, true)

                        local netid = ObjToNet(modelSpawn)
                        SetNetworkIdExistsOnAllMachines(netid, true)
                        NetworkSetNetworkIdDynamic(netid, true)
                        SetNetworkIdCanMigrate(netid, false)
                        if vp_action.propTwo.bone == nil then
                            vp_action.propTwo.bone = 60309
                        end

                        if vp_action.propTwo.coords == nil then
                            vp_action.propTwo.coords = { x = 0.0, y = 0.0, z = 0.0 }
                        end

                        if vp_action.propTwo.rotation == nil then
                            vp_action.propTwo.rotation = { x = 0.0, y = 0.0, z = 0.0 }
                        end

                        AttachEntityToEntity(modelSpawn, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), vp_action.propTwo.bone), vp_action.propTwo.coords.x, vp_action.propTwo.coords.y, vp_action.propTwo.coords.z, vp_action.propTwo.rotation.x, vp_action.propTwo.rotation.y, vp_action.propTwo.rotation.z, 1, 1, 0, 1, 0, 1)
                        propTwo_net = netid

                        isPropTwo = true
                    end
                end

                DisableActions(PlayerPedId())
            end
            Citizen.Wait(0)
        end
    end)
end

function Cancel()
    isDoingAction = false
    wasCancelled = true

    ActionCleanup()

    SendNUIMessage({
        action = "frp_progbar_cancel"
    })
end

function Finish()
    isDoingAction = false
    ActionCleanup()
end

function ActionCleanup()
    local ped = PlayerPedId()
    --ClearPedTasks(ped)

    if vp_action.animation ~= nil then
        if vp_action.animation.task ~= nil or (vp_action.animation.animDict ~= nil and vp_action.animation.anim ~= nil) then
            ClearPedSecondaryTask(ped)
            StopAnimTask(ped, vp_action.animDict, vp_action.anim, 1.0)
        else
            ClearPedTasks(ped)
        end
    end

    DetachEntity(NetToObj(prop_net), 1, 1)
    DeleteEntity(NetToObj(prop_net))
    DetachEntity(NetToObj(propTwo_net), 1, 1)
    DeleteEntity(NetToObj(propTwo_net))
    prop_net = nil
    propTwo_net = nil
    runProgThread = false
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function DisableActions(ped)
    if vp_action.controlDisables.disableMouse then
        DisableControlAction(0, 0xA5BDCD3C, true) -- LookLeftRight
        DisableControlAction(0, 0x430593AA, true) -- LookUpDown
    end

    if vp_action.controlDisables.disableMovement then
        DisableControlAction(0, 0xA65EBAB4, true) -- disable left/right
        DisableControlAction(0, 0x6319DB71, true) -- disable forward/back
        DisableControlAction(0, 0x05CA7C52, true) -- INPUT_DUCK
        DisableControlAction(0, 0xDEB34313, true) -- disable sprint
    end

    if vp_action.controlDisables.disableCarMovement then
    end

    if vp_action.controlDisables.disableCombat then
        DisablePlayerFiring(PlayerId(), true) -- Disable weapon firing
        DisableControlAction(0, 0x07CE1E61, true) -- disable attack
        DisableControlAction(0, 0xF84FA74F, true) -- disable aim
        DisableControlAction(1, 0xCEE12B50, true) -- disable weapon select
    end
end