local cache_pop = {}

local cache_timeout_timestamp = 0

local cache_is_from_db = false

RegisterNetEvent("FRP:FARM:AddIndex")
AddEventHandler(
    "FRP:FARM:AddIndex",
    function(index, state_flag)
        dbAPI.execute("INSERT:farm_add_index", {index = index, state_flag = state_flag})

        TriggerClientEvent("FRP:FARM:SetIndex", -1, index, state_flag)
    end
)

RegisterNetEvent("FRP:FARM:RemoveIndex")
AddEventHandler(
    "FRP:FARM:RemoveIndex",
    function(index, state_flag)
        dbAPI.execute("REMOVE:farm_remove_index", {index = index})

        TriggerClientEvent("FRP:FARM:SetIndex", -1, index, 0)

        addindextocache(index, state_flag)
    end
)

function addindextocache(index, state_flag)
    cache_pop[index] = state_flag

    startcachetimeout()
end

function startcachetimeout()
    if cache_timeout_timestamp ~= 0 then
        cache_timeout_timestamp = os.time() + (1 * 60 * 1000)
    else
        cache_timeout_timestamp = os.time() + (3 * 60 * 1000)
        Citizen.CreateThread(
            function()
                while true do
                    Citizen.Wait(2.5 * 1000)

                    if cache_timeout_timestamp <= os.time() then
                        cache_pop = {}

                        cache_timeout_timestamp = 0

                        if cache_is_from_db == true then
                            cache_is_from_db = false
                        end

                        break
                    end
                end
            end
        )
    end
end

RegisterNetEvent("FRP:FARM:RequestPop")
AddEventHandler(
    "FRP:FARM:RequestPop",
    function()
        local _source = source

        if cache_is_from_db == false then
            local query = dbAPI.query("SELECT:farm_get_indices", {})

            if #query > 0 then
                for i = 1, #query do
                    local d = query[i]

                    local index = d.index
                    local state_flag = d.state_flag

                    cache_pop[index] = state_flag
                end
            end

            cache_is_from_db = true

            startcachetimeout()
        end

        TriggerClientEvent("FRP:FARM:SetPop", _source, cache_pop)
    end
)
