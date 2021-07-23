local weatherPerRegion = {
    ["Heartlands"] = {
      --  ["rain"] = 0.1,
        ["highpressure"] = 0.3,
        ["sunny"] = 0.45,
      --  ["clouds"] = 0.3,
      --  ["sleet"] = 0.2,
    },
    ["GuarmaD"] = {
        ["sunny"] = 1.0
    },
    ["bigvalley"] = {
     --   ["rain"] = 0.1,
    --    ["sunny"] = 0.7,
     --   ["hail"] = 0.1
     ["highpressure"] = 0.2,
    },
    ["BluewaterMarsh"] = {
     --   ["fog"] = 0.8,
     --   ["misty"] = 0.3,
      --  ["clouds"] = 0.2,
        ["highpressure"] = 0.2,
    },
    ["ChollaSprings"] = {
        ["sunny"] = 0.7,
        ["highpressure"] = 0.2,
        
     --   ["clouds"] = 0.2
    },
    ["Cumberland"] = {
     --   ["rain"] = 0.1,
        ["sunny"] = 0.6,
        ["highpressure"] = 0.3,
    --   ["shower"] = 0.2,
     --   ["hail"] = 0.1,
     --   ["drizzle"] = 0.2
    },
    ["DiezCoronas"] = {
        ["sunny"] = 0.9,
        ["highpressure"] = 0.2,
    --    ["shower"] = 0.1
    },
    ["GaptoothRidge"] = {
        ["sunny"] = 0.7,
        ["highpressure"] = 0.2,
     --   ["shower"] = 0.1,
    --    ["clouds"] = 0.2
    },
    ["greatPlains"] = {
        ["sunny"] = 0.6,
     --   ["shower"] = 0.2,
        ["highpressure"] = 0.2,
    --    ["clouds"] = 0.1,
    ---    ["drizzle"] = 0.1
    },
    ["GrizzliesEast"] = {
        ["sunny"] = 0.5,
    --    ["shower"] = 0.2,
        ["highpressure"] = 0.2,
    --    ["drizzle"] = 0.2,
    --    ["clouds"] = 0.1,
     --   ["thunder"] = 0.3
    },
    ["GrizzliesWest"] = {
   --     ["snowlight"] = 0.5,
   --     ["blizzard"] = 1.0,
    --    ["whiteout"] = 0.8
    ["highpressure"] = 0.2,
    },
    ["HennigansStead"] = {
     --   ["rain"] = 0.2,
        ["sunny"] = 0.7,
        ["highpressure"] = 0.2,
    --    ["shower"] = 0.3,
     --   ["drizzle"] = 0.2
    },
    ["Perdido"] = {
        ["sunny"] = 0.8,
    --    ["shower"] = 0.1,
    --    ["clouds"] = 0.2,
        ["highpressure"] = 0.5,
    },
    ["PuntaOrgullo"] = {
        ["sunny"] = 0.8,
    --    ["shower"] = 0.1,
    --    ["clouds"] = 0.5,
        ["highpressure"] = 0.5,
    },
    ["RioBravo"] = {
        ["sunny"] = 1.0,
    --    ["shower"] = 0.2,
        ["highpressure"] = 0.2,
    },
    ["roanoke"] = {
     --   ["misty"] = 0.8,
    --    ["fog"] = 0.3,
    --    ["thunder"] = 0.2,
    --    ["sleet"] = 0.1,
        ["highpressure"] = 0.2,
    },
    ["scarlettMeadows"] = {
    --    ["fog"] = 0.6,
    --    ["drizzle"] = 0.5,
        ["sunny"] = 0.2,
        ["highpressure"] = 0.2,
    },
    ["TallTrees"] = {
     --   ["overcastdark"] = 0.8,
     --   ["thunder"] = 0.5,
        ["sunny"] = 0.2,
        ["highpressure"] = 0.2,
    --    ["drizzle"] = 0.4,
    --    ["misty"] = 0.2
    },
    ["BayouNwa"] = {
        ["sunny"] = 0.0,
     --   ["fog"] = 1.0,
        ["highpressure"] = 0.2,
    }
}

local currentRegionWeather = {}

local weightPerRegion = {}

Citizen.CreateThread(
    function()
        for region, weathers in pairs(weatherPerRegion) do
            local total = 0
            for weather, weight in pairs(weathers) do
                total = total + weight
            end

            weightPerRegion[region] = total
        end
        while true do
            Citizen.Wait(60000 * 15)
            for region, weathers in pairs(weatherPerRegion) do
                local total = weightPerRegion[region]
                math.randomseed(os.time())
                local at = math.random() * total
                local choosen
                for weather, weight in pairs(weathers) do
                    if at < weight then
                        choosen = weather
                        break
                    end
                    at = at - weight
                end

                if currentRegionWeather[region] == nil or choosen ~= currentRegionWeather[region] then
                    currentRegionWeather[region] = choosen
                end
            end

            TriggerClientEvent("FRP:W:Sync", -1, currentRegionWeather)
        end
    end
)

RegisterNetEvent("FRP:W:AskForSync")
AddEventHandler(
    "FRP:W:AskForSync",
    function()
        local _source = source
        if #currentRegionWeather > 0 then
            TriggerClientEvent("FRP:W:Sync", _source, currentRegionWeather)
        else
            for region, weathers in pairs(weatherPerRegion) do
                local total = weightPerRegion[region]
                math.randomseed(os.time())
                local at = math.random() * total
                local choosen
                for weather, weight in pairs(weathers) do
                    if at < weight then
                        choosen = weather
                        break
                    end
                    at = at - weight
                end

                if currentRegionWeather[region] == nil or choosen ~= currentRegionWeather[region] then
                    currentRegionWeather[region] = choosen
                end
            end

            TriggerClientEvent("FRP:W:Sync", _source, currentRegionWeather)
        end
    end
)
