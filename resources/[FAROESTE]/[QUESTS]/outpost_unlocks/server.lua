local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local Unlock = {}

function Unlock.Get(unlock_id)
    local query = dbAPI.query("unlocks:getbyid", {unlock_id = unlock_id})

    if query[1] then
        local _ = query[1]

        local type, name, price = _.type, _.name, _.price
    end

    return type, name, price
end

exports("Get", Unlock.Get(unlock_id))

RegisterNetEvent("FRP:ORGS:RequestUnlocks")
AddEventHandler(
    "FRP:ORGS:RequestUnlocks",
    function(reqst_org_id, rqst_outpost_id)
        local _source = source

        local user_handle = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if not Character then
            user_handle:notify("Nope")
            return
        end

        local member_id = Character:getId()

        local my_ilegal_org_id, my_ilegal_org_name = exports("orgs"):GetMemberOrgByType(member_id)

        if my_ilegal_org_id then
            local outpost_id = exports("orgs"):GetControlledOutpost(my_ilegal_org_id)

            if outpost_id then
                -- local query = API.query("", {id_posto = "ab"})

                if outpost_id == rqst_outpost_id then
                    local unlocks = {}

                    if #query > 0 then
                        for i = 1, #query do
                            table.insert(unlocks, query[i].unlock_id)
                        end
                    end

                    TriggerClientEvent("FRP:FORT:RespondToUnlocksRequest", _source, unlocks)
                else
                    User:notify("error", "Você não tem acesso a esse posto")
                end
            else
                User:notify("error", "Sua organização não é dona de nenhum posto")
            end
        else
            User:notify("error", "Você não está em uma org ilegal")
        end
    end
)
