local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

function RemoveLockpickItem(source)
    local _source = source

    local User = API.getUserFromSource(_source)
    local Character = User:getCharacter()

    if not Character then
        return
    end

    local Inventory = Character:getInventory()

    return Inventory:removeItem(-1, "lockpick", 1)
end

RegisterNetEvent("FRP:LOCKPICKING:FailedLockpicking")
AddEventHandler(
    "FRP:LOCKPICKING:FailedLockpicking",
    function()
        RemoveLockpickItem(source)
    end
)

RegisterNetEvent("FRP:LOCKPICKING:SuccededLockpicking")
AddEventHandler(
    "FRP:LOCKPICKING:SuccededLockpicking",
    function(doorHash)
        if RemoveLockpickItem(source) then
            TriggerClientEvent("FRP:DOORSTATECONTAINER:SetDoorState", -1, doorHash, true)
        end
    end
)
