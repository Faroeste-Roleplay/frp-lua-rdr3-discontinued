local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

RegisterCommand(
    "org",
    function(source, args, raw)
        local myOrgs = cAPI.getMyOrg()
        local orgsIds = {}
        
        for _, org in pairs(myOrgs) do
            table.insert(orgsIds, org.id)
        end
        TriggerServerEvent("Orgs:GetMembersOrgs", orgsIds)
    end,
    false
)

RegisterNetEvent("Orgs:GetMembersOrgs")
AddEventHandler("Orgs:GetMembersOrgs", 
function(orgsMembers)
    local message = {
        my_member_id = orgsMembers.id,
        my_name = orgsMembers.name,
        orgs = {}
    }
    
    for id, org in pairs(orgsMembers.orgs) do
        local members = {}
        for _, member in pairs(org.members) do
            table.insert(members, {
                member_id = member.member_id,
                rank = member.rank,
                name = member.name,
                joined_at = member.joined_at
            })
        end
        table.insert(message.orgs,{
                    org_id = id,
                    org_name = cAPI.getMyOrg()[org.type].name,
                    org_type = org.type,
                    my_rank = cAPI.getMyOrg()[org.type].rank,
                    members = members
                })
    end

    print('--------------------MESSAGE---------------------------------------')
    print(json.encode(message))
    -- SendNUIMessage(message)
    -- SetNuiFocus(true, true)
end)
