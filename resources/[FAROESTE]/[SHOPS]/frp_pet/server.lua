local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

-- RegisterServerEvent('FRP:PET:buydog')
-- AddEventHandler('FRP:PET:buydog', function(dog)
--     local _source = source
--     local User = API.getUserFromSource(_source)
--     local Inventory = User:getCharacter():getInventory()
-- 	if Inventory:getItemAmount('money') < 2 then
--         User:notify('Dinheiro insuficiente!')
--         return
--     end
--     TriggerClientEvent('FRP:PET:spawndog', _source, dog.Model, false)
-- end)

RegisterServerEvent("FRP:PET:buydog")
AddEventHandler(
    "FRP:PET:buydog",
    function(args)
        local _src = source
        local _price = args["Price"]
        local _level = args["Level"]
        local _model = args["Model"]
        local User = API.getUserFromSource(_src)
        local Character = User:getCharacter()
        local Inventory = User:getCharacter():getInventory()
        local u_level = User:getCharacter():getLevel()
        local _resul = Character:getData(Character:getId(), "metaData", "dog")

        if Inventory:getItemAmount("money") < tonumber(_price * 100) then
            User:notify("error", "Dinheiro insuficiente!")
            return
        end

        if u_level < _level then
            User:notify("error", "Level insuficiente!")
            return
        end

        TriggerClientEvent("FRP:PET:spawndog", _src, _model, true)
        -- print(_resul)

        if _resul == nil then
            Inventory:removeItem(-1, "money", tonumber(_price * 100))
            Character:setData(Character:getId(), "metaData", "dog", _model)
            User:notify("success", "Você comprou um novo animal de estimação.")
        else
            Character:remData(Character:getId(), "metaData", "dog")
            Wait(500)
            Inventory:removeItem(-1, "money", tonumber(_price * 100))
            Character:setData(Character:getId(), "metaData", "dog", _model)
            User:notify("success", "Você comprou um novo animal de estimação.")
        end
    end
)

RegisterServerEvent("FRP:PET:loaddog")
AddEventHandler(
    "FRP:PET:loaddog",
    function()
        local _src = source
        local User = API.getUserFromSource(_src)
        local Character = User:getCharacter()

        if Character == nil then
            return
        end
        
        local Hasdogs = Character:getData(Character:getId(), "metaData", "dog")

        if Hasdogs ~= nil then
            local dog = Hasdogs
            -- print(dog)
            TriggerClientEvent("FRP:PET:spawndog", _src, dog, false)
        else
            -- print("Error, dog!")
        end
    end
)
