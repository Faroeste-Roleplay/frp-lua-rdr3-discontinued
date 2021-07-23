local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent("FRP:GOLDSMITH:TryToStartMining")
AddEventHandler(
    "FRP:GOLDSMITH:TryToStartMining",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()
        local a = Inventory:getItemAmount("pickaxe")
        local ItemData = API.getItemDataFromId("pickaxe")
        if a <= 0 then
            User:notify("error", "Você nao possui uma " .. ItemData:getName())
        else
            TriggerClientEvent("FRP:GOLDSMITH:StartMiningAnimation", _source)
        end
    end
)

local weightTotal = 0
local r = {}

Citizen.CreateThread(
    function()
        r = {
            {"raw_gold", 0.1, 2}
        }

        weightTotal = 0

        for _, v in pairs(r) do
            weightTotal = weightTotal + v[2]
        end
    end
)

local found = {}

RegisterServerEvent("FRP:GOLDSMITH:CollectMineral")
AddEventHandler(
    "FRP:GOLDSMITH:CollectMineral",
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

        TriggerClientEvent("FRP:GOLDSMITH:DropMineral", _source, mineral_item)
    end
)

RegisterServerEvent("FRP:GOLDSMITH:TryToStartRefining")
AddEventHandler(
    "FRP:GOLDSMITH:TryToStartRefining",
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

RegisterServerEvent("FRP:GOLDSMITH:TryToStartRefining")
AddEventHandler(
    "FRP:GOLDSMITH:TryToStartRefining",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        local gold = false

        if Inventory:getItemAmount("raw_gold") >= 1 then
            if Character:hasGroup('miner') then
                gold = true
            end
        end

        if not gold then
            User:notify("error", "Você não tem ouro suficientes para processar!")
            return
        end

        TriggerClientEvent("FRP:GOLDSMITH:StartProcessingAnimation", _source)

        User:notify("alert", "Processando...")

        Citizen.Wait(20000)

        if gold then
            if Inventory:getItemAmount("raw_gold") >= 1 then
                Inventory:removeItem(-1, "raw_gold", 1)
            end
        end
    end
)

RegisterServerEvent("FRP:GOLDSMITH:checknum")
AddEventHandler(
    "FRP:GOLDSMITH:checknum",
    function(source, num)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        if num == 0 or num == nil then
            User:notify("error", "Erro no processamento")
            return
        end
        if num >= 4 or num == 0 then
            if Character:hasGroup("ourives") then
            else
                User:notify("error", "Você não pode processar ouro")
                return
            end
        end
        TriggerClientEvent("FRP:GOLDSMITH:processanim", _source, num)
    end
)

RegisterServerEvent("FRP:GOLDSMITH:processitem")
AddEventHandler(
    "FRP:GOLDSMITH:processitem",
    function(num)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()
        local Character = User:getCharacter()
        local count = math.random(1, 5)

        if num == 4 then
            Inventory:removeItem(-1, "generic_ourobruto", 3)
            User:notify("Você processou [X" .. count .. "] ouro")
            Wait(1000)
            print(count * 10)
            Inventory:addItem("generic_gold", count * 10)
            User:notify("Você recebeu [X" .. count .. "] de Ouro")
            return
        end
    end
)
