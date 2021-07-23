local beds = {
    { x = 356.73, y = -585.71, z = 43.11, h = -20.0, taken = false, model = 1631638868 },
    { x = 360.51, y = -586.66, z = 43.11, h = -20.0, taken = false, model = -1091386327 },
    { x = 353.12, y = -584.66, z = 43.50, h = -20.0, taken = false, model = 1631638868 },
    { x = 349.62, y = -583.53, z = 43.022, h = -20.0, taken = false, model = -1091386327 },
    { x = 344.80, y = -581.12, z = 43.02, h = 80.0, taken = false, model = -1091386327 },
    { x = 334.09, y = -578.43, z = 43.01, h = 80.0, taken = false, model = -1091386327 },
    { x = 323.64, y = -575.16, z = 43.02, h = -20.0, taken = false, model = -1091386327 },
    { x = 326.97, y = -576.229, z = 43.02, h = -20.0, taken = false, model = -1091386327 },
    { x = 354.24, y = -592.74, z = 43.11, h = 160.0, taken = false, model = 2117668672 },
    { x = 357.34, y = -594.45, z = 43.11, h = 160.0, taken = false, model = 2117668672 },
    { x = 350.80, y = -591.72, z = 43.11, h = 160.0, taken = false, model = 2117668672 },
    { x = 346.89, y = -591.01, z = 42.58, h = 160.0, taken = false, model = 2117668672 },
}

local bedsTaken = {}
local injuryBasePrice = 100

AddEventHandler('playerDropped', function()
    if bedsTaken[source] ~= nil then
        beds[bedsTaken[source]].taken = false
    end
end)

RegisterServerEvent('mythic_hospital:server:RequestBed')
AddEventHandler('mythic_hospital:server:RequestBed', function()
    for k, v in pairs(beds) do
        if not v.taken then
            v.taken = true
            bedsTaken[source] = k
            TriggerClientEvent('mythic_hospital:client:SendToBed', source, k, v)
            return
        end
    end

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'No Beds Available' })
end)

RegisterServerEvent('mythic_hospital:server:RPRequestBed')
AddEventHandler('mythic_hospital:server:RPRequestBed', function(plyCoords)
    local foundbed = false
    for k, v in pairs(beds) do
        local distance = #(vector3(v.x, v.y, v.z) - plyCoords)
        if distance < 3.0 then
            if not v.taken then
                v.taken = true
                foundbed = true
                TriggerClientEvent('mythic_hospital:client:RPSendToBed', source, k, v)
                return
            else
                TriggerEvent('mythic_chat:server:System', source, 'That Bed Is Taken')
            end
        end
    end

    if not foundbed then
        TriggerEvent('mythic_chat:server:System', source, 'Not Near A Hospital Bed')
    end
end)

RegisterServerEvent('mythic_hospital:server:EnteredBed')
AddEventHandler('mythic_hospital:server:EnteredBed', function()
    local src = source
    local injuries = GetCharsInjuries(src)

    local totalBill = injuryBasePrice

    if injuries ~= nil then
        for k, v in pairs(injuries.limbs) do
            if v.isDamaged then
                totalBill = totalBill + (injuryBasePrice * v.severity)
            end
        end

        if injuries.isBleeding > 0 then
            totalBill = totalBill + (injuryBasePrice * injuries.isBleeding)
        end
    end

    -- YOU NEED TO IMPLEMENT YOUR FRAMEWORKS BILLING HERE
    TriggerClientEvent('mythic_hospital:client:FinishServices', src)
end)

RegisterServerEvent('mythic_hospital:server:LeaveBed')
AddEventHandler('mythic_hospital:server:LeaveBed', function(id)
    beds[id].taken = false
end)