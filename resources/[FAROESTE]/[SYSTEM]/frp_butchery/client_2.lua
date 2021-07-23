keys = {
    ['G'] = 0x760A9C6F,
    ['S'] = 0xD27782E3,
    ['W'] = 0x8FD015D8,
	['H'] = 0x24978A28,
    ["LALT"] = 0x8AAA0AD4,
	['E'] = 0xDFF812F9
}

Citizen.CreateThread(function()
    while true do 
    Citizen.Wait(0)
        local carried = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
        local entity = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId()) --Holding
        local model = GetEntityModel(entity) --Model ID
        local something = Citizen.InvokeNative(0x0FD25587BB306C86, entity) -- ?
        local metaped = Citizen.InvokeNative(0xEC9A1261BF0CE510, entity) -- MetaPed Type
        local carriedEntityHash = Citizen.InvokeNative(0x31FEF6A20F00B963, entity) --Carrying
        local type = GetPedType(entity)
        local itemmao = HASH_PROVISIONS[carriedEntityHash]
        local pedmao = HASH_PEDS[carriedEntityHash]
   --   local playerPed = PlayerPedId()  
        local coordes    = GetEntityCoords(PlayerPedId())
        local cords = vector3(coordes.x, coordes.y, coordes.z+4.0) 
    end
end)

local prompt
local prompts = {}

