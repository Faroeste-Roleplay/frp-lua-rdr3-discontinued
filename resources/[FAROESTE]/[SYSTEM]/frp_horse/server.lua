local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterNetEvent("VP:HORSE:RequestMyHorseInfo")
AddEventHandler(
    "VP:HORSE:RequestMyHorseInfo",
    function()
        local _source = source

        local User = API.getUserFromSource(_source)

        local Character = User:getCharacter()

        if Character == nil then
            return
        end

        local Horse = Character:getHorse()

        if Horse ~= nil then
            TriggerClientEvent("VP:HORSE:SetHorseInfo", _source, Horse:getModel(), Horse:getName(), Horse:getComponents())
        end
    end
)

RegisterNetEvent("VP:HORSE:HitCarriedPlayer")
AddEventHandler(
    "VP:HORSE:HitCarriedPlayer",
    function(playerServerId)
        local _source = source

        TriggerClientEvent("VP:HORSE:PlayBeingHitAnim", playerServerId)
    end
)
