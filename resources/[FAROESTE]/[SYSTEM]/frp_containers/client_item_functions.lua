function ItemGetData(item)
    local d
    if tonumber(item) then
        -- item is a itemHash
        d = ItemPool[ItemPoolHash[item]]
    else
        -- item is a itemId
        d = ItemPool[item]
    end
    return d or {}
end

function ItemGetHashFromId(itemId)
    return ItemPoolHash[joaat(itemId)] ~= nil and joaat(itemId) or "invalid item id"
end

function ItemGetIdFromHash(itemHash)
    return ItemPoolHash[itemHash] or "invalid item hash"
end

function ItemGetName(item)
    return ItemGetData(item).name or "invalid item name"
end

function ItemGetType(item)
    return ItemGetData(item).type or "invalid item type"
end

function ItemGetMaxStackSize(item)
    return ItemGetData(item).maxStackSize or "invalid item type"
end

function ItemGetWeight(item)
    return ItemGetData(item).weight or 1.0
end

function ItemIdOrHashToHash(item)
    if not tonumber(item) then
        item = ItemGetHashFromId(item)
    end

    if ItemPoolHash[item] then
        return item
    else
        return 'invalid item'
    end
end 

function ItemIsStackable(item)
    local itemType = ItemGetType(item)

    if itemType == 'weapon' or itemType == 'weapon_melee' or itemType == 'weapon_thrown' then
        return false
    end

    return true
end