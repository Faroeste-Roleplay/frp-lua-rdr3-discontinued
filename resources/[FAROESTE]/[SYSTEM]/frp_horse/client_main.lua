local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local horseModel
local horseName
local horseComponents = {}

local initializing = false

local prompt_inventory
local prompt_eat
local prompt_brush
local prompt_drink

-- AUDIO::PLAY_SOUND_FRONTEND("Core_Fill_Up", "Consumption_Sounds", true, 0);

function NativeSetPlayerHorse(horseEntity)
    Citizen.InvokeNative(0xD2CB0FB0FDCB473D, PlayerId(), horseEntity)
end

function SetPlayerHorse(horseEntity)
    playerHorse = horseEntity
end

function NativeSetPedComponentEnabled(ped, component)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, component, true, true, true)
end

function SetHorseInfo(horse_model, horse_name, horse_components)
    horseModel = horse_model
    horseName = horse_name
    horseComponents = horse_components
end



RegisterNetEvent("FRP:HORSE:SetHorseInfo")
AddEventHandler("FRP:HORSE:SetHorseInfo", SetHorseInfo)

function InitiateHorse(atCoords)
    if initializing then
        return
    end

    initializing = true

    if horseModel == nil and horseName == nil then
        TriggerServerEvent("FRP:HORSE:RequestMyHorseInfo")

        local timeoutatgametimer = GetGameTimer() + (3 * 1000)

        while horseModel == nil and timeoutatgametimer > GetGameTimer() do
            Citizen.Wait(0)
        end

        if horseModel == nil and horseName == nil then
            horseModel = "A_C_Horse_MP_Mangy_Backup"
            horseName = "Pangaré"
        end
    end

    cAPI.DestroyPlayerHorse()

    local ped = PlayerPedId()
    local pCoords = GetEntityCoords(ped)

    local modelHash = GetHashKey(horseModel)

    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Citizen.Wait(10)
        end
    end

    local spawnPosition

    if atCoords == nil then
        local x, y, z = table.unpack(pCoords)
        local bool, nodePosition = GetClosestVehicleNode(x, y, z, 1, 3.0, 0.0)

        local index = 0
        while index <= 25 do
            local _bool, _nodePosition = GetNthClosestVehicleNode(x, y, z, index, 1, 3.0, 2.5)
            if _bool == true or _bool == 1 then
                bool = _bool
                nodePosition = _nodePosition
                index = index + 3
            else
                break
            end
        end

        spawnPosition = nodePosition
    else
        spawnPosition = atCoords
    end

    if spawnPosition == nil then
        initializing = false
        return
    end

    -- iVar7 = PED::_0xE8D1CCB9375C101B(iVar2, PLAYER::PLAYER_ID());
	-- 				if (iVar7 == -1 || iVar7 == 0)
	-- 				{
	-- 					iVar7 = iVar6;
    -- 					PED::_0xA691C10054275290(iVar2, PLAYER::PLAYER_ID(), iVar7);
    
    -- 0x641351E9AD103890
    -- 0xAFFD0CCF31F469B8(iVar0);

    local entity = CreatePed(modelHash, spawnPosition, GetEntityHeading(ped), true, true)
    SetModelAsNoLongerNeeded(modelHash)

    -- Citizen.InvokeNative(0xD2CB0FB0FDCB473D, PlayerId(), entity)

    Citizen.InvokeNative(0x9587913B9E772D29, entity, 0)
    Citizen.InvokeNative(0x4DB9D03AC4E1FA84, entity, -1, -1, 0)

    Citizen.InvokeNative(0xBCC76708E5677E1D9, entity, 0)
    Citizen.InvokeNative(0xB8B6430EAD2D2437, entity, GetHashKey("PLAYER_HORSE"))
    Citizen.InvokeNative(0xFD6943B6DF77E449, entity, false)

    SetPedConfigFlag(entity, 324, true)
    SetPedConfigFlag(entity, 211, true)
    SetPedConfigFlag(entity, 208, true)
    SetPedConfigFlag(entity, 209, true)
    SetPedConfigFlag(entity, 400, true)
    SetPedConfigFlag(entity, 297, true)
    SetPedConfigFlag(entity, 136, false)
    SetPedConfigFlag(entity, 312, false)
    SetPedConfigFlag(entity, 113, false)
    SetPedConfigFlag(entity, 301, false)
    SetPedConfigFlag(entity, 277, true)
    SetPedConfigFlag(entity, 319, true)
    SetPedConfigFlag(entity, 6, true)

    SetAnimalTuningBoolParam(entity, 25, false)
    SetAnimalTuningBoolParam(entity, 24, false)

    TaskAnimalUnalerted(entity, -1, false, 0, 0)
    Citizen.InvokeNative(0x283978A15512B2FE, entity, true)

    cAPI.SetPlayerHorse(entity)

    Citizen.InvokeNative(0x283978A15512B2FE, entity, true)

    -- SetVehicleHasBeenOwnedByPlayer(playerHorse, true)
    SetPedNameDebug(entity, horseName)
    SetPedPromptName(entity, horseName)

    CreatePrompts(PromptGetGroupIdForTargetEntity(entity))

    if json.encode(horseComponents) ~= '[]' then
        for _, componentHash in pairs(horseComponents) do
            NativeSetPedComponentEnabled(entity, tonumber(componentHash))
        end
    end

    TaskGoToEntity(entity, ped, -1, 7.2, 2.0, 0, 0)

    SetPedConfigFlag(entity, 297, true) -- Enable_Horse_Leadin

    if horseModel == "A_C_Horse_MP_Mangy_Backup" then
        NativeSetPedComponentEnabled(entity, 0x106961A8) --sela
        --NativeSetPedComponentEnabled(entity, 0x20AA8620) --bag        
        NativeSetPedComponentEnabled(entity, 0x508B80B9) --blanket
        PromptSetEnabled(prompt_inventory, false)

        print("SET SADDLE" .. entity)
    else
        PromptSetEnabled(prompt_inventory, true)
    end
    
    initializing = false

    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseSpeedValue", 8)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseSpeedMinValue", false)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseSpeedMaxValue", 10);
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseSpeedEquipmentValue", bVar2)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseSpeedEquipmentMinValue", false)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseSpeedEquipmentMaxValue", 10)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseSpeedCapacityValue", bVar3)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseSpeedCapacityMinValue", false)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseSpeedCapacityMaxValue", 10)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseAccValue", bVar4)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseAccMinValue", false)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseAccMaxValue", 10)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseAccEquipmentValue", bVar5)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseAccEquipmentMinValue", false)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseAccEquipmentMaxValue", 10)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseAccCapacityValue", bVar6)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseAccCapacityMinValue", false)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseAccCapacityMaxValue", 10)

    -- Citizen.InvokeNative(0x8538F1205D60ECA6, horseEntity, "HorseHandling", GetHashKey('HORSE_HANDLING_RACE'))
    -- Citizen.InvokeNative(0x8538F1205D60ECA6, horseEntity, "HorseType", GetHashKey('HORSE_CLASS_RACE'))
    -- Citizen.InvokeNative(0x8538F1205D60ECA6, horseEntity, "HorseBreed", GetHashKey(fufrp_1359(iVar1)));
    -- Citizen.InvokeNative(0x8538F1205D60ECA6, horseEntity, "HorseCoat", GetHashKey('COAT_CHOCR'))
    -- Citizen.InvokeNative(0x8538F1205D60ECA6, horseEntity, "HorseGender", GetHashKey('HORSE_GENDER_FEMALE'))
