local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterNetEvent("FRP:CRAFTING:TryToOpenCrafting")
AddEventHandler(
    "FRP:CRAFTING:TryToOpenCrafting",
    function(craftingGroups)
        local _source = source

        local User = API.getUserFromSource(_source)

        local Character = User:getCharacter()

        if Character ~= nil then
            local Inventory = Character:getInventory()
            local inventory_capacity = Inventory:getCapacity()
            local inventory_weight = Inventory:getWeight()

            local cachedItemAmounts = {}

            local char_level = Character:getLevel()

            local r = {}

            for _, cGroup in pairs(craftingGroups) do
                local d = Config[cGroup]

                local level = d.craftings.level or 0

                if level ~= nil or level <= char_level then
                    for cIndex, d in pairs(d.craftings) do
                        local inputlist = d.input
                        local outputlist = d.output

                        local output_item = outputlist[1].item
                        local output_amount = outputlist[1].amount

                        local ItemData = API.getItemDataFromId(output_item)

                        output_item_weight = ItemData:getWeight()

                        local canFitOutput = ((output_item_weight * output_amount) + inventory_weight) <= inventory_capacity

                        -- ? lê todo os meus inputs necessários para esse cIndex
                        for cInputIndex, inp_d in pairs(inputlist) do
                            local item = inp_d.item
                            local amount = inp_d.amount
                            local alias = inp_d.alias

                            local inventory_item_amount = cachedItemAmounts[item] or Inventory:getItemAmount(item)

                            if inventory_item_amount <= 0 and alias then
                                for _, a_item in pairs(alias) do
                                    a_amount = Inventory:getItemAmount(a_item)
                                    if a_amount >= amount then
                                        item = a_item
                                        inventory_item_amount = a_amount
                                        break
                                    end
                                end
                            end

                            -- ? Cache o número de items já calculado, para não ter que calcular denovo
                            if not cachedItemAmounts[item] then
                                cachedItemAmounts[item] = inventory_item_amount
                            end

                            if not r[cGroup] then
                                r[cGroup] = {}
                            end

                            if not r[cGroup][cIndex] then
                                r[cGroup][cIndex] = {}
                            end

                            if inventory_item_amount >= amount and canFitOutput then
                                -- ? Nós temos a quantidade necessário desse input, então será true
                                r[cGroup][cIndex][cInputIndex] = true
                            else
                                -- ? Não temos a quantidade necessário desse input, então será bloqueado
                                r[cGroup][cIndex][cInputIndex] = false
                            end
                        end
                    end
                end
            end

            --[[
            {
                crafting = {
                    {    -- ! cIndex
                        input = {
                            true/false !
                        }
                    },
                    {
                        input = true/false
                    }
                }
            }
            ]]
            TriggerClientEvent("FRP:CRAFTING:OpenCrafting", _source, r)
        end
    end
)

RegisterNetEvent("FRP:CRAFTING:FinishedCrafting")
AddEventHandler(
    "FRP:CRAFTING:FinishedCrafting",
    function(cGroup, cIndex)
        local _source = source

        local User = API.getUserFromSource(_source)

        local Character = User:getCharacter()

        if Character ~= nil then
            local Inventory = Character:getInventory()

            local d = Config[cGroup].craftings[cIndex]

            local inputs = Config[cGroup].craftings[cIndex].input

            local output = Config[cGroup].craftings[cIndex].output[1]

            local o_item = output.item
            local o_amount = output.amount

            local ItemData = API.getItemDataFromId(o_item)

            if ItemData == nil or (ItemData:getWeight() * o_amount) > Inventory:getCapacity() then
                if ItemData == nil then
                    User:notify("error", "Output não registrado corretamente, notifique a staff")
                end

                User:notify("error", "Sem espaço no aforje!")

                return
            end

            local hasInputs = true

            for _, x in pairs(inputs) do
                local item = x.item
                local amount = x.amount
                local alias = x.alias

                if Inventory:getItemAmount(item) < amount then
                    if not alias then
                        hasInputs = false
                        break
                    else
                        local hasAnyOfTheAliases = false

                        for _, a_item in pairs(alias) do
                            if Inventory:getItemAmount(a_item) >= amount then
                                hasAnyOfTheAliases = true
                                break
                            end
                        end

                        print("hasAnyOfTheAliases", hasAnyOfTheAliases)

                        hasInputs = hasAnyOfTheAliases
                    end
                end
            end

            if hasInputs then
                for _, x in pairs(inputs) do
                    local item = x.item
                    local amount = x.amount
                    local alias = x.alias
                    local remove = x.remove or true

                    if remove then
                        if Inventory:getItemAmount(item) >= amount then
                            Inventory:removeItem(-1, item, amount)
                        else
                            if alias then
                                for _, a_item in pairs(alias) do
                                    if Inventory:getItemAmount(a_item) >= amount then
                                        Inventory:removeItem(-1, a_item, amount)
                                        break
                                    end
                                end
                            end
                        end
                    end
                end

                Inventory:addItem(o_item, o_amount)

                if not User:hasInventoryOpen() then
                    User:notify("item", o_item, o_amount)
                end
            end
        end
    end
)
