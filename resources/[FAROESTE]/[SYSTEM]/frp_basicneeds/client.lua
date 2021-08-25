local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

myHealth = 0
updateValue = false

-- Citizen.CreateThread(function() -- ESCONDER E MOSTRAR ALGUMAS HUDS

--     Citizen.InvokeNative(0x12769EEB8DBD7A7B)
--     Wait(300)
--     local cyka =  Citizen.InvokeNative(0x96FD694FE5BE55DC, 'character_creator', 811893989)
--     Citizen.InvokeNative(0x7B2027BAC5C8EC89, 'character_creator')

--     Citizen.InvokeNative(0xA9C8960E8684C1B5,PlayerId(), 300)
--     Citizen.InvokeNative(0x384D4765395E006C,PlayerId(), 3, true)

--     local cyka = Citizen.InvokeNative(0xABC532F9098BFD9D,PlayerId())

-- end)

local gHunger 
local gThirst


RegisterNetEvent("BasicNeeds.update")
AddEventHandler(
    "BasicNeeds.update",
    function(hunger, thirst, health)
        if gHunger ~= hunger or gThirst ~= thirst then
            SendNUIMessage(
                {
                    action = "updateNeeds",
                    hunger = hunger,
                    thirst = thirst
                }
            )
            
            gHunger = hunger
            gThirst = thirst
        end


        if health == 0 then
            myHealth = health   
            SendNUIMessage(
                {
                    action = "changeHealth",
                    health = myHealth
                }
            )
        end

        updateValue = true
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if not IsPedOnMount(PlayerPedId()) and not IsPedSittingInAnyVehicle(PlayerPedId()) then
                DisplayRadar(true)
                SendNUIMessage(
                    {
                        action = "isMounted"
                    }
                )
            else
                DisplayRadar(true)
                SendNUIMessage(
                    {
                        action = "isMounted"
                    }
                )
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(500)

            if updateValue then
                myHealth = GetEntityHealth(PlayerPedId())
                SendNUIMessage(
                    {
                        action = "changeHealth",
                        health = myHealth
                    }
                )
            end
        end
    end
)

RegisterNetEvent("BasicNeeds.startUI")
AddEventHandler(
    "BasicNeeds.startUI",
    function()
        SendNUIMessage(
            {
                action = "showHud"
            }
        )
        --TriggerEvent('BasicNeeds.update', 0, 0)
    end
)


function DirectionHeading(heading)
    if ((heading >= 0 and heading < 45) or (heading >= 315 and heading < 360)) then
        return "Norte" 
    elseif (heading >= 45 and heading < 135) then
        return "Oeste" 
    elseif (heading >= 135 and heading < 225) then
        return "Sul"
    elseif (heading >= 225 and heading < 315) then
        return "Leste" 
    end
end


local location = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        
        local player = PlayerPedId()
        local stamina = GetAttributeCoreValue(player,1)
        local temptemp = GetTemperatureAtCoords(GetEntityCoords(player))
        local temp = math.floor(temptemp + 0.5)
        local hours = GetClockHours()
        local compas = DirectionHeading(GetEntityHeading(player))
        if string.len(tostring(hours)) == 1 then
            trash = '0'..hours
        else
            trash = hours
        end

        local mins = GetClockMinutes()
        if string.len(tostring(mins)) == 1 then
            mins = '0'..mins
        else
            mins = mins
        end        
        SendNUIMessage({
            action = 'updateStatusHud',
            show = toghud,
            time = hours .. ':' .. mins,
            temp = temp..'.0',
            compas = compas,
            location = location
        })
        Citizen.Wait(200)
    end
end)


Citizen.CreateThread(function()
    local currLevel = 1
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(1, 0x26E9DC00) then
            if isTokovoip == true then
                currLevel =  exports.tokovoip_script:getPlayerData(GetPlayerServerId(PlayerId()), 'voip:mode')
                if currLevel == 1 then
                    SendNUIMessage({
                        action = "UpdateVoice",
                        prox = 2
                    })
                elseif currLevel == 2 then
                    SendNUIMessage({
                        action = "UpdateVoice",
                        prox = 1
                    })
                elseif currLevel == 3 then
                    SendNUIMessage({
                        action = "UpdateVoice",
                        prox = 3
                    })
                end
            else
                currLevel = (currLevel + 1) % 3
                if currLevel == 0 then
                    SendNUIMessage({
                    action = "UpdateVoice",
                    prox = 2
                    })
                elseif currLevel == 1 then
                    SendNUIMessage({
                        action = "UpdateVoice",
                        prox = 3
                    })
                elseif currLevel == 2 then
                    SendNUIMessage({
                        action = "UpdateVoice",
                        prox = 1
                    })
                end
            end
        end
    end
end)