end

Citizen.CreateThread(function()
    while true do

        if cAPI.GetPlayerHorse() ~= nil then
            local getHorseMood = Citizen.InvokeNative(0x42688E94E96FD9B4, cAPI.GetPlayerHorse(), 3, 0, Citizen.ResultAsFloat())

            if getHorseMood >= 0.02 then
                Citizen.InvokeNative(0x06D26A96CA1BCA75, cAPI.GetPlayerHorse(), 3, PlayerPedId())
                Citizen.InvokeNative(0xA1EB5D029E0191D3, cAPI.GetPlayerHorse(), 3, 0.99)
                print("ENTITY MOOD: " .. cAPI.GetPlayerHorse(), getHorseMood)
            end
        end
        Citizen.Wait(1000)                
    end
end) 

function SetHorseComponentEnabled(hash)
    local model2 = GetHashKey(tonumber(hash))
    if not HasModelLoaded(model2) then
        Citizen.InvokeNative(0xFA28FE3A6246FC30, model2)
    end
    Citizen.InvokeNative(0xD3A7B003ED343FD9, horseEntity, tonumber(hash), true, true, true)
end

function drawBoundingBox()
    if cAPI.IsPlayerHorseActive() then
        local playerHorse = cAPI.GetPlayerHorse()
        local min, max = GetModelDimensions(GetEntityModel(playerHorse))

        local horseCoords = GetEntityCoords(playerHorse)

        local z = min.z

        -- front = vec3(front.xy, z)
        -- local back =
        local A = GetOffsetFromEntityInWorldCoords(playerHorse, vec3(min.x, max.y, z))
        local B = GetOffsetFromEntityInWorldCoords(playerHorse, vec3(max.x, max.y, z))
        local C = GetOffsetFromEntityInWorldCoords(playerHorse, min)
        local D = GetOffsetFromEntityInWorldCoords(playerHorse, vec3(max.x, min.y, z))

        local coords = horseCoords - vec3(0, 0, 1.0)

        -- DrawLine(coords, front, 0, 255, 0, 255)
        DrawLine(coords, A, 255, 255, 255, 255)
        DrawLine(coords, B, 255, 255, 255, 255)
        DrawLine(coords, C, 255, 255, 255, 255)
        DrawLine(coords, D, 255, 255, 255, 255)

        -- raycastDrinkable()
        raycastEatable()
    end
end

function raycastDrinkable()
    local playerHorse = cAPI.GetPlayerHorse()
    local boneIndex = GetEntityBoneIndexByName(playerHorse, "skel_head")
    local bonePosition = GetWorldPositionOfEntityBone(playerHorse, boneIndex)
    local groundCoords = vec3(bonePosition.xy, A.z)
    local waterPosition = vec3(table.unpack(exports["frp_horse"]:js_native(bonePosition.x, bonePosition.y, bonePosition.z, groundCoords.x, groundCoords.y, groundCoords.z)))
    if waterPosition.x ~= 127 and waterPosition.y ~= 0 and waterPosition.z ~= 0 then
        DrawLine(bonePosition, waterPosition, 0, 0, 255, 255)
    else
        DrawLine(bonePosition, groundCoords, 255, 0, 0, 255)
    end
    DrawLine(coords, bonePosition, 255, 255, 0, 255)
end

function raycastEatable()
    local playerHorse = cAPI.GetPlayerHorse()
    local min, max = GetModelDimensions(GetEntityModel(playerHorse))

    local horseCoords = GetEntityCoords(playerHorse)

    local z = min.z

    local A = GetOffsetFromEntityInWorldCoords(playerHorse, vec3(min.x, max.y, z))

    local boneIndex = GetEntityBoneIndexByName(playerHorse, "skel_head")
    local bonePosition = GetWorldPositionOfEntityBone(playerHorse, boneIndex)

    local groundCoords = vec3(bonePosition.xy, A.z)

    local shapeTestRay = StartShapeTestRay(bonePosition, groundCoords, 256, playerHorse, 0)

    local retVal, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(shapeTestRay)

    if hit ~= 0 then
        DrawLine(bonePosition, endCoords, 255, 255, 0, 255)
    end
end

-- function setHorseComponents(components)
--     horseComponents = components
--     for _, componentHash in pairs(horseComponents) do
--         Citizen.InvokeNative(0xD3A7B003ED343FD9, horseEntity, componentHash, true, true, true)
--     end
-- end

AddEventHandler(
    "FRP:EVENTS:PedWhistle",
    function(ped, whistleTypeHash)
        if ped == PlayerPedId() then
            WhistleHorse(whistleTypeHash)
        end
    end
)

function WhistleHorse(whistleTypeHash)
    local whistleType = "SHORT"

    if whistleTypeHash == 869278708 then
        whistleType = "LONG"
    end

    if cAPI.IsPlayerHorseActive() and not cAPI.IsPlayerHorseActivationBlocked() then
        local playerHorse = cAPI.GetPlayerHorse()
        if whistleType == "SHORT" then
            if GetScriptTaskStatus(playerHorse, 0x4924437D, 0) ~= 0 then
                TaskGoToEntity(playerHorse, PlayerPedId(), -1, 7.2, 2.0, 0, 0)
            end
        elseif whistleType == "LONG" then
            if GetScriptTaskStatus(playerHorse, 0x3EF867F4, 0) ~= 1 then
                TaskFollowToOffsetOfEntity(playerHorse, PlayerPedId(), math.random(0.0, 3.0), math.random(0, 3.0), 0.0, 1.0, -1, 10.0, 1)
            else
                ClearPedTasks(playerHorse)
            end
        end
    else
        if not cAPI.IsPlayerHorseActivationBlocked() and cAPI.IsPlayerInitialized() then
            -- DEBUGGGING
            -- InitiateHorse(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.0, 1.0, 0.0))
            InitiateHorse()
        else
            cAPI.notify("error", "Seu cavalo está ferido, aguarde 2 minutos.")
        end
    end
end



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local playerHorse = cAPI.GetPlayerHorse()
		local retval, weaponHash = GetCurrentPedWeapon(playerHorse, 1)       

        if weaponHash == GetHashKey("WEAPON_HORSE") then
            Citizen.InvokeNative(0x66460DEDDD417254, 0.001)
            Citizen.InvokeNative(0xE4CB5A3F18170381, playerHorse, 0.001)
        end  
    end
end)


function CreatePrompts(prompt_group)
    if prompt_inventory ~= nil then
        PromptDelete(prompt_inventory)
    end

    if prompt_eat ~= nil then
        PromptDelete(prompt_eat)
    end

    if prompt_drink ~= nil then
        PromptDelete(prompt_drink)
    end

    if prompt_brush ~= nil then
        PromptDelete(prompt_brush)
    end
    
    prompt_inventory = PromptRegisterBegin()
    PromptSetControlAction(prompt_inventory, 0x5966D52A)
    PromptSetText(prompt_inventory, CreateVarString(10, "LITERAL_STRING", "Abrir Aforje"))
    PromptSetEnabled(prompt_inventory, 1)
    PromptSetVisible(prompt_inventory, 1)
    PromptSetStandardMode(prompt_inventory, 1)
    PromptSetGroup(prompt_inventory, prompt_group)
    -- Citizen.InvokeNative(0x0C718001B77CA468, prompt_inventory, 1.5)
    PromptRegisterEnd(prompt_inventory)

    prompt_eat = PromptRegisterBegin()
    PromptSetControlAction(prompt_eat, 0xB4E465B4)
    PromptSetText(prompt_eat, CreateVarString(10, "LITERAL_STRING", "Mandar Pastar"))
    PromptSetEnabled(prompt_eat, 1)
    PromptSetVisible(prompt_eat, 0)
    PromptSetStandardMode(prompt_eat, 1)
    PromptSetGroup(prompt_eat, prompt_group)
    -- Citizen.InvokeNative(0x0C718001B77CA468, prompt_eat, 1.5)
    PromptRegisterEnd(prompt_eat)

    -- 0x24978A28

    prompt_drink = PromptRegisterBegin()
    PromptSetControlAction(prompt_drink, 0xEB2AC491)
    PromptSetText(prompt_drink, CreateVarString(10, "LITERAL_STRING", "Mandar Beber"))
    PromptSetEnabled(prompt_drink, 1)
    PromptSetVisible(prompt_drink, 0)
    PromptSetStandardMode(prompt_drink, 1)
    PromptSetGroup(prompt_drink, prompt_group)
    -- Citizen.InvokeNative(0x0C718001B77CA468, prompt_drink, 1.5)
    PromptRegisterEnd(prompt_drink)

    prompt_brush = PromptRegisterBegin()
    PromptSetControlAction(prompt_brush, 0x9959A6F0)
    PromptSetText(prompt_brush, CreateVarString(10, "LITERAL_STRING", "Escovar"))
    PromptSetEnabled(prompt_brush, 1)
    PromptSetVisible(prompt_brush, 1)
    PromptSetStandardMode(prompt_brush, 1)
    PromptSetGroup(prompt_brush, prompt_group)
    -- Citizen.InvokeNative(0x0C718001B77CA468, prompt_brush, 1.5)
    PromptRegisterEnd(prompt_brush)