Citizen.CreateThread(function()
while true do
    Citizen.Wait(0)
    local coords = GetEntityCoords(PlayerPedId())
    for _, ped in pairs(Config.PedAcougue) do
        if pedsSpawned == nil then
            local model = GetHashKey('U_M_M_VALBUTCHER_01')
            RequestModel(model)
            while HasModelLoaded(model) do
                Citizen.Wait(1000)
                RequestModel(model)
            end            
            pedsSpawned = CreatePed(model, ped.x, ped.y, ped.z, ped.h, 1, 0)
            SetPedOutfitPreset(pedsSpawned, 2, false)
            FreezeEntityPosition(pedsSpawned, true)
            PlaceObjectOnGroundProperly(pedsSpawned, true)       
            -- SetModelAsNoLongerNeeded(model)
        end
    end  


    for _, info in pairs(Config.Acougue) do

        -- if (Vdist(coords.x, coords.y, coords.z, info.x, info.y, info.z) < 10.0) then --f6
        --     Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, info.x, info.y, info.z-100, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 150, 150, 1.0, 246, 26, 26, 100, false, true, 2, false, false, false, false)
        -- end

        if (Vdist(coords.x, coords.y, coords.z, info.x, info.y, info.z) < 3.0) then --f6
            
        --    local prompt = PromptRegisterBegin()
            PromptSetControlAction(prompt, 0xE8342FF2)
            PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Vender Provisões"))
            PromptSetEnabled(prompt, 1)
            PromptSetVisible(prompt, 1)
            PromptSetStandardMode(prompt, 1)
            PromptSetPosition(prompt, info.x, info.y, info.z)
            N_0x0c718001b77ca468(prompt, 3.0)
        --  PrompContextSetSize(prompt, 3.0)

            PromptRegisterEnd(prompt)
            table.insert(prompts, prompt)
            for _, prompt in pairs(prompts) do
                if PromptHasStandardModeCompleted(prompt) then
                Citizen.Wait(0)    

                local entity = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                local model = GetEntityModel(entity)
                local something = Citizen.InvokeNative(0x0FD25587BB306C86, entity)
                local metaped = Citizen.InvokeNative(0xEC9A1261BF0CE510, entity)
                local carriedEntityHash = Citizen.InvokeNative(0x31FEF6A20F00B963, entity)
                local type = GetPedType(entity)

                if type == 28 then
                    print(" ")
                    print("Carcass Model")
                    print(model)
                    --animal carcasses
                    if model == -2011226991 then  -- eastern wild turkey black
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 75
                                local item = "bird"
                                local meatamount = 1   

                     
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -466054788 then  -- eastern wild turkey white


                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 75
                                local item = "bird"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 1458540991 then  -- Racoon
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 1
                                local item = "game"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 200, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 90267823 then  -- Cougar
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 150
                                local item = "biggame"
                                local meatamount = 2
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 300, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 1110710183 then  -- whitetail deer
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 2.0
                                local item = "venison"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 500, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -1963605336 then  -- whitetail buck
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 250
                                local item = "venison"
                                local meatamount = 2
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 500, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 480688259 then  -- california valley coyote
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 150
                                local item = "biggame"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 300, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -1414989025 then  -- virginia opossum
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 25
                                local item = "stringy"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -2063183075 then  -- Dominique Chicken
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 25
                                local item = "bird"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -1170118274 then  -- American Badger
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 50
                                local item = "stringy"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -1458540991 then  -- North American Raccoon
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 1
                                local item = "stringy"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 200, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 1755643085 then  -- American Pronghorn Doe
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 250
                                local item = "venison"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 500, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -1464167925 then  -- Southern Copperhead Snake
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 75
                                local item = "herptile"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -723190474 then  -- Canada Goose
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 75
                                local item = "bird"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -8651544272 then  -- Great Horned Owl
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 150
                                local item = "bird"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 150, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -1465438313 then  -- American Red Squirrel
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 150
                                local item = "stringy"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 300, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -1568716381 then  -- Rocky Mountain Bighorn Ram
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 250
                                local item = "biggame"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 500, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -885451903 then  -- Timber Wolf
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 2
                                local item = "biggame"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -541762431 then  -- Black-Tailed Jackrabbit
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 75
                                local item = "game"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 252669332 then  -- American Red Fox
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 1.25
                                local item = "game"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 125, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -861544272 then  -- Coastal Horned Owl
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 1
                                local item = "bird"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 200, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -1003616053 then  -- Pekin Duck
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 1
                                local item = "bird"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 200, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -829273561 then  -- gray wolf
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 150
                                local item = "biggame"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 300, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -885451903 then  -- gray wolf
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 150
                                local item = "biggame"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 300, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -1143398950 then  -- gray wolf
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 150
                                local item = "biggame"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 300, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -2145890973 then  -- Red-Tailed Hawk
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 150
                                local item = "bird"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 300, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -2145890973 then  -- ferruginous hawk
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 150
                                local item = "bird"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 300, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 1007418994 then  -- Berkshire Pig
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 25
                                local item = "pork"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 25, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 1007418994 then  -- Big China Pig
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 25
                                local item = "pork"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 25, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 1007418994 then  -- Old Spot Pig
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 25
                                local item = "pork"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 25, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 40345436 then  -- Merino Sheep
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 25
                                local item = "wool"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 25, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -1568716381 then  -- Rocky Mountain Bighorn Sheep
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 2
                                local item = "biggame"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -575340245 then  -- Western Raven
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 1
                                local item = "bird"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 200, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 1416324601 then  -- Ring-neck Phesant
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 75
                                local item = "bird"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -1553593718   then  -- Muskie
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 250
                                local item = "fish"
                                local meatamount = 2
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 500, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -1295720802 then  -- Aligator
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 1
                                local item = "biggame"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 200, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -1464167925 then  -- Copperhead Snake
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 75
                                local item = "herptile"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -1211566332 then  -- Striped Skunk
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 75
                                local item = "stringy"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -593056309 then  -- Desert Iguana
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 75
                                local item = "stringy"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 457416415 then  -- Banded Gila Monster
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 75
                                local item = "stringy"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 1265966684 then  -- American White Pelican
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 75
                                local item = "bird"
                                local meatamount = 2
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -300867788 then  -- Lake Sturgeon
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 2.45
                                local item = "fish"
                                local meatamount = 2
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 350, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end    
                    elseif model == 90264823 then  -- Cougar 
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 3.75
                                local item = "biggame"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 350, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -1134449699 then  -- American Musckrat
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 75
                                local item = "stringy"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -2073130256 then  -- Neotropic Cormorant
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 75
                                local item = "stringy"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -407730502 then  -- Alligator Snapping Turtle
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 75
                                local item = "stringy"
                                local meatamount = 2
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -564099192 then  -- Whooping Crane
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 75
                                local item = "bird"
                                local meatamount = 2
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -1854059305 then  -- Green Iguana
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 1
                                local item = "game"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 200, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 831859211 then  -- Little Egret
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 75
                                local item = "bird"
                                local meatamount = 2
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 1095117488 then  -- Tricolored Heron
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 175
                                local item = "bird"
                                local meatamount = 2
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end

                    elseif model == 2079703102 then  -- Greater Prairie Chicken
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 25
                                local item = "bird"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 545068538 then  -- Timber Rattlesnake
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 50
                                local item = "herptile"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 1464167925 then  -- Northern Copperhead Snake
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 50
                                local item = "herptile"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 1538187374 then  -- Channel Catfish
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 250
                                local item = "fish"
                                local meatamount = 2
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -1076508705 then  -- Roseate Spoonbill
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 175
                                local item = "bird"
                                local meatamount = 2
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 1459778951 then  -- Bald Eagle
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 5
                                local item = "bird"
                                local meatamount = 2
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 1104697660 then  -- Eastern Turkey Vulture
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 2
                                local item = "bird"
                                local meatamount = 2
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -164963696 then  -- Laughing Gull
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 1
                                local item = "bird"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 386506078 then  -- Yellow-Billed Loon
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 1.25
                                local item = "bird"
                                local meatamount = 2
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -1797625440 then  -- Nine-Banded Armadillo
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 2
                                local item = "game"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 275, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 759906147 then  -- North American Beaver
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 175
                                local item = "game"
                                local meatamount = 2
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -753902995 then  -- Alpine Goat
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 150
                                local item = "game"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end

                            --new
                    elseif model == 1654513481 then  -- legendary panther
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 3
                                local item = "biggame"
                                local meatamount = 3
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 375, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 723190474 then  -- Canada Goose
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 1
                                local item = "bird"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -711779521 then  -- Longnose Gar
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 225
                                local item = "fish"
                                local meatamount = 2
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 275, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 697075200 then  -- Northern Pike
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 2.75
                                local item = "fish"
                                local meatamount = 2
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 275, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == -1553593715 then  -- Muskie
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 3.75
                                local item = "fish"
                                local meatamount = 2
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 375, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    elseif model == 1205982615 then  -- Californian Condor
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                local price = 150
                                local item = "stringy"
                                local meatamount = 1
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, model)
                                --TriggerServerEvent("gunshop:giveitem", item, meatamount)
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold carcass")
                                --TriggerEvent("redemrp_notification:start", "You earned $" .. price .. " and " .. meatamount .. ' ' .. item .. " meat", 5, "success")
                            end
                    else 
                        print("Animal not on list")
                    end
                else
                    print(" ")
                    print("Not holding carcass")
                end

                if HASH_PROVISIONS[carriedEntityHash] then
                --pelts
                    print(" ")
                    print("Pelt Model")
                    print(HASH_PROVISIONS[carriedEntityHash])

                    if HASH_PROVISIONS[carriedEntityHash] == "PROVISION_DEER_HIDE_POOR" then --whitetail deer Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 150, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_DEER_HIDE" then --whitetail deer Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 275, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_DEER_HIDE_PRISTINE" then --whitetail deer Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 400, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_FOX_FUR_POOR" then --fox pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 150, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_FOX_FUR" then --fox pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 275, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_FOX_FUR_PRISTINE" then --fox pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 600, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_PRONGHORN_FUR_POOR" then --American Pronghorn Buck Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 150, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_PRONGHORN_FUR" then --American Pronghorn Buck Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 275, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_PRONGHORN_FUR_PRISTINE" then --American Pronghorn Buck Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 600, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_BOAR_SKIN_POOR" then --Wild Boar Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 300, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_BOAR_SKIN" then --Wild Boar Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 550, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_BOAR_SKIN_PRISTINE" then --Wild Boar Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 1200, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_ELK_FUR_POOR" then --Rocky Mountain Bull Elk Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 200, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_ELK_FUR" then --Rocky Mountain Bull Elk Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 350, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_ELK_FUR_PRISTINE" then --Rocky Mountain Bull Elk Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 650, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_WOLF_FUR_POOR" then --Wolf Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 250, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_WOLF_FUR" then --Wolf Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 375, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_WOLF_FUR_PRISTINE" then --Wolf Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 700, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_PIG_SKIN_POOR" then --Pig Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 250, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_PIG_SKIN" then --Pig Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 350, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_PIG_SKIN_PRISTINE" then --Pig Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 750, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_SHEEP_WOOL_POOR" then --Sheep Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 150, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_SHEEP_WOOL" then --Sheep Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 250, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_SHEEP_WOOL_PRISTINE" then --Sheep Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 750, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_RAM_HIDE_POOR" then --Ram Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 200, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_RAM_HIDE" then --Ram Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 355, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_RAM_HIDE_PRISTINE" then --Ram Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 670, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_ELK_FUR_POOR" then --Elk pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 180, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_ELK_FUR" then --Elk pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 350, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_ELK_FUR_PRISTINE" then --Elk pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 600, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_BEAR_FUR_POOR" then  -- Grizzly Bear pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 400, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_BEAR_FUR" then  -- Grizzly Bear pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 500, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_BEAR_FUR_PRISTINE" then  -- Grizzly Bear pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 600, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_BUFFALO_FUR_POOR" then  -- Grizzly Bear pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 600, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_BUFFALO_FUR" then  -- Grizzly Bear pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 600, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_BUFFALO_FUR_PRISTINE" then  -- Grizzly Bear pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 750, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_BUCK_FUR_POOR" then  -- Grizzly Bear pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 750, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_BUCK_FUR" then  -- Grizzly Bear pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 300, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_BUCK_FUR_PRISTINE" then  -- Grizzly Bear pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 355, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_ALLIGATOR_SKIN_POOR" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 250, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_ALLIGATOR_SKIN" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 350, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_ALLIGATOR_SKIN_PRISTINE" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 275, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_OXEN_HIDE_POOR" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 300, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_OXEN_HIDE" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 305, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_OXEN_HIDE_PRISTINE" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 1450, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_BLACK_BEAR_FUR_POOR" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 500, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_BLACK_BEAR_FUR" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 800, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_BLACK_BEAR_FUR_PRISTINE" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 1550, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_BULL_HIDE_POOR" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 200, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_BULL_HIDE" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 400, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_BULL_HIDE_PRISTINE" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 600, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_COW_HIDE_POOR" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 150, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_COW_HIDE" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_COW_HIDE_PRISTINE" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 300, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_COUGAR_FUR_POOR " then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 250, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_COUGAR_FUR" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 400, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_COUGAR_FUR_PRISTINE" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 550, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_COYOTE_FUR_POOR" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 125, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_COYOTE_FUR" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 300, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_COYOTE_FUR_PRISTINE" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 600, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_GOAT_HAIR_PRISTINE" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 300, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_GOAT_HAIR" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 150, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_GOAT_HAIR_POOR" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 175, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_PRONGHORN_FUR_POOR" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 150, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_PRONGHORN_FUR" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 200, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_PRONGHORN_FUR_PRISTINE" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 450, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_COW_HIDE_POOR" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 50, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_COW_HIDE" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 125, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_COW_HIDE_PRISTINE" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 250, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_PANTHER_FUR_POOR" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 215, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_PANTHER_FUR" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 425, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_PANTHER_FUR_PRISTINE" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 700, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_BEAVER_FUR_POOR" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 100, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_BEAVER_FUR" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 225, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_BEAVER_FUR_PRISTINE" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 650, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_MOOSE_FUR_POOR" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 215, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_MOOSE_FUR" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 405, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_MOOSE_FUR_PRISTINE" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 1250, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_JAVELINA_SKIN_POOR" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 115, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_JAVELINA_SKIN" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 325, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    elseif HASH_PROVISIONS[carriedEntityHash] == "PROVISION_JAVELINA_SKIN_PRISTINE" then  -- Alligator Pelt
                        Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), entity, GetEntityCoords(PlayerPedId()), 10.0, flag)					    	
                        Wait(1500)
                        SetEntityAsMissionEntity(entity, true, true)
                        NetworkRequestControlOfEntity(entity) -- sets the entity as mission entity so it can be despawned
                        DeleteEntity(entity)
                        Wait(500)
                            local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
                            local holding = GetPedType(entitycheck)
                            if holding == 0 then
                                TriggerServerEvent("FRP:BUTCHER:addmoney", 750, HASH_PROVISIONS[carriedEntityHash])
                                TriggerServerEvent('FRP:SYSTEMPAY:xp', tonumber(3))
                                print("sold Hide")
                            end
                    else 
                        print("this is not on the list")
                    end
                elseif HASH_PROVISIONS[carriedEntityHash] == nil then
                    print(" ")
                    print("Not holding Provision")
                end
            end
            end
            --DrawTxt("Pressione ALT para vender suas provições", 0.87, 0.95, 0.4, 0.4, false, 255, 255, 255, 145, 100, 7)
          --  DrawTxt("Pressione ALT para vender suas provições", 0.50, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
        else
            WarMenu.CloseMenu()
        end
    end
end
end)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            for _, prompt in pairs(prompts) do
                PromptDelete(prompt)
            end
        end
    end
)