local Town = {
    ["Locaties"] = {
    [1] = { ["Naam"] = "Valentine", ["X"] = -299.94 , ["Y"] = 790.76 , ["Z"] = 118.19 },
    [2] = { ["Naam"] = "Rhodes", ["X"] = 1338.6, ["Y"] = -1310.64 , ["Z"] = 76.45 },
    [3] = { ["Naam"] = "Strawberry", ["X"] = -1794.66 , ["Y"] = -398.56 , ["Z"] = 160.24 },
    [4] = { ["Naam"] = "Armadillo", ["X"] = -3689.83 , ["Y"] = -2611.86 , ["Z"] = -14.08 },
    [5] = { ["Naam"] = "Thumbleweed", ["X"] = -5510.23 , ["Y"] = -2945.17, ["Z"] = -1.92 },
    [6] = { ["Naam"] = "Blackwater", ["X"] = -815.87 , ["Y"] = -1319.14 , ["Z"] = 43.68 },
    [7] = { ["Naam"] = "Saint Denis", ["X"] = 2614.88 , ["Y"] = -1230.47 , ["Z"] = 53.31 },
    [8] = { ["Naam"] = "Van Horn", ["X"] = 2960.94 , ["Y"] = 527.7 , ["Z"] = 44.36 },
    [9] = { ["Naam"] = "Annesburg", ["X"] = 2928.45 , ["Y"] = 1339.86 , ["Z"] = 44.0 },
    },
}

Citizen.CreateThread(function()
    while true do       
        Wait(0) 
        local Coords = GetEntityCoords(PlayerPedId())
        if  GetDistanceBetweenCoords(Coords.x, Coords.y, Coords.z, Town["Locaties"][1]["X"], Town["Locaties"][1]["Y"], Town["Locaties"][1]["Z"], true) <= 200.0 then
        location = 'Valentine'
        elseif GetDistanceBetweenCoords(Coords.x, Coords.y, Coords.z, Town["Locaties"][2]["X"], Town["Locaties"][2]["Y"], Town["Locaties"][2]["Z"], true) <= 135.0 then
            location = 'Rhodes'
        elseif GetDistanceBetweenCoords(Coords.x, Coords.y, Coords.z, Town["Locaties"][3]["X"], Town["Locaties"][3]["Y"], Town["Locaties"][3]["Z"], true) <= 70.0 then
            location = 'Strawberry'
        elseif GetDistanceBetweenCoords(Coords.x, Coords.y, Coords.z, Town["Locaties"][4]["X"], Town["Locaties"][4]["Y"], Town["Locaties"][4]["Z"], true) <= 90.0 then
            location = 'Armadillo'
        elseif GetDistanceBetweenCoords(Coords.x, Coords.y, Coords.z, Town["Locaties"][5]["X"], Town["Locaties"][5]["Y"], Town["Locaties"][5]["Z"], true) <= 69.0 then
            location = 'Thumbleweed'
        elseif GetDistanceBetweenCoords(Coords.x, Coords.y, Coords.z, Town["Locaties"][6]["X"], Town["Locaties"][6]["Y"], Town["Locaties"][6]["Z"], true) <= 145.0 then
            location = 'Blackwater'
        elseif GetDistanceBetweenCoords(Coords.x, Coords.y, Coords.z, Town["Locaties"][7]["X"], Town["Locaties"][7]["Y"], Town["Locaties"][7]["Z"], true) <= 320.0 then
            location = 'Saint Denis'
        elseif GetDistanceBetweenCoords(Coords.x, Coords.y, Coords.z, Town["Locaties"][8]["X"], Town["Locaties"][8]["Y"], Town["Locaties"][8]["Z"], true) <= 75.0 then
            location = 'Van Horn'
        elseif GetDistanceBetweenCoords(Coords.x, Coords.y, Coords.z, Town["Locaties"][9]["X"], Town["Locaties"][9]["Y"], Town["Locaties"][9]["Z"], true) <= 100.0 then
            location = 'Annerburg'
        else
            location = 'Desconhecido'
        end
    end
end)