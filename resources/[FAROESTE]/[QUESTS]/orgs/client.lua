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
            table.insert(orgsIds, org.org_id)
        end

        TriggerServerEvent("Orgs:GetMembersOrgs", orgsIds)
    end,
    false
)

RegisterNetEvent("Orgs:SetMembersOrgsForClient")
AddEventHandler(
    "Orgs:SetMembersOrgsForClient",
    function(orgsMembers)
        local message = {
            my_member_id = orgsMembers.my_member_id,
            -- my_member_name = orgsMembers.my_member_name,
            orgs = {}
        }

        for org_id, org in pairs(orgsMembers.orgs) do
            local org_type = org.type

            local org_type_4_rank_format = org_type ~= "ilegal" and org_id or org_type

            local members = {}
            for _, member in pairs(org.members) do
                local rank = member.member_rank
                local rank_name = RankToRankName(org_type_4_rank_format, rank)

                -- ? Pass the rank as it's display name so we can display it on the NUI
                -- ? NUI wont have any ideia of the existence of ranks

                table.insert(
                    members,
                    {
                        member_id = member.member_id,
                        member_rank = rank,
                        member_rank_name = rank_name,
                        member_name = member.member_name
                        -- joined_at = member.joined_at
                    }
                )
            end

            local my_orgs = cAPI.getMyOrg()

            table.insert(
                message.orgs,
                {
                    org_id = org_id,
                    org_name = my_orgs[org_type].org_name,
                    org_type = org.type,
                    my_rank = my_orgs[org_type].my_rank,
                    members = members
                }
            )
        end

        -- print("--------------------MESSAGE---------------------------------------")
        -- print(json.encode(message))

        SendNUIMessage(
            {
                type = "show",
                data = message
            }
        )
        SetNuiFocus(true, true)
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if GetCurrentResourceName() == resourceName then
            hide()
        end
    end
)

function hide()
    SendNUIMessage(
        {
            type = "hide"
        }
    )
    SetNuiFocus(false, false)
end

RegisterNUICallback(
    "hide",
    function()
        hide()
    end
)

RegisterNUICallback(
    "create",
    function(data)
        --[[
            Fazer uma verificação de já possuir uma organização ilegal
            antes de enviar o request para o servidor.
        ]]
        hide()

        TriggerServerEvent("Orgs:TryToCreateOrg")
    end
)

RegisterNUICallback(
    "delete",
    function(data)
        --[[
            Fazer uma verificação de já possuir uma organização ilegal
            antes de enviar o request para o servidor.
        ]]
        local org_id = data.org_id

        TriggerServerEvent("Orgs:TryToDeleteOrg", org_id)
    end
)

RegisterNUICallback(
    "leave",
    function(data)
        local org_id = data.org_id

        TriggerServerEvent("Orgs:TryToLeaveFromOrg", org_id)
    end
)

RegisterNUICallback(
    "kick",
    function(data)
        local org_id = data.org_id
        local target_member_id = data.target_member_id

        TriggerServerEvent("Orgs:TryToKickFromOrg", org_id, target_member_id)
    end
)

RegisterNUICallback(
    "promote",
    function(data)
        local org_id = data.org_id
        local target_member_id = data.target_member_id

        TriggerServerEvent("Orgs:TryPromoteOrgMember", org_id, target_member_id)
    end
)

RegisterNUICallback(
    "demote",
    function(data)
        local org_id = data.org_id
        local target_member_id = data.target_member_id

        TriggerServerEvent("Orgs:TryToDemoteOrgMember", org_id, target_member_id)
    end
)
