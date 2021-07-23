local itemDatas = {}
local names = {}

-- local defaultItemData = API.ItemData'????????', '????????', 0.1)

function API.getItemDataFromId(id)
    return itemDatas[id]
end

function API.getItemDataFromName(name)
    if names[name] ~= nil then
        return itemDatas[names[name]]
    end
end

Citizen.CreateThread(
    function()
        for id, values in pairs(ItemList) do
            
            local ItemData = API.ItemData(id,  values.name, values.description, values.type, values.stackSize, values.weight)
            
            if values.varOnUse ~= nil then
                ItemData.varOnUse = values.varOnUse
            end

            itemDatas[id] = ItemData
            names[values.name] = id
        end
    end
)