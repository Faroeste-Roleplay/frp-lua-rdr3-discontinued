local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterNetEvent("FRP:HORSE:RequestMyHorseInfo")
AddEventHandler(
    "FRP:HORSE:RequestMyHorseInfo",
    function()
        local _source = source

        local User = API.getUserFromSource(_source)

        local Character = User:getCharacter()

        if Character == nil then
            return
        end

        local Horse = Character:getHorse()

        if Horse ~= nil then
            TriggerClientEvent("FRP:HORSE:SetHorseInfo", _source, Horse:getModel(), Horse:getName(), Horse:getComponents())
        end
    end
)

RegisterNetEvent("FRP:HORSE:HitCarriedPlayer")
AddEventHandler(
    "FRP:HORSE:HitCarriedPlayer",
    function(playerServerId)
        local _source = source

        TriggerClientEvent("FRP:HORSE:PlayBeingHitAnim", playerServerId)
    end
)
