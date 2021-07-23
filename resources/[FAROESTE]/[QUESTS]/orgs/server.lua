local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")
dbAPI = Proxy.getInterface("API_DB")

local Orgs = {}
local cacheOrgs = {}

function Orgs.Create(org_name)
    local org_id

    local rows = dbAPI.query("orgs:insert", {name = org_name, type = "ilegal"})
    if #rows > 0 then
        org_id = rows[1].id
    end

    return org_id
end

function Orgs.Delete(org_id)
    dbAPI.execute("orgs:delete", {org_id = org_id})
end

function Orgs.GetType(org_id)
    local org_type

    local rows = dbAPI.query("orgs:getOrgType", {org_id = org_id})

    if rows[1] then
        org_type = rows[1].type
    end

    return org_type
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

    local rows = dbAPI.query("orgs:getMemberRank", {org_id = org_id, member_id = member_id})
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

    if #query > 0 then
        for i = 1, #queries - 1 do
            local org_id = query[i].org_id
            local org_name = query[i].org_name

            orgs[org_id] = org_name
        end
    end

    return orgs
end

-- @param org_id
-- @return
-- {
--     org_type = "ilegal",
--     members = {
--         member_id = 1
--         member_rank = 1,
--         member_name = "Fulano de Tal",
--         member_joined_at = "2020-07-30 18:51:55",
--     }
-- }
function Orgs.GetMembersOrgAndType(org_id)
    if cacheOrgs[org_id] ~= nil then
        return cacheOrgs[org_id]
    else
        local ret = {}

        ret.members = {}

        local rows = dbAPI.query("orgs:getMembersByOrg", {org_id = org_id})

        for i = 1, #rows do
            local _ = rows[i]

            local m_d = {}
            m_d.member_id = _.member_id
            m_d.member_rank = _.rank
            m_d.member_name = _.name
            m_d.member_joined_at = _.joined_at

            if not ret.org_type then
                ret.org_type = _.type
            end

            table.insert(ret.members, m_d)
        end

        -- for _, org_member in pairs(rows) do
        --     members[org_member.member_id] = {
        --         -- member_id = org_member.member_id,
        --         member_rank = org_member.rank,
        --         member_name = org_member.name,
        --         member_joined_at = org_member.joined_at,
        --         org_id = org_member.org_id,
        --         org_type = org_member.type
        --     }
        -- end

        return ret
    end
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
-- function Orgs.ListHasOrgIdOrName(array, org)
--     for org_id, org_name in pairs(array) do
--         if org_id == org or org_name == id then
--             return true
--         end
--     end

--     return false
-- end

exports("GetMetadata", Orgs.GetMetadata)
exports("SetMetadata", Orgs.SetMetadata)
exports("AddMember", Orgs.AddMember)
exports("RemoveMember", Orgs.RemoveMember)
exports("IsMember", Orgs.IsMember)
exports("GetMemberRank", Orgs.GetMemberRank)
exports("GetControlledOutpost", Orgs.GetControlledOutpost)
exports("GetMemberOrgs", Orgs.GetMemberOrgs)
exports("GetMembersOrgAndType", Orgs.GetMembersOrgAndType)
-- exports("ListHasOrgIdOrName", Orgs.ListHasOrgIdOrName)

function string2date(str)
    p = "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)"
    year, month, day, hour, min, sec = str:match(p)
    return os.time({tz = "GMT", day = day, month = month, year = year, hour = hour, min = min, sec = sec})
end

function date2string(date)
    return os.date("%Y-%m-%d %H:%M:%S", date)
end

AddEventHandler(
    "onResourceStart",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            for user_id, User in pairs(API.getUsers()) do
                local Character = User:getCharacter()

                if Character then
                    local source = User:getSource()
                    local member_id = Character:getId()

                    SyncCharacterOrgsForPlayer(source, member_id)
                end
            end
        end
    end
)

function SyncCharacterOrgsForPlayer(source, member_id)
    local rows = dbAPI.query("orgs:getMemberOrgs", {member_id = member_id})
    local myOrgs = {}

    for _, org in pairs(rows) do
        myOrgs[org.type] = {org_id = org.id, org_name = org.name, my_rank = org.rank}
    end

    cAPI.setMyOrg(source, json.encode(myOrgs))
end

AddEventHandler(
    "API:OnUserCharacterInitialization",
    function(User, character_id)
        local source = User:getSource()
        local member_id = character_id

        SyncCharacterOrgsForPlayer(source, member_id)
    end
)

