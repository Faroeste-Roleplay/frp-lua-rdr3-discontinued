function ContainerIsItemValidForIndex(container, item, index)
    --[[
        Item é nulo, então é valido para qualquer slot
    ]]
    if IsThrownInvalidException(item) then
        return true
    end

    local itemType = ItemGetType(item)

    if Containers[container].containerHasPages then
        local numIndices = Containers[container].containerNumIndices

        -- Mantimentos
        if (index >= 1) and (index <= numIndices * 1) then
            if itemType == "generic" or itemType == "consumable" then
                return true
            end
            return false
        end
        -- Tonicos
        if (index >= (numIndices * 1)) and (index < (numIndices * 2) - 1) then
            if itemType == "tonic" or itemType == "boost" then
                return true
            end
            return false
        end
        -- Mantimentos
        if (index >= (numIndices * 2)) and (index < (numIndices * 3) - 1) then
            if itemType == "food" or itemType == "beverage" then
                return true
            end
            return false
        end
        -- Equipamentos
        if (index >= (numIndices * 3)) and (index < (numIndices * 4) - 1) then
            if itemType == "weapon" or itemType == "weapon_melee" or itemType == "weapon_thrown" or itemType == "ammo" then
                return true
            end
            return false
        end
        -- Kits
        if (index >= (numIndices * 4)) and (index < (numIndices * 5) - 1) then
            if itemType == "kit" then
                return true
            end
            return false
        end
        -- Alto Valor
        if (index >= (numIndices * 5)) and (index < (numIndices * 6) - 1) then
            if itemType == "valuable" or itemType == "boost" then
                return true
            end
            return false
        end
        -- Documentos
        if (index >= (numIndices * 6)) and (index < (numIndices * 7) - 1) then
            if itemType == "document" or itemType == "map" then
                return true
            end
            return false
        end

        return false
    end

    if container == "hotbar" then
        if index == 1 or index == 2 then
            if itemType == "weapon" then
                return true
            end
        end
        if index == 3 or index == 4 then
            if itemType == "melee" or itemType == "throwable" then
                return true
            end
        end
        if index == 5 then
            return false
        end
        return false
    end

    if container == "crafting" then
        -- Crafting Output
        if index == 10 then
            return false
        end
    end

    if container == "trade-trader" then
        return false
    end

    return false
end

function ContainerGetValidIndicesForItem(container, item)
    local itemType = ItemGetType(item)

    item = ItemIdOrHashToHash(item)

    local containerItemPool = Containers[container].containerItemPool
    local numIndices = Containers[container].containerNumIndices

    local r = {}

    if Containers[container].containerHasPages then
        local function loopthrough(s, e)
            for i = s, e do
                if containerItemPool[i] == nil or containerItemPool[i][1] == item then
                    table.insert(r, i)
                end
            end
            return r
        end

        if itemType == "generic" or itemType == "consumable" then
            return loopthrough(1, numIndices)
        end
        -- Tonicos
        if itemType == "tonic" or itemType == "boost" then
            return loopthrough((numIndices * 1) + 1, (numIndices * 2))
        end
        -- Mantimentos
        if itemType == "food" or itemType == "beverage" then
            return loopthrough((numIndices * 2) + 1, (numIndices * 3))
        end
        -- Equipamentos
        if itemType == "weapon" or itemType == "weapon_melee" or itemType == "weapon_thrown" or itemType == "ammo" then
            return loopthrough((numIndices * 3) + 1, (numIndices * 4))
        end
        -- Kits
        if itemType == "kit" then
            return loopthrough((numIndices * 4) + 1, (numIndices * 5))
        end
        -- Alto Valor
        if itemType == "valuable" or itemType == "boost" then
            return loopthrough((numIndices * 5) + 1, (numIndices * 6))
        end
        -- Documentos
        if itemType == "document" or itemType == "map" then
            return loopthrough((numIndices * 6) + 1, (numIndices * 7))
        end
    else
        for i = 1, numIndices do
            if containerItemPool[i] == nil or containerItemPool[i][1] == item then
                table.insert(r, i)
            end
        end
    end

    return r
end

-- function ContainerGetValidIndicesForItem(container, item)

--     local itemType = ItemGetType(item)

--     if itemType ==
-- end

function ContainerIsValid(container)
    return Containers[container] ~= nil
end

function ContainerGetItemAtIndex(container, index)
    return Containers[container].containerItemPool[index]
end

function ContainerGetItemHashAtIndex(container, index)
    local ret

    if ContainerIsValid(container) then
        if ContainerGetItemAtIndex(container, index) ~= nil then
            ret = ContainerGetItemAtIndex(container, index)[1]
        else
            ret = "invalid item"
        end
    else
        ret = "invalid container"
    end

    return ret
end

function ContainerGetItemAmountAtIndex(container, index)
    local itemAtIndex = ContainerGetItemAtIndex(container, index)
    return 
end

function ContainerGetWeight(container)
    local total = 0

    if not Containers[container] then
        return total
    end

    for _, itemData in pairs(Containers[container].containerItemPool) do
        local itemHash = itemData[1]
        local itemAmount = itemData[2]

        local itemTotalWeight = ItemGetWeight(itemHash)

        --[[
            Verifica se o item é stackavel, então faz a computaçao
            do peso nativo do item e a quantidade dele no container
        ]]
        if ItemIsStackable(itemHash) then
            itemTotalWeight = itemTotalWeight * itemAmount
        end

        total = total + itemTotalWeight
    end

    return total
end

function ContainerGetMaxWeight(container)
    return Containers[container].containerMaxWeight or 20.0
end

