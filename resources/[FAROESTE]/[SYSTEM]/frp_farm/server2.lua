local cache_pop = {}

local cache_timeout_timestamp = 0

local cache_is_from_db = false

RegisterNetEvent("VP:FARM:AddIndex")
AddEventHandler(
    "VP:FARM:AddIndex",
    function(index, state_flag)
        dbAPI.execute("INSERT:farm_add_index", {index = index, state_flag = state_flag})

        TriggerClientEvent("VP:FARM:SetIndex", -1, index, state_flag)
    end
)

RegisterNetEvent("VP:FARM:RemoveIndex")
AddEventHandler(
    "VP:FARM:RemoveIndex",
    function(index, state_flag)
        dbAPI.execute("REMOVE:farm_remove_index", {index = index})

        TriggerClientEvent("VP:FARM:SetIndex", -1, index, 0)

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

RegisterNetEvent("VP:FARM:RequestPop")
AddEventHandler(
    "VP:FARM:RequestPop",
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

        TriggerClientEvent("VP:FARM:SetPop", _source, cache_pop)
    end
)