end

local _tempplayerhorse

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            if PromptIsJustPressed(prompt_inventory) then
                TriggerServerEvent("FRP:HORSE:OpenInventory")
            end

            if PromptIsJustPressed(prompt_brush) then
                local playerHorse = cAPI.GetPlayerHorse()
                TaskAnimalInteraction(PlayerPedId(), playerHorse, GetHashKey("INTERACTION_BRUSH"), GetHashKey("p_brushhorse01x"), 1)
                Citizen.CreateThread(
                    function()
                        Citizen.Wait(10000)
                        Citizen.InvokeNative(0x314C5465195F3B30, playerHorse, 0.0) -- SetMetapedWeariness
                        ClearPedEnvDirt(playerHorse)
                    end
                )
            end

            if PromptIsJustPressed(prompt_eat) then
                ActionEat()
            end

            if PromptIsJustPressed(prompt_drink) then
                ActionDrink()
            end

            -- if IsControlJustPressed(0, 0xE7EB9185) or IsControlJustPressed(1, 0x24978A28) then -- H, HistleHorseBack - H, Histle
            -- if GetScriptTaskStatus(PlayerPedId(), 0x1DE2A7BD, 0) ~= 1 then
            --     local mount = GetMount(PlayerPedId())

            --     if CanHorseDrink() then
            --         HandleDrink()
            --     elseif CanHorseEat() then
            --         HandleEat()
            --     else
            -- if IsControlJustPressed(0, 0x24978A28) then -- H, Histle

            -- -- end
            --     end
            -- end
            -- end

            -- TaskHorseAction 2 | Derrubar
            -- TaskHorseAction 5 | Empinar
            -- TaskHorseAction 3 | Freiada Brusca

            if IsControlJustPressed(0, 0x7D5B3717) then
                local mount = GetMount(PlayerPedId())
                if mount ~= 0 then
                    TaskHorseAction(mount, 5, 0, 0)
                end
            end

            -- if _tempplayerhorse then
            --     if IsPedPerformingMeleeAction(_tempplayerhorse, 32768, GetHashKey("AR_HORSE_KICK_REAR")) or IsPedPerformingMeleeAction(_tempplayerhorse, 32768, GetHashKey("AR_HORSE_KICK_LEFT")) or IsPedPerformingMeleeAction(_tempplayerhorse, 32768, GetHashKey("AR_HORSE_KICK_RIGHT")) or IsPedPerformingMeleeAction(_tempplayerhorse, 32768, GetHashKey("AR_HORSE_KICK_FRONT")) then
            --         if GetMeleeTargetForPed(_tempplayerhorse) == PlayerPedId() then
            --             ClearPedTasks(_tempplayerhorse)
            --         end
            --     end
            -- end

            --- bugado o cavalo não volta a correr
            --[[ if IsControlJustPressed(0, 0xE16B9AAD) then
                local mount = GetMount(PlayerPedId())
                if mount ~= 0 then
                    TaskHorseAction(mount, 3, 0, 0)
                end
            end ]]
            -- drawBoundingBox()

            if IsControlJustPressed(0, 0x60C81CDE) then -- Horse attack F
                local ped = PlayerPedId()
                local mount = GetMount(ped)
                if mount ~= 0 then
                    -- local lassoedPlayerPed

                    -- local itemSet = CreateItemset(true)
                    -- FindAllAttachedCarriableEntities(GetMount(ped), itemSet)
                    -- local size = GetItemsetSize(itemSet)

                    -- if size > 0 then
                    --     for index = 0, size - 1 do
                    --         local entity = GetIndexedItemInItemset(index, itemSet)

                    --         if IsEntityAPed(entity) and IsPedHuman(entity) and Citizen.InvokeNative(0x9682F850056C9ADE, entity) then
                    --             lassoedPlayerPed = entity
                    --         end
                    --     end
                    -- end

                    -- if IsItemsetValid(itemSet) then
                    --     DestroyItemset(itemSet)
                    -- end

                    -- local carriedPed = Citizen.InvokeNative(0xB676EFDA03DADA52, mount, true)

                    -- if carriedPed ~= nil and IsPedAPlayer(carriedPed) then

                    local carriedPlayer

                    for _, pid in pairs(GetActivePlayers()) do
                        local pped = GetPlayerPed(pid)
                        local carrier = Citizen.InvokeNative(0xA033D7E4BBF9844D, pped)

                        if carrier == mount then
                            carriedPlayer = pid
                            break
                        end
                    end

                    if carriedPlayer then
                        local carriedPlayerServerId = GetPlayerServerId(carriedPlayer)

                        TriggerServerEvent("FRP:HORSE:HitCarriedPlayer", carriedPlayerServerId)

                        local animDict = "script_proc@bounty@riding_punch"
                        RequestAnimDict(animDict)

                        while not HasAnimDictLoaded(animDict) do
                            Citizen.Wait(0)
                        end

                        TaskPlayAnim(ped, "script_proc@bounty@riding_punch", "punch_player", 4.0, -4.0, -1, 24, 0.0, false, 0, false, 0, false)
                    end
                -- end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(500)

            local eatVisible = CanHorseEat()
            local drinkVisible = CanHorseDrink()

            PromptSetVisible(prompt_eat, eatVisible)
            PromptSetVisible(prompt_drink, drinkVisible)

            if cAPI.IsPlayerHorseActive() then
                local playerHorse = cAPI.GetPlayerHorse()

                _tempplayerhorse = playerHorse

                local dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(playerHorse))

                if horseModel ~= "A_C_Horse_MP_Mangy_Backup" then
                    if dist > 1.5 then
                        PromptSetEnabled(prompt_inventory, false)
                    else
                        PromptSetEnabled(prompt_inventory, true)
                    end
                end


           --     GetPedComponentAtIndex(playerHorse, )
            end
        end
    end
)

RegisterNetEvent("FRP:HORSE:PlayBeingHitAnim")
AddEventHandler(
    "FRP:HORSE:PlayBeingHitAnim",
    function()
        local animDict = "script_proc@bounty@riding_punch"
        RequestAnimDict(animDict)

        while not HasAnimDictLoaded(animDict) do
            Citizen.Wait(0)
        end

        TaskPlayAnim(PlayerPedId(), "script_proc@bounty@riding_punch", "punch_ped", 4.0, -4.0, -1, 24, 0.0, false, 0, false, 0, false)
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if GetCurrentResourceName() == resourceName or resourceName == "_core" then
            cAPI.DestroyPlayerHorse()
        end
    end
)
