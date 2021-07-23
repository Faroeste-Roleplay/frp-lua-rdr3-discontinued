local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterNetEvent("FRP:SHOP:TryToOpen")
AddEventHandler(
    "FRP:SHOP:TryToOpen",
    function(shopIndex)
        local _source = source

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        local shop_data = Config.Shops[shopIndex]

        local shop_type = shop_data.type
        local shop_group = shop_data.group

        if shop_group and not Character:hasGroupOrInheritance(shop_group) then
            User:notify("Não tem permissão!")
            return
        end

        local Inventory = Character:getInventory()

        local inv_amount_dollar = Inventory:getItemAmount("money") / 100
        local inv_amount_gold = Inventory:getItemAmount("gold") / 100
        local inv_weight = Inventory:getWeight()
        local inv_capacity = Inventory:getCapacity()

        local char_level = Character:getLevel()

        local dollar_weight = API.getItemDataFromId("money"):getWeight()
        local gold_weight = API.getItemDataFromId("gold"):getWeight()

        local r = {}

        for transactionIndex, t_d in pairs(shop_data.transactions) do
            local isActive = false

            local transaction_item = t_d.item
            local transaction_amount = t_d.amount or 1
            local transaction_dollar = t_d.dollar or 0
            local transaction_gold = t_d.gold or 0
            local transaction_level = t_d.level or 0
            local transaction_override_group = t_d.override_group

            if shop_type == "buy" then
                if inv_amount_dollar >= transaction_dollar or inv_amount_gold >= transaction_gold then
                    if char_level >= transaction_level then
                        if not transaction_override_group or Character:hasGroupOrInheritance(transaction_override_group) then
                            isActive = true
                        end
                    end
                end
            elseif shop_type == "sell" then
                local inv_item_amount = Inventory:getItemAmount(transaction_item) or 0

                -- local transaction_item_data = API.getItemDataFromId(transaction_item)
                -- local transaction_item_weight = transaction_item_data:getWeight()

                -- local weight_transaction_dollar = (dollar_weight * transaction_dollar)
                -- local weight_transaction_gold = (gold_weight * transaction_gold)

                -- if ((inv_weight + weight_transaction_dollar) <= inv_capacity) or ((inv_weight + weight_transaction_gold) <= inv_capacity) then
                if inv_item_amount >= transaction_amount then
                    if char_level >= transaction_level then
                        if not transaction_override_group or Character:hasGroupOrInheritance(transaction_override_group) then
                            isActive = true
                        end
                    end
                end
            -- else
            --     print("Havent got space")
            -- end
            end

            if isActive then
                r[transactionIndex] = true
            end
        end

        TriggerClientEvent("FRP:SHOP:OpenNUI", _source, shopIndex, r)
    end
)

RegisterNetEvent("FRP:SHOP:Transaction")
AddEventHandler(
    "FRP:SHOP:Transaction",
    function(shopIndex, transactionIndex, transactionType)
        local _source = source

        local shop_data = Config.Shops[shopIndex]

        local shop_type = shop_data.type

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local Inventory = Character:getInventory()

        local transaction_data = shop_data.transactions[transactionIndex]

        local transaction_item = transaction_data.item
        local transaction_amount = transaction_data.amount or 1
        local transaction_price = (transaction_data.dollar or 0) * 100
        local transaction_level = transaction_data.level or 0
        local transaction_override_group = transaction_data.override_group

        if Character:getLevel() < transaction_level then
            User:notify("error", "Level mínimo para comprar este item é " .. transaction_level .. "!")
            return
        end

        if transaction_override_group and not Character:hasGroupOrInheritance(transaction_override_group) then
            User:notify("error", "Você não tem permissão!")
            return
        end

        if shop_type == "buy" then
            local currency_item = "money"

            if transactionType == 1 then
                if not transaction_data.gold then
                    print("GENERIC_SHOP: error 400 ", shopIndex, transactionIndex, transaction_item)
                    return
                end

                currency_item = "gold"
                transaction_price = (transaction_data.gold * 100)
            end

            if Inventory:getItemAmount(currency_item) < transaction_price then
                User:notify("error", "Dinheiro insuficiente!")
                return
            end

            local transaction_item_itemdata = API.getItemDataFromId(transaction_item)
            local transaction_item_itemdata_weight = transaction_item_itemdata:getWeight()

            local has_space_clearence = (Inventory:getWeight() + (transaction_item_itemdata_weight * transaction_amount)) < Inventory:getCapacity()

            if not has_space_clearence then
                User:notify("error", "Aforje sem espaço!")
                return
            end

            if Inventory:removeItem(-1, currency_item, transaction_price) then
                Inventory:addItem(transaction_item, transaction_amount)
                User:notify("item", transaction_item, transaction_amount)

                if transaction_price > 0 then
                    User:notify("item", currency_item, -(transaction_price))
                end
            end
        elseif shop_type == "sell" then
            if Inventory:getItemAmount(transaction_item) < transaction_amount then
                User:notify("error", "Você não tem items suficientes!")
                return
            end

            if Inventory:addItem("money", transaction_price) then
                Inventory:removeItem(-1, transaction_item, transaction_amount)

                User:notify("item", transaction_item, -(transaction_amount))
                User:notify("item", "money", transaction_price)
            end
        end
    end
)
