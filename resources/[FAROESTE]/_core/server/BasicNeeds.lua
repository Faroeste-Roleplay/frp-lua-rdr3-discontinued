local gHunger = 0.0
local gThirst = 0.0

function API.varyHunger(variation)
    local _source = source
    local User = API.getUserFromSource(_source)
    if User == nil then
        return
    end
    local Character = User:getCharacter()
    if Character == nil then
        return
    end

    local hunger = json.decode(Character:getData(Character:getId(), 'metaData', 'hunger'))
    hunger = tonumber(hunger)

    if hunger then
        local was_starving = hunger >= 100
        hunger = hunger + variation
        local is_starving = hunger >= 100

        local overflow = hunger - 100
        if overflow > 0 then
            cAPI.VaryPlayerHealth(_source, -overflow * 8)
        end

        if hunger < 0 then
            hunger = 0
        elseif hunger > 100 then
            hunger = 100
        end
        gHunger = tonumber(math.floor(hunger * 100) / 100)

        Character:setData(Character:getId(), 'metaData', 'hunger', gHunger)        
        updateSocialNeeds(_source, _source)
    end
end

function API.varyThirst(variation)
    
    local _source = source
    local User = API.getUserFromSource(_source)

    if User == nil then
        return
    end

    local Character = User:getCharacter()

    if Character == nil then
        return
    end

    local thirst = json.decode(Character:getData(Character:getId(), 'metaData', 'thirst'))
    thirst = tonumber(thirst)

    if thirst then
        local was_starving = thirst >= 100
        thirst = thirst + variation
        local is_starving = thirst >= 100

        local overflow = thirst - 100
        if overflow > 0 then
            cAPI.VaryPlayerHealth(_source, -overflow * 8)
        end

        if thirst < 0 then
            thirst = 0
        elseif thirst > 100 then
            thirst = 100
        end

        gThirst = tonumber(math.floor(thirst * 100) / 100)

        Character:setData(Character:getId(), 'metaData', 'thirst', gThirst)
        updateSocialNeeds(_source, _source)
    end
end

function updateSocialNeeds(src)
    local _source = src
    TriggerClientEvent('BasicNeeds.update', _source, gHunger, gThirst)
end
