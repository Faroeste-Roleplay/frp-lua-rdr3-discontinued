local playerInjury = {}

function GetCharsInjuries(source)
    return playerInjury[source]
end

RegisterServerEvent('mythic_hospital:server:SyncInjuries')
AddEventHandler('mythic_hospital:server:SyncInjuries', function(data)
    playerInjury[source] = data
end)