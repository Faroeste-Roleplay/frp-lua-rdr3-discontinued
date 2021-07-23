local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local gui = false
local currentlyInGame = false
local passed = false

<<<<<<< HEAD
RegisterCommand('lockpick', function()
  lockpick(100,50,10,5)
end)


function lockpick(pickhealth,pickdamage,pickPadding,distance)
  openGui()
  play(pickhealth,pickdamage,pickPadding,distance)
  currentlyInGame = true
  while currentlyInGame do
    Wait(400)
    if IsEntityDead(PlayerPedId()) then 
      closeGui()
=======
local doorHashBeingLockpicked

RegisterNetEvent("FRP:LOCKPICK:StartLockpicking")
AddEventHandler(
    "FRP:LOCKPICK:StartLockpicking",
    function()
        local doorHash = exports.vp_doorcontainer:GetRegisteredDoorHashInRadius(1.5, 1)

        if doorHash then
            TriggerServerEvent("OutPost:InvadeOutpostAlert")

            local doorEntity = Citizen.InvokeNative(0xF7424890E4A094C0, doorHash)

            doorHashBeingLockpicked = doorHash

            lockpick(100, 10, 10, 10)
        else
            cAPI.notify("error", "Nenhum trancada porta por perto!")
        end
    end
)

function lockpick(pickhealth, pickdamage, pickPadding, distance)
    openGui()
    play(pickhealth, pickdamage, pickPadding, distance)
    currentlyInGame = true
    while currentlyInGame do
        Wait(400)
        if IsEntityDead(PlayerPedId()) then
            closeGui()
        end
>>>>>>> 1d2abd1b7bbbe0754e106a07faea9f87e272302d
    end

    if passed then
        return 100
    else
        return 0
    end
end

function openGui()
    gui = true
    SetNuiFocus(true, true)
    SendNUIMessage({openPhone = true})
end

function play(pickhealth, pickdamage, pickPadding, distance)
    SendNUIMessage({openSection = "playgame", health = pickhealth, damage = pickdamage, padding = pickPadding, solveDist = distance})
end

function CloseGui()
    currentlyInGame = false
    gui = false
    SetNuiFocus(false, false)
    SendNUIMessage({openPhone = false})
end

-- NUI Callback Methods
RegisterNUICallback(
    "close",
    function(data, cb)
        passed = false
        CloseGui()
        cb("ok")

        doorHashBeingLockpicked = nil
    end
)

RegisterNUICallback(
    "failure",
    function(data, cb)
        passed = false
        CloseGui()
        cb("ok")

        doorHashBeingLockpicked = nil

        TriggerServerEvent("FRP:LOCKPICKING:FailedLockpicking")
    end
)

RegisterNUICallback(
    "complete",
    function(data, cb)
        passed = true
        CloseGui()
        cb("ok")

        TriggerServerEvent("FRP:LOCKPICKING:SuccededLockpicking", doorHashBeingLockpicked)

        doorHashBeingLockpicked = nil
    end
)
