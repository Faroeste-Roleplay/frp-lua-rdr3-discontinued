local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local playersDamages = {}

-- RegisterServerEvent("FRP:Respawn:_Dead")
-- AddEventHandler(
--     "FRP:Respawn:_Dead",
--     function()
--         local _source = source
--         local User = API.getUserFromSource(_source)
--         local Character = User:getCharacter()

--         if Character ~= nil then
--             -- Character:setDeath(0)

--             -- local Inventory = Character:getInventory()
--             -- Inventory:clear()
--         end
--     end
-- )

-- RegisterServerEvent("FRP:RESPAWN:onPlayerDeath")
-- AddEventHandler(
--     "FRP:RESPAWN:onPlayerDeath",
--     function(data)
--         local _source = source
--         local User = API.getUserFromSource(_source)
--         local Character = User:getCharacter()

--         if data ~= nil then
--             Character:setDeath(1)
--         else
--             Character:setDeath(0)
--         end
--     end
-- )

RegisterServerEvent("FRP:RESPAWN:SetPlayerAsDead")
AddEventHandler(
    "FRP:RESPAWN:SetPlayerAsDead",
    function(bool)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if Character ~= nil then
            Character:setDeath(tonumber(bool))
        end
    end
)

RegisterServerEvent("FRP:RESPAWN:SetPlayerDamage")
AddEventHandler(
    "FRP:RESPAWN:SetPlayerDamage",
    function(data)

        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if Character ~= nil then
            if playersDamages[source] == nil then
                table.insert(playersDamages, {[tostring(source)] = data})       
            else
                playersDamages[source] = {[tostring(source)] = data}
            end     
        end 
    end
)

RegisterServerEvent("FRP:RESPAWN:SetPlayerAsAliveAndClearInventory")
AddEventHandler(
    "FRP:RESPAWN:SetPlayerAsAliveAndClearInventory",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if Character ~= nil then
            Character:setDeath(0)

            local Inventory = Character:getInventory()
         --   Inventory:clear()
        end
    end
)

RegisterServerEvent("FRP:RESPAWN:CheckDeath")
AddEventHandler(
    "FRP:RESPAWN:CheckDeath",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if Character:getDeath() == 1 then
            TriggerClientEvent("FRP:RESPAWN:PlayerDead", _source)
        end
    end
)

-- RegisterServerEvent("FRP:Respawn:checkgroup")
-- AddEventHandler(
--     "FRP:Respawn:checkgroup",
--     function(spawn)
--         local _source = source
--         local User = API.getUserFromSource(_source)
--         local Character = User:getCharacter()

--         if (Character:hasGroup("vip1") or Character:hasGroup("vip2") or Character:hasGroup("vip3")) then
--             TriggerClientEvent("FRP_respawn:respawnvip", _source)
--         else
--             TriggerClientEvent("FRP_respawn:respawn", _source, spawn)
--         end
--     end
-- )
