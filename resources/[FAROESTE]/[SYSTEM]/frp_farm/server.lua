local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
dbAPI = Proxy.getInterface("API_DB")
cAPI = Tunnel.getInterface("API")

local loadedFromDatabase = {}
local farmsInfo = {}
local notReadyFarmsInfo = {}

RegisterNetEvent("FRP:FARM:TryToPlantSeed")
AddEventHandler(
    "FRP:FARM:TryToPlantSeed",
    function(seedTryingToPlant, farmAreaId, slot_id)
        local _source = source
        if not farmsInfo[farmAreaId] then
            return
        end

        local User = API.getUserFromSource(_source)

        if farmsInfo[farmAreaId][slot_id] ~= nil then
            User:notify("error", "Procure outro lugar para plantar!")
            return
        end

        -- local type = farmAreaId

        if seedTryingToPlant ~= farmAreaId then
            User:notify("error", "Você não pode plantar esse tipo de semente aqui!")
            return
        end

        local Character = User:getCharacter()
        local Inventory = Character:getInventory()

        local seedItem = farmAreaId .. "_seed"
        if Inventory:getItemAmount(seedItem) <= 0 then
            User:notify("error", "Você precisa de uma semente para plantar!")
            return
        end

        local time_next_water = os.time() + 5

        Inventory:removeItem(-1, seedItem, 1)
        farmsInfo[farmAreaId][slot_id] = {0, time_next_water}
        -- Age, timesWatered

        -- User:notify("success", "Semente plantada!")
        User:notify("item", seedItem, -1)

        for _, player in pairs(API.getPlayersAtArea(farmAreaId)) do
            TriggerClientEvent("FRP:FARM:SetSpot", player, farmAreaId, slot_id, 0)
        end

        dbAPI.execute("INSERT:crop_insert_slot", {crop_id = farmAreaId, slot_id = slot_id, crop_min_time_water = time_next_water})
    end
)

RegisterNetEvent("FRP:FARM:TryToWaterCrop")
AddEventHandler(
    "FRP:FARM:TryToWaterCrop",
    function(farmAreaId, slot_id)
        local _source = source

        if farmsInfo[farmAreaId] == nil or farmsInfo[farmAreaId][slot_id] == nil then
            return
        end

        local User = API.getUserFromSource(_source)
        if (notReadyFarmsInfo[farmAreaId] and notReadyFarmsInfo[farmAreaId][slot_id]) or (farmsInfo[farmAreaId][slot_id][2] > os.time()) then
            -- print("Cuidado! se você regar demais a planta pode morrer")
            if (notReadyFarmsInfo[farmAreaId] and notReadyFarmsInfo[farmAreaId][slot_id]) then
                print('nao pode regar agora')
            else
                print("aguarde " .. farmsInfo[farmAreaId][slot_id][2] - os.time() .. " segundos antes de regar a planta")
                User.notify("Cuidado! se você regar demais a planta pode morrer")
            end
            return
        end

        local currentgrowth = farmsInfo[farmAreaId][slot_id][1]

        if currentgrowth >= 99 then
            -- print("Está planta já está pronta para ser colhida")
            -- User.notify("Está planta já está pronta para ser colhida")
            return
        end

        local ms = 1000
        local wateringCooldown = 6

        local newgrowth = currentgrowth + 33
        local time_next_water = (os.time() + ms) + wateringCooldown
        -- (thread ms + new farm info time) + actual delay
        -- farmsInfo[farmAreaId][slot_id] = {newgrowth, time_next_water}

        if notReadyFarmsInfo[farmAreaId] == nil then
            notReadyFarmsInfo[farmAreaId] = {}
        end

        print("planta regada")

        notReadyFarmsInfo[farmAreaId][slot_id] = newgrowth

        dbAPI.execute("UPDATE:crop_update_slot", {crop_id = farmAreaId, slot_id = slot_id, crop_percent_grown = newgrowth, crop_min_time_water = time_next_water})

        Citizen.CreateThread(
            function()
                Citizen.Wait(ms)
                if notReadyFarmsInfo[farmAreaId] ~= nil and notReadyFarmsInfo[farmAreaId][slot_id] ~= nil then
                    farmsInfo[farmAreaId][slot_id] = {newgrowth, os.time() + wateringCooldown}
                    notReadyFarmsInfo[farmAreaId][slot_id] = nil

                    if #notReadyFarmsInfo[farmAreaId] <= 0 then
                        notReadyFarmsInfo[farmAreaId] = nil
                    end

                    print("planta cresceu")
                    for _, player in pairs(API.getPlayersAtArea(farmAreaId)) do
                        TriggerClientEvent("FRP:FARM:SetSpot", player, farmAreaId, slot_id, newgrowth)
                    end
                end
            end
        )

        -- TriggerClientEvent('FRP:FARM:WaterPlantAnimation', _source, ...)
    end
)

RegisterNetEvent("FRP:FARM:TryToHarvestCrop")
AddEventHandler(
    "FRP:FARM:TryToHarvestCrop",
    function(farmAreaId, slot_id)
        local _source = source

        if farmsInfo[farmAreaId] == nil or farmsInfo[farmAreaId][slot_id] == nil then
            return
        end

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if Character == nil then
            return
        end

        local Inventory = Character:getInventory()
        local plantItem = farmAreaId ~= "sugarcane" and farmAreaId or "sugar"

        if Inventory:addItem(plantItem, 1) then
            -- local percentToSync = nil

            -- if farmAreaId ~= "sugarcane" then
                farmsInfo[farmAreaId][slot_id] = nil
            -- else
            --     percentToSync = 101
            --     farmsInfo[farmAreaId][slot_id] = {percentToSync, 0}

            --     Citizen.CreateThread(
            --         function()
            --             Citizen.Wait(5000)
            --             print("planta sumiu")
            --             for _, player in pairs(API.getPlayersAtArea(farmAreaId)) do
            --                 TriggerClientEvent("FRP:FARM:SetSpot", player, farmAreaId, slot_id, nil)
            --             end
            --         end
            --     )
            -- end

            print("planta colhida")

            dbAPI.execute("UPDATE:crop_remove_slot", {crop_id = farmAreaId, slot_id = slot_id})

            for _, player in pairs(API.getPlayersAtArea(farmAreaId)) do
                TriggerClientEvent("FRP:FARM:SetSpot", player, farmAreaId, slot_id, percentToSync)
            end
        else
            User:notify("error", "Bolsa sem espaço")
        end
    end
)

RegisterNetEvent("FRP:FARM:AskForFarmsInfo")
AddEventHandler(
    "FRP:FARM:AskForFarmsInfo",
    function(farmAreaId)
        local _source = source

        if loadedFromDatabase[farmAreaId] == nil then
            local query = dbAPI.query("SELECT:get_crop_slots", {crop_id = farmAreaId})

            farmsInfo[farmAreaId] = {}

            if #query > 0 then
                for _, v in pairs(query) do
                    farmsInfo[farmAreaId][v.slot_id] = {v.crop_percent_grown, v.crop_min_time_water}
                end
            end

            loadedFromDatabase[farmAreaId] = true
        end

        local t = {}
        for k, v in pairs(farmsInfo[farmAreaId]) do
            t[k] = {v[1]}
        end

        TriggerClientEvent("FRP:FARM:SetFarmsInfo", _source, farmAreaId, farmsInfo[farmAreaId])
    end
)