RegisterNetEvent("Orgs:GetMembersOrgs")
AddEventHandler(
    "Orgs:GetMembersOrgs",
    function(orgs)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User.getCharacter()

        local orgsMembers = {my_member_id = 0, my_member_name = "", orgs = {}}
        local orgsSql = ""

        for index = 1, #orgs do
            local rows = dbAPI.query("orgs:getMembersByOrg", {org_id = orgs[index]})
            for _, org_member in pairs(rows) do
                if orgsMembers.orgs[org_member.org_id] == nil then
                    orgsMembers.orgs[org_member.org_id] = {type = org_member.type, members = {}}
                end

                orgsMembers.orgs[org_member.org_id].members[#orgsMembers.orgs[org_member.org_id].members + 1] = {
                    member_id = org_member.member_id,
                    member_rank = org_member.rank,
                    member_name = org_member.name
                    -- joined_at = org_member.joined_at
                }

                if orgsMembers.my_member_id == 0 and Character:getId() == org_member.member_id then
                    orgsMembers.my_member_id = org_member.member_id
                -- orgsMembers.my_member_name = org_member.name
                end
            end
        end

        TriggerClientEvent("Orgs:SetMembersOrgsForClient", _source, orgsMembers)
    end
)

local _ILEGAL_ORG_CREATION_PRICE = 100

-- ! Suscetível à MYSQL INJECTION (org_name) ?
-- ! Suscetível à MYSQL INJECTION (org_name) ?
-- ! Suscetível à MYSQL INJECTION (org_name) ?
-- ! Suscetível à MYSQL INJECTION (org_name) ?
RegisterNetEvent("Orgs:TryToCreateOrg")
AddEventHandler(
    "Orgs:TryToCreateOrg",
    function()
        local _source = source

        local User = API.getUserFromSource(_source)

        if User then
            local Character = User:getCharacter()

            if Character then
                local my_member_id = Character:getId()

                local org_id, org_name = Orgs.GetMemberOrgByType(my_member_id, "ilegal")

                local hasIlegalOrg = org_id ~= nil or org_name ~= nil

                if not hasIlegalOrg then
                    local Inventory = Character:getInventory()

                    if Inventory:getItemAmount("money") < _ILEGAL_ORG_CREATION_PRICE then
                        User:notify("error", "Você não tem dinheiro suficiente")
                        return
                    end

                    local org_name = cAPI.prompt(_source, "Nome da Organização:", "")

                    if org_name == "" then
                        User:notify("error", "Você não especificou um nome valido.")
                        return
                    end

                    if string.len(org_name) > 16 then
                        User:notify("error", "O nome da organização não pode ter mais de 16 caracteres.")
                        return
                    end

                    if Inventory:removeItem(-1, "money", _ILEGAL_ORG_CREATION_PRICE) then
                        local org_id = Orgs.Create(org_name)

                        if org_id then
                            Orgs.addMember(org_id, my_member_id, 1)

                            User:notify("success", "Organizaçao criada!")
                        else
                            User:notify("error", "Ocorreu um erro ao criar sua org :(")
                            Inventory:addItem("money", _ILEGAL_ORG_CREATION_PRICE)
                        end
                    else
                        User:notify("error", "Você não tem dinheiro suficiente")
                    end
                else
                    User:notify("error", "Você já está em uma org")
                end
            end
        end
    end
)

RegisterNetEvent("Orgs:TryToDeleteOrg")
AddEventHandler(
    "Orgs:TryToDeleteOrg",
    function(org_id)
        local _source = source

        local User = API.getUserFromSource(_source)

        if User then
            local Character = User:getCharacter()

            if Character then
                local my_member_id = Character:getId()

                local my_member_rank = Orgs.GetMemberRank(org_id, my_member_id)

                if my_member_rank == 1 then
                    local org_type = Orgs.GetType(org_id)

                    if org_type == "ilegal" then
                        Orgs.Delete(org_id)

                        User:notify("success", "Sua organização foi deletada")
                    else
                        User:notify("error", "Essa organização não pode ser deletada")
                    end
                else
                    User:notify("error", "Somente o dono pode deletar a organização")
                end
            end
        end
    end
)

RegisterNetEvent("Orgs:TryToLeaveFromOrg")
AddEventHandler(
    "Orgs:TryToLeaveFromOrg",
    function(org_id)
        local _source = source

        local User = API.getUserFromSource(_source)

        if User then
            local Character = User:getCharacter()

            if Character then
                local my_member_id = Character:getId()

                local org_data = Orgs.GetMembersOrgAndType(org_id)

                local org_type = org_data.org_type
                local org_members = org_data.members

                for _, mbm_d in pairs(org_members) do
                    local member_id = mbm_d.member_id

                    if member_id == my_member_id then
                        local member_rank = mbm_d.member_rank

                        if member_rank ~= 1 or member_rank == 1 and org_type ~= "ilegal" then
                            Orgs.RemoveMember(org_id, my_member_id)

                            User:notify("success", "Você saiu da organização")
                        else
                            User:notify("error", "Você não pode sair da sua propria organização")
                        end

                        return
                    end
                end

            -- User:notify("error", "Erro você não é um membro")
            end
        end
    end
)

