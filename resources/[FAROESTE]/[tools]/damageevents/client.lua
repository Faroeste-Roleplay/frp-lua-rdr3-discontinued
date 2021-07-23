local eventName = "DamageEvents"

AddEventHandler(
    eventName .. ":VehicleDestroyed",
    function(vehicle, attacker, weaponhash, wasmeleedamage, vehicledmgflag)
    end
)

AddEventHandler(
    eventName .. ":PedKilledByVehicle",
    function(victim, vehicle)
    end
)

AddEventHandler(
    eventName .. ":PedKilledByPlayer",
    function(victim, player, weaponhash, wasmeleedamage)
    end
)
AddEventHandler(
    eventName .. ":PedKilledByPed",
    function(victim, attacker, weaponhash, wasmeleedamage)
    end
)
AddEventHandler(
    eventName .. ":PedDied",
    function(victim, player, weaponhash, wasmeleedamage)
    end
)
AddEventHandler(
    eventName .. ":EntityKilled",
    function(victim, player, weaponhash, wasmeleedamage)
    end
)
AddEventHandler(
    eventName .. ":VehicleDamaged",
    function(vehicle, player, weaponhash, wasmeleedamage, vehicledmgflag)
    end
)
AddEventHandler(
    eventName .. ":EntityDamaged",
    function(victim, player, weaponhash, wasmeleedamage)
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(50)
        end
    end
)