--[[
RegisterCommand('itemdec', function(source, args)
                    local entity = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId()) --Holding
                    local model = GetEntityModel(entity) --Model ID
                    local something = Citizen.InvokeNative(0x0FD25587BB306C86, entity) -- ?
                    local metaped = Citizen.InvokeNative(0xEC9A1261BF0CE510, entity) -- MetaPed Type
                    local carriedEntityHash = Citizen.InvokeNative(0x31FEF6A20F00B963, entity) --Carrying
                    local type = GetPedType(entity)
                        print(tostring(entity))
                        print(tostring(model))
                        print(carriedEntityHash)
                        --print()
                        print(HASH_PEDS[carriedEntityHash])
                        print(model)
                        print(tostring(something))
                        print(tostring(type))
                        print(tostring(metaped))
end, false)
Citizen.CreateThread(function()
    Wait(500)
    while true do
        Wait(1000)
        local ped = PlayerPedId()
        local kek = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped)
        local lmao = GetHashKey(kek)
        local shit = GetEntityModel(kek)
        print(kek, lmao, shit)
    end
end) ]]

function DrawTxt(str, x, y, w, h, enableShadow, col100, col2, col3, a, centre)
 local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
	SetTextScale(w, h)
	SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(100, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 10);
	DisplayText(str, x, y)
end