function ContainerSetItemPool(container, itempool)
    Containers[container].containerItemPool = itempool
end

function ContainerSetTitle(container, title)
    Containers[container].containerTitle = title
end

function ContainerGetAmountOfItem(container, item)
    item = ItemIdOrHashToHash(item)

    local indices = ContainerGetValidIndicesForItem(container, item)

    local amount = 0

    local isStackable = ItemIsStackable(item)

    -- if #indices > 0 then
    for _, index in pairs(indices) do
        if Containers[container].containerItemPool[index] ~= nil then
            local amountAtIndex = 1

            --[[
                        Verifica se o item é stackavel, então faz a computaçao
                        da quantidade do item no container
                    ]]
            if isStackable then
                amountAtIndex = Containers[container].containerItemPool[index][2]
            end

            amount = amount + amountAtIndex
        end
    end
    -- end

    return amount
end

function ContainerTryToRemoveItem(container, item, amount)
    item = ItemIdOrHashToHash(item)

    local indices = ContainerGetValidIndicesForItem(container, item)

    local initialAmountToRemove = amount

    if #indices > 0 then
        for _, index in pairs(indices) do
            if Containers[container].containerItemPool[index] ~= nil then
                if ItemIsStackable(itemHashAtIndex) then
                    amountAtIndex = Containers[container].containerItemPool[index][2]
                else
                    amountAtIndex = 1
                end

                if amountAtIndex > amount then
                    --[[
                        Quantidade do mesmo item nesse index/slot é maior que o necessario
                        , remove só a quantidade que a gente quer
                    ]]
                    Containers[container].containerItemPool[index][2] = amountAtIndex - amount
                    amount = 0
                else
                    --[[
                        A quantidade nesse index/slot é menor ou igual ao necessario,
                        remove toda ela!
                    ]]
                    Containers[container].containerItemPool[index] = nil
                    amount = amount - amountAtIndex
                end

                if amount <= 0 then
                    --[[
                        Removemos a quantidade necessaria, não tem necessidade de continuar o loop
                    ]]
                    break
                end
            end
        end
    end

    if amount < initialAmountToRemove then
        --[[
            Alguma quantidade de item foi removida, atualiza o container
        ]]
        draw(container)
    end

    if amount <= 0 then
        --[[
            Conseguimos remove a quantidade exate dos items que queriamos,
            então retorna true
        ]]
        return true
    else
        --[[
            Alguns items foram removidos mas não a quantidade que a gente queria,
            retorna false
        ]]
        return false
    end
end

function ContainerGetItemPool(container)
    return Containers[container].containerItemPool or {}
end

function ContainerCanAddItem(container, itemdata)
    return ContainerTryToAddItem(container, itemdata, false)
end

-- itemdata = {item, itemAmount, ...}
function ContainerTryToAddItem(container, itemdata, actuallyadd)
    actuallyadd = actuallyadd or true

    itemdata[1] = ItemIdOrHashToHash(itemdata[1])

    local item = itemdata[1]
    local amount = itemdata[2] or 1

    local containerWeight = ContainerGetWeight(container)
    local containerMaxWeight = ContainerGetMaxWeight(container)

    local itemWeight = ItemGetWeight(item)

    if (containerWeight + (itemWeight * amount)) > containerMaxWeight then
        return false
    end

    local indices = ContainerGetValidIndicesForItem(container, item)

    if #indices > 0 then
        local itemMaxStackSize = ItemGetMaxStackSize(item)

        for _, index in pairs(indices) do
            local itemAtIndex = ContainerGetItemAtIndex(container, index)

            local amountToAddToIndex = 0

            --[[
                O index está livre, tenta adcionar nosso item lá
            ]]
            if itemAtIndex == nil then
                if amount > itemMaxStackSize then
                    --[[
                        A quantidade de nosso item é maior que o stack dele, teremos que
                        diminuir e adicionar só a quantidade do stack
                    ]]
                    --[[
                        deepcopy porque as tabelas são tratadas como pseudo objetos
                    ]]
                    if actuallyadd then
                        local _data_copy = deepcopy(itemdata)
                        if amount > 1 then
                            _data_copy[2] = itemMaxStackSize
                        end
                        Containers[container].containerItemPool[index] = _data_copy
                    end

                    amount = amount - itemMaxStackSize
                else
                    --[[
                        Nosso item cabe certinho nesse index, termina a função
                    ]]
                    if actuallyadd then
                        local _data_copy = deepcopy(itemdata)
                        if amount > 1 then
                            _data_copy[2] = amount
                        end
                        Containers[container].containerItemPool[index] = _data_copy
                    end

                    amount = 0
                    break
                end
            else
                --[[
                    Existe um item nesse index, verificamos se dá para incrementar na quantidade dele
                    sem passar do limite do stack
                ]]
                local amountAtIndex = Containers[container].containerItemPool[index][2] or 1

                if amountAtIndex < itemMaxStackSize then
                    if amount + amountAtIndex > itemMaxStackSize then
                        --[[
                            Nosso item + o item no index é maior que o stack, então
                            diminuimos o valor de nosso item
                        ]]
                        if actuallyadd then
                            Containers[container].containerItemPool[index][2] = itemMaxStackSize
                        end

                        amount = amount - (itemMaxStackSize - (amount + amountAtIndex))
                    else
                        if actuallyadd then
                            Containers[container].containerItemPool[index][2] = Containers[container].containerItemPool[index][2] + amount
                        end

                        amount = 0
                        break
                    end
                end
            end
        end
    end

    if amount <= 0 then
        draw(container)
    end

    return amount <= 0
end
