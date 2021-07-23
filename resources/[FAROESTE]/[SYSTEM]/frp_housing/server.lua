local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")
dbAPI = Proxy.getInterface("API_DB")

local houses = {
    -- price_dollar, price_gold
    ["house:1"] = {200.0, 80.0},
    ["house:2"] = {200.0, 80.0},
    ["house:3"] = {200.0, 80.0},
    ["house:4"] = {200.0, 80.0},
    ["house:5"] = {200.0, 80.0},
    ["house:6"] = {200.0, 80.0},
    ["house:7"] = {200.0, 80.0}
}

RegisterNetEvent("FRP:HOUSING:TryToBuyHouse")
AddEventHandler(
    "FRP:HOUSING:TryToBuyHouse",
    function(house_id, withGold)
        local _source = source

        if not houses[house_id] then
            return
        end

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        --[[
        if true then
            User:notify("error", "Não disponivel :P")
            return
        end
        ]]

        if Character:hasGroupOrInheritance(house_id) then
            User:notify("error", "Você já alugou esta residência")
            return
        end

        -- if #API.getUsersByGroup(house_id) > 0 then
        local rows = dbAPI.query("SELECT:house_rent", {house_id = house_id})

        if #rows > 0 then
            User:notify("error", "Está residência já está alugada")
            return
        end

        local Inventory = Character:getInventory()

        local currencyItem = withGold and 'gold' or 'money'
        local currencyAmount = withGold and houses[house_id][2] or houses[house_id][1]
        currencyAmount = currencyAmount * 100

        if Inventory:getItemAmount(currencyItem) < currencyAmount then
            User:notify("error", "Você não tem " .. (withGold and 'ouros' or 'dollares') .. " suficientes.")
            return
        end

        if Inventory:removeItem(-1, currencyItem, currencyAmount) then
            User:notify("success", "Parábens! Agora essa residência está sobe sua gerência")
            Character:addGroup(house_id)

            local date = os.date("*t")

            local time_sum_sevendays = os.time(date) + (7 * 24 * 60 * 60)

            local date_sum_sevendays = os.date("*t", time_sum_sevendays)

            local sum_to_time = os.time(date_sum_sevendays)

            -- MUDA NA DB house_next_payment PARA INT

            Character:addGroup(house_id)

            dbAPI.execute("INSERT:house_rent", {house_id = house_id, house_next_payment = sum_to_time})
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000 * 60 * 60) -- 1 Hora

            for house_id, _ in pairs(houses) do
                if IsRentExpired(house_id) then
                    for _, User in pairs(API.getUsersByGroup(house_id)) do
                        User:removeGroup(house_id)
                    end
                    

                    Citizen.CreateThread(function()
                            dbAPI.execute("DELETE:house_rent", {house_id = house_id})
                        
                            local houseGroupBit = API.GroupNameToBit(house_id)
                            dbAPI.execute("UPDATE:character_remove_role", {role = houseGroupBit})
                        end
                    )
                end
            end
        end
    end
)

function IsRentExpired(house_id)
    local rows = dbAPI.query("SELECT:house_rent", {house_id = house_id})

    if #rows > 0 then
        local date = os.date("*t")
        local time = os.time(date)

        local house_next_payment = tonumber(rows[1].house_next_payment)

        if house_next_payment > time then
            return true
        end
    end

    return false
end

-- AddEventHandler(
--     "FRP:HOUSING:RequestAvailableHouses",
--     function()

--     end
-- )
