local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent("FRP:MINING:TryToStartMining")
AddEventHandler(
    "FRP:MINING:TryToStartMining",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()
        local a = Inventory:getItemAmount("pickaxe")
        local ItemData = API.getItemDataFromId("pickaxe")
        if a <= 0 then
            User:notify("error", "Você nao possui uma " .. ItemData:getName())
        else
            TriggerClientEvent("FRP:MINING:StartMiningAnimation", _source)
        end
    end
)

local weightTotal = 0
local r = {}

Citizen.CreateThread(
    function()
        r = {
            {"raw_iron", 0.3, 5},  4.2
            {"raw_coal", 0.3, 5}, 1.0
            {"raw_copper", 0.3, 5}, 1.0
            {"raw_gold", 0.1, 2}, 7.0
        }

        weightTotal = 0

        for _, v in pairs(r) do
            weightTotal = weightTotal + v[2]
        end
    end
)

local found = {}

RegisterServerEvent("FRP:MINING:CollectMineral")
AddEventHandler(
    "FRP:MINING:CollectMineral",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        math.randomseed(os.time())

        local at = math.random() * weightTotal

        local where = 0
        for i, v in pairs(r) do
            if at < v[2] then
                where = i
                break
            end
            at = at - v[2]
        end

        local mineral_item = r[where][1]
        local itemData = API.getItemDataFromId(mineral_item)

        User:notify("alert", "Você achou " .. itemData:getName() .. "!")

        if found[_source] == nil then
            found[_source] = {}
        end

        local prev = found[_source][mineral_item] or 0

        found[_source][mineral_item] = prev + 1

        TriggerClientEvent("FRP:MINING:DropMineral", _source, mineral_item)
    end
)

-- RegisterServerEvent("FRP:MINING:TryToGetMineral")
-- AddEventHandler(
--     "FRP:MINING:TryToGetMineral",
--     function(mineral_item)
--         local _source = source
--         local User = API.getUserFromSource(_source)
--         local Character = User:getCharacter()

--         if Character == nil then
--             return
--         end

--         local Inventory = Character:getInventory()

--         if not found[_source] or not found[_source][mineral_item] then
--             return
--         end

--         local prev = found[_source][mineral_item]

--         if prev > 1 then
--             found[_source][mineral_item] = prev - 1
--         else
--             found[_source][mineral_item] = nil
--             if #found[_source] <= 0 then
--                 found[_source] = nil
--             end
--         end

--         local a = 0
--         for i, v in pairs(r) do
--             if mineral_item == v[1] then
--                 math.randomseed(os.time())
--                 a = math.random(v[3])
--                 break
--             end
--         end

--         Inventory:addItem(mineral_item, a)
--     end
-- )

RegisterServerEvent("FRP:MINING:TryToStartRefining")
AddEventHandler(
    "FRP:MINING:TryToStartRefining",
    function(mineral_item)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if Character == nil then
            return
        end

        local Inventory = Character:getInventory()
    end
)

RegisterServerEvent("FRP:MINING:TryToStartRefining")
AddEventHandler(
    "FRP:MINING:TryToStartRefining",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        local iron = false
        local coal = false
        local copper = false
        local gold = false

        if Inventory:getItemAmount("raw_iron") >= 3 then
            iron = true
        end

        if Inventory:getItemAmount("raw_coal") >= 3 then
            coal = true
        end

        if Inventory:getItemAmount("raw_copper") >= 2 then
            copper = true
        end

        if not iron and not coal and not copper and not gold then
            User:notify("error", "Você não tem minerais suficientes para processar!")
            return
        end

        TriggerClientEvent("FRP:MINING:StartProcessingAnimation", _source)

        User:notify("alert", "Processando...")

        Citizen.Wait(20000)

        if iron then
            if Inventory:getItemAmount("raw_iron") >= 3 then
                Inventory:removeItem(-1, "raw_iron", 3)
            end
        end

        if coal then
            if Inventory:getItemAmount("raw_coal") >= 3 then
                Inventory:removeItem(-1, "raw_coal", 3)
            end
        end

        if copper then
            if Inventory:getItemAmount("raw_copper") >= 2 then
                Inventory:removeItem(-1, "raw_copper", 2)
            end
        end
    end
)