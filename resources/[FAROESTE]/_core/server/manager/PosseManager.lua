

local posses = {}

function API.createPosse(charid, name)
    local User = API.getUserFromCharId(charid)
    local members = {[charid] = 1}
    local rows = API_Database.query('FCRP/CreatePosse', {charid = charid, name = name, members = json.encode(members)})
    if #rows > 0 then
        local id = rows[1].id
        User:setPosse(id)
        local Posse = API.Posse(id, charid, name, nil)
        posses[id] = Posse
    end
end

function API.getPosse(id)
    if id ~= nil then
        if posses[id] ~= nil then
            return posses[id]
        else
            local rows = API_Database.query('FCRP/GetPosseById', {id = id})
            if #rows > 0 then
                local Posse = API.Posse(id, rows[1].charid, rows[1].name, json.decode(rows[1].members))
                posses[id] = Posse
                return Posse
            end
        end
    end

    return nil
end

function API.deletePosse(id)
    posses[id] = nil
    API_Database.execute('FCRP/PosseRoutine', {id = id, charid = 0, rank = 0, type = 'delete'})
end