local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")
dbAPI = Proxy.getInterface("API_DB")

local OutPosts = {}
local OutPost = {}

function OutPost.LoadCache()
    local rows = dbAPI.query("outposts:getall")
    for _, outpost in pairs(rows) do
        local position = json.decode(outpost.position)
        OutPosts[outpost.id] = {
            id = outpost.id,
            org_id = outpost.org_id,
            type = outpost.type,
            position = vec3(table.unpack(position)),
            metadata = outpost.metadata,
        }
    end
end

function OutPost.GetMetadata(outpost_id)
end

function OutPost.GetMetadata(outpost_id)

end

function OutPost.SetMetadata(outpost_id, json)
end

function OutPost.GetUnlocks(outpost_id)
end

function OutPost.AddUnlock(outpost_id, unlock_id)
end

function OutPost.RemoveUnlock(outpost_id, unlock_id)
end

function OutPost.SetControlledBy(outpost_id, org_id)
end

Citizen.CreateThread(
    function()
        OutPost.LoadCache()
    end
)

function OutPost.GetOutPostLocation(positionPlayer)
    for index=1, #OutPosts do
        if #(OutPosts[index].position - positionPlayer) < 100 then
            return OutPosts[index]
        end
    end
    return nil
end

RegisterNetEvent("OutPost:InvadeOutpostAlert")
AddEventHandler("OutPost:InvadeOutpostAlert", function()
    local _source = source
    local x, y, z = cAPI.getPosition(_source)
    local outPostClosest = OutPost.GetOutPostLocation(vec3(x, y, z))
    if outPostClosest ~= nil and outPostClosest.org_id ~= nil and outPostClosest.org_id > 0 then
        print("NotifyUsersOrg")
        API.NotifyUsersOrg(outPostClosest.org_id, "OutPost do tipo " .. outPostClosest.type .. " está sendo invadido!")
    end
end)

exports("GetMetadata", OutPost.GetMetadata)
exports("SetMetadata", OutPost.SetMetadata)
exports("GetUnlocks", OutPost.GetUnlocks)
exports("AddUnlock", OutPost.AddUnlock)
exports("RemoveUnlock", OutPost.RemoveUnlock)
exports("SetControlledBy", OutPost.SetControlledBy)
exports("GetOutPostLocation", OutPost.GetOutPostLocation)