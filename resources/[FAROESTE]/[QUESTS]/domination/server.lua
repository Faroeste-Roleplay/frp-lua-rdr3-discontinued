local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")
dbAPI = Proxy.getInterface("API_DB")

local Orgs = {}

function Orgs.Create(org_name)
    local org_id

    local rows = dbAPI.query("orgs:insert", {name = name, type = "ilegal"})
    if #rows > 0 then
        org_id = rows[1].id
    end

    return org_id
end

function Orgs.Delete(org_id)
    dbAPI.execute("orgs:delete", {org_id = org_id})
end

function Orgs.GetType(org_id)
end

--[[
    Ranks:

    -1: Nenhum/Default
    1: Chefe/Dono
    ...
]]
function Orgs.AddMember(org_id, member_id, member_rank)
    dbAPI.execute("orgs:insertMember", {org_id = org_id, char_id = member_id, rank = member_rank, joined_at = date2string(os.date())})
end

function Orgs.RemoveMember(org_id, member_id)
    dbAPI.execute("orgs:removeMember", {org_id = org_id, member_id = member_id})
end

-- Poder ser o nome da org ou o id dela
function Orgs.IsMember(org, member_id)
    local my_orgs = Orgs.GetMemberOrgs(member_id)

    return Orgs.OrgListHas(my_orgs, org)
end

function Orgs.GetMemberRank(org_id, member_id)
    local member_rank

    local rows = dbAPI.execute("orgs:getMemberRank", {org_id = org_id, member_id = member_id})
    if rows[1] then
        member_rank = rows[1].rank
    end

    return member_rank
end

function Orgs.SetMemberRank(org_id, member_id, new_rank)
    dbAPI.execute("orgs:setMemberRank", {org_id = org_id, member_id = member_id, rank = new_rank})
end

function Orgs.GetControlledOutpost(org_id)
    local ret_org_id, ret_org_name

    local query = dbAPI.query("orgs:getControlledOutpost", {org_id = org_id})

    if query[1] then
        local _ = query[1]

        ret_org_id, ret_org_name = _.id, _.name
    end

    return ret_org_id, ret_org_name
end

function Orgs.GetMemberOrgs(member_id)
    local orgs = {}

    local query = dbAPI.query("orgs:getMemberOrgs", {member_id = member_id})

    if query[1] then
        local _ = query[1]

        table.insert(orgs, {org_id = _.id, org_name = _.name})
    end

    return orgs
end

function Orgs.GetMemberOrgByType(member_id, org_type)
    local org_id, org_name

    local query = dbAPI.query("orgs:getMemberOrgByType", {member_id = member_id, org_type = org_type})

    if query[1] then
        local _ = query[1]

        org_id, org_name = _.id, _.name
    end

    return org_id, org_name
end

-- @param org   // Pode ser um ID ou um NAME
function Orgs.OrgListHas(array, org)
    for org_id, org_name in pairs(array) do
        if org_id == org or org_name == id then
            return true
        end
    end

    return false
end

exports("GetMetadata", Orgs.GetMetadata)
exports("SetMetadata", Orgs.SetMetadata)
exports("AddMember", Orgs.AddMember)
exports("RemoveMember", Orgs.RemoveMember)
exports("IsMember", Orgs.IsMember)
exports("GetMemberRank", Orgs.GetMemberRank)
exports("GetControlledOutpost", Orgs.GetControlledOutpost)
exports("GetMemberOrgs", Orgs.GetMemberOrgs)
exports("UtilsArrayHasOrgName", Orgs.UtilsArrayHasOrgName)

function string2date(str)
    p = "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)"
    year, month, day, hour, min, sec = str:match(p)
    return os.time({tz = "GMT", day = day, month = month, year = year, hour = hour, min = min, sec = sec})
end

function date2string(date)
    return os.date("%Y-%m-%d %H:%M:%S", date)
end

AddEventHandler("API:OnUserCharacterInitialization", function(User, character_id)
    local rows = dbAPI.query("orgs:getMemberOrgs", {member_id = character_id})
    local myOrgs = {}
    for _, org in pairs(rows) do
        myOrgs[org.type] = { id = org.id, name = org.name, rank = org.rank}
    end
    cAPI.setMyOrg(User:getSource(), json.encode(myOrgs))
end)

RegisterNetEvent("Orgs:GetMembersOrgs")
AddEventHandler("Orgs:GetMembersOrgs", function(orgs)
    local _source = source
    local User = API.getUserFromSource(_source)
    local Character = User.getCharacter()

    local orgsMembers = { id = 0, name = "", orgs = {} }
    local orgsSql = ""
    for index=1, #orgs do
        local rows = dbAPI.query("orgs:getMembersByOrg", {org_id = orgs[index]}) 
        for _, org_member in pairs(rows) do
            print(json.encode(org_member))
            if orgsMembers.orgs[org_member.org_id] == nil then
                orgsMembers.orgs[org_member.org_id] = { type = org_member.type, members = {}}
            end
            orgsMembers.orgs[org_member.org_id].members[#orgsMembers.orgs[org_member.org_id].members+1] = { 
                member_id = org_member.member_id, 
                rank = org_member.rank, 
                name = org_member.name, 
                joined_at = string2date(org_member.joined_at)
            }
            if Character.id == org_member.member_id then
                orgsMembers.id = org_member.member_id
                orgsMembers.name = org_member.name
            end
        end
    end

    TriggerClientEvent("Orgs:GetMembersOrgs", _source, orgsMembers)
end)

local _ILEGAL_ORG_CREATION_PRICE = 100

RegisterNetEvent("Orgs:TryToCreateOrg")
AddEventHandler(
    "Orgs:TryToCreateOrg",
    function()
        local _source = source

        local User = API.getUserFromSource(_source)

        if User then
            local Character = User:getCharacter()

            if Character then
                local member_id = Character:getId()

                local hasIlegalOrg = Orgs.GetMemberOrgByType(member_id, "ilegal") == nil

                if not hasIlegalOrg then
                    local Inventory = Character:getInventory()

                    if Inventory:removeItem(-1, "money", _ILEGAL_ORG_CREATION_PRICE) then
                        local org_id = Orgs.Create(org_name)

                        if org_id then
                            Orgs.addMember(org_id, member_id, 1)

                            User:notify("success", "Organizaçao criada!")
                        else
                            User:notify("Ocorreu um erro ao criar sua org :(")
                            Inventory:addItem("money", _ILEGAL_ORG_CREATION_PRICE)
                        end
                    else
                        User:notify("Sem dinheiro")
                    end
                else
                    User:notify("Você já está em uma org")
                end
            end
        end
    end
)
