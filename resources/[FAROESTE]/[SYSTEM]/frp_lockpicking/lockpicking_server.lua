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

RegisterNetEvent("VP:LOCKPICKING:FailedLockpicking")
AddEventHandler(
    "VP:LOCKPICKING:FailedLockpicking",
    function()
        RemoveLockpickItem(source)
    end
)

RegisterNetEvent("VP:LOCKPICKING:SuccededLockpicking")
AddEventHandler(
    "VP:LOCKPICKING:SuccededLockpicking",
    function(doorHash)
        if RemoveLockpickItem(source) then
            TriggerClientEvent("VP:DOORSTATECONTAINER:SetDoorState", -1, doorHash, true)
        end
    end
)