RegisterNetEvent("Orgs:TryToKickFromOrg")
AddEventHandler(
    "Orgs:TryToKickFromOrg",
    function(org_id, target_member_id)
        local _source = source

        local User = API.getUserFromSource(_source)

        if User then
            local Character = User:getCharacter()

            if Character then
                local my_member_id = Character:getId()

                local org_data = Orgs.GetMembersOrgAndType(org_id)

                local org_type = org_data.org_type
                local org_members = org_data.members

                local im_allowed_to_kick = false
                local target_is_in_the_org = false

                local target_member_rank = -1

                for _, mbm_d in pairs(org_members) do
                    local member_id = mbm_d.member_id
                    local member_rank = mbm_d.member_rank

                    if member_id == my_member_id then
                        if member_rank == 1 then
                            im_allowed_to_kick = true
                        end
                    end

                    if member_id == target_member_id then
                        target_is_in_the_org = true

                        target_member_rank = member_rank
                    end
                end

                if not im_allowed_to_kick then
                    User:notify("error", "Você não faz mais parte da organização ou não tem permissão para kickar")
                    return
                end

                if not target_is_in_the_org then
                    User:notify("error", "Este Membro não está mais na organização")
                    return
                end

                if target_member_rank == 1 then
                    local rank_name = RankToRankName(org_id, target_member_rank) or RankToRankName(org_type, target_member_rank)

                    User:notify("error", "Membro de rank " .. rank_name .. ", não pode ser kickado.")
                    return
                end

                Orgs.RemoveMember(org_id, target_member_id)

                User:notify("success", "Membro removido da organização.")
            end
        end
    end
)

RegisterNetEvent("Orgs:TryPromoteOrgMember")
AddEventHandler(
    "Orgs:TryPromoteOrgMember",
    function(org_id, target_member_id)
        local _source = source

        local User = API.getUserFromSource(_source)

        if User then
            local Character = User:getCharacter()

            if Character then
                local my_member_id = Character:getId()

                local org_data = Orgs.GetMembersOrgAndType(org_id)

                local org_type = org_data.org_type
                local org_members = org_data.members

                local im_allowed_to_edit = false
                local target_is_in_the_org = false

                local target_member_rank = -1

                for _, mbm_d in pairs(org_members) do
                    local member_id = mbm_d.member_id
                    local member_rank = mbm_d.member_rank

                    if member_id == my_member_id then
                        if member_rank == 1 then
                            im_allowed_to_edit = true
                        end
                    end

                    if member_id == target_member_id then
                        target_is_in_the_org = true

                        target_member_rank = member_rank
                    end
                end

                if not im_allowed_to_edit then
                    User:notify("error", "Você não tem permissao")
                    return
                end

                if target_member_rank == 1 then
                    User:notify("error", "Você nao pode modificar o rank deste membro.")
                    return
                end

                local new_rank

                local rank_list = config[org_type] or config[org_id]

                if target_member_rank == -1 then
                    new_rank = #rank_list
                else
                    new_rank = target_member_rank - 1
                end

                if new_rank == 1 then
                    User:notify("error", "Membro não pode mais ser promovido.")
                    return
                end

                Orgs.SetMemberRank(org_id, target_member_id, new_rank)

                -- local old_rank_name = RankToRankName(org_id, target_member_rank) or RankToRankName(org_type, target_member_rank)

                local rank_name = RankToRankName(org_id, new_rank) or RankToRankName(org_type, new_rank)

                User:notify("error", "Membro setado como " .. rank_name) -- .. " old " .. old_rank_name)
            end
        end
    end
)

RegisterNetEvent("Orgs:TryToDemoteOrgMember")
AddEventHandler(
    "Orgs:TryToDemoteOrgMember",
    function(org_id, target_member_id)
        local _source = source

        local User = API.getUserFromSource(_source)

        if User then
            local Character = User:getCharacter()

            if Character then
                local my_member_id = Character:getId()

                local org_data = Orgs.GetMembersOrgAndType(org_id)

                local org_type = org_data.org_type
                local org_members = org_data.members

                local im_allowed_to_edit = false
                local target_is_in_the_org = false

                local target_member_rank = -1

                for _, mbm_d in pairs(org_members) do
                    local member_id = mbm_d.member_id
                    local member_rank = mbm_d.member_rank

                    if member_id == my_member_id then
                        if member_rank == 1 then
                            im_allowed_to_edit = true
                        end
                    end

                    if member_id == target_member_id then
                        target_is_in_the_org = true

                        target_member_rank = member_rank
                    end
                end

                if not im_allowed_to_edit then
                    User:notify("error", "Você não tem permissao")
                    return
                end

                if target_member_rank == 1 then
                    User:notify("error", "Você nao pode modificar o rank deste membro.")
                    return
                end

                if target_member_rank == -1 then
                    User:notify("error", "Membro já está no rank mais baixo.")
                    return
                end

                local new_rank = target_member_rank + 1

                local rank_list = config[org_type] or config[org_id]

                if new_rank > #rank_list then
                    new_rank = -1
                end

                if new_rank == 1 then
                    User:notify("error", "Membro não pode mais ser promovido.")
                    return
                end

                Orgs.SetMemberRank(org_id, target_member_id, new_rank)

                local rank_name = RankToRankName(org_id, new_rank) or RankToRankName(org_type, new_rank)

                User:notify("error", "Membro setado como " .. rank_name)
            end
        end
    end
)
