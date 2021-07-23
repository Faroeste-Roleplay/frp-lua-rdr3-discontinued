-- local Tunnel = module('_core', 'lib/Tunnel')
-- local Proxy = module('_core', 'lib/Proxy')

-- cAPI = Proxy.getInterface('API')
-- API = Tunnel.getInterface('API')

local pedsSpawned = {}

local postUsing = 0

local postManPrompt = nil
local postManGroup = GetRandomIntInRange(0, 0xffffff)

local steps = 0
local Cards = 0
local SettedRoute = nil
local blip = {}
local timer = 0

local WorkStations = {
    {
        -- ped = "U_M_M_RhdTrainStationWorker_01",
        x = 2748.02,
        y = -1396.81,
        z = 45.1,
        h = 21.20,
        Posts = {
            {
                x = 2731.64,
                y = -1402.33,
                z = 46.18
            }
        },
        Routes = {
            {x = 2476.3903808594, y = -1257.2432861328, z = 48.32202911377},
            {x = 2435.4719238281, y = -1250.4569091797, z = 45.889453887939},
            {x = 2400.3029785156, y = -1129.0904541016, z = 46.823177337646},
            {x = 2841.1586914063, y = -1077.8255615234, z = 45.365314483643},
            {x = 2525.9570312543, y = -1129.5076904297, z = 49.87043762207},
            {x = 2545.8195800781, y = -1129.0428466797, z = 50.571140289307},
            {x = 2555.8884277344, y = -1129.6837158203, z = 50.61877822876},
            {x = 2722.9196777344, y = -1275.5471191406, z = 49.625667572021}
        }
    }
}

local varString_carteiro = CreateVarString(10, "LITERAL_STRING", "Carteiro")

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if timer == 0 then
                local posPlayer = GetEntityCoords(PlayerPedId())

                if steps >= 1 then
                    DrawText("Você possui " .. Cards .. " cartas", 0.925, 0.96, 0.4, 0.4, false, 255, 255, 255, 145, 1, 7)
                end

                if steps == 0 then
                    for i = 1, #pedsSpawned, 0 do
                        local posPed = GetEntityCoords(pedsSpawned[i])
                        if #(vec3(posPed - posPlayer)) <= 2.5 then
                            notifyHelp("Bem vindo, senhor.")
                            PromptSetActiveGroupThisFrame(postManGroup, varString_carteiro)
                            if PromptHasHoldModeCompleted(postManPrompt) then
                                steps = 1
                            end
                        end
                    end
                elseif steps == 1 then
                    notifyHelp(" ")
                    if Cards < 15 then
                        if GetDistanceBetweenCoords(getPosts().x, getPosts().y, getPosts().z, posPlayer[0], posPlayer[1], posPlayer[2]) < 2.5 then
                            PromptSetText(postManPrompt, CreateVarString(10, "LITERAL_STRING", "Pegar Cartas"))
                            PromptSetActiveGroupThisFrame(postManGroup, varString_carteiro)
                            if PromptHasHoldModeCompleted(postManPrompt) then
                                Citizen.Wait(100)
                                playAnim("mech_pickup@loot@horse_saddlebags@live@lt", "base", 1.0)
                                Citizen.Wait(3700)
                                Cards = Cards + 1
                                setSatchel(0xEA272E11)
                            end
                        end
                    else
                        steps = 2
                        SettedRoute = getRoute()
                    end
                elseif steps == 2 then
                    if DoesBlipExist(blip[steps]) then
                        CreateBlip(steps, SettedRoute, "Entregue suas Cartas", -1656531561)
                    else
                        if Cards ~= 0 then
                            if GetDistanceBetweenCoords(SettedRoute.x, SettedRoute.y, SettedRoute.z, posPlayer[0], posPlayer[1], posPlayer[2]) < 4.5 then
                                PromptSetText(postManPrompt, CreateVarString(10, "LITERAL_STRING", "Jogar Carta"))
                                PromptSetActiveGroupThisFrame(postManGroup, varString_carteiro)
                                if PromptHasHoldModeCompleted(postManPrompt) then
                                    Citizen.Wait(100)
                                    Cards = Cards - 1
                                    SettedRoute = getRoute()
                                    DeleteBlips()
                                end
                            end
                        else
                            notifyHelp("Suas cartas acabaram, aguarde 20 minutos e vá para o posto novamente.")
                            DeleteBlips()
                            timer = 1200
                            steps = 0
                            postUsing = 0
                            SettedRoute = nil
                        end
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            local model = GetHashKey("U_M_M_RhdTrainStationWorker_01")

            print("sdad")

            RequestModel(model)

            print("sdasdasd")

            while not HasModelLoaded(model) do
                Citizen.Wait(10)
            end

            print("du")

            for i = 1, #WorkStations, 0 do
                -- if pedsSpawned[i] == nil then
                print("yes")
                if GetNearestPedAtOfTypeAtCoord(model, WorkStations[i].x, WorkStations[i].y, WorkStations[i].z, 2.5) == 0 then
                    pedsSpawned[i] = CreatePed(model, WorkStations[i].x, WorkStations[i].y, WorkStations[i].z, WorkStations[i].h, 1, 0)

                    SetPedOutfitPreset(pedsSpawned[i], 2, false)
                    FreezeEntityPosition(pedsSpawned[i], true)
                    PlaceObjectOnGroundProperly(pedsSpawned[i], true)
                end

                if blip["start" .. i] == nil then
                    CreateBlip("start" .. i, WorkStations[i], "Correio", 1861010125)
                end

                postUsing = i
                -- end
            end

            if time > 0 then
                timer = timer - 1
            end
        end
    end
)

function DeleteBlips()
    RemoveBlip(blip[steps])
end

function getRoute()
    return WorkStations[postUsing].Routes[Math.floor(Math.random() * #WorkStations[postUsing].Routes)]
end

function setSatchel(model)
    if HasModelLoaded(model) then
        Citizen.InvokeNative(0xFA28FE3A6246FC3, parseInt(model))
    end
    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), parseInt(model), true, true, true)
end

function getPosts()
    for i = 1, #WorkStations[postUsing].Posts, 0 do
        return WorkStations[postUsing].Posts[i]
    end
end

Citizen.CreateThread(
    function()
        Citizen.Wait(1000)
        createPrompt()
    end
)

function createPrompt()
    if PromptIsValid(postManPrompt) then
        postManPrompt = PromptRegisterBegin()
        PromptSetControlAction(postManPrompt, 0xE8342FF2)
        PromptSetText(postManPrompt, CreateVarString(10, "LITERAL_STRING", "Pegar Emprego"))
        PromptSetEnabled(postManPrompt, 1)
        PromptSetVisible(postManPrompt, 1)
        PromptSetHoldMode(postManPrompt, 1)
        PromptSetGroup(postManPrompt, postManGroup)
        PromptRegisterEnd(postManPrompt)
    end
end

-- AddEventHandler(
--     "onResourceStop",
--     function(resourceName)
--         if GetCurrentResourceName() == resourceName then
--             -- for _, prompt in pairs(prompts) do
--             PromptDelete(prompt)
--         -- end
--         end
--         for i = 1, #pedsSpawned, 0 do
--             SetEntityCoords(pedsSpawned[i], 0, 0, 0)
--             SetEntityAlpha(pedsSpawned[i], 0)
--             SetEntityCompletelyDisableCollision(pedsSpawned[i], true, true)
--             RemoveBlip(blip["start" .. i])
--         end
--         DeleteBlips()
--     end
-- )

function DrawText(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre, font)
    SetTextScale(w, h)
    SetTextColor(Math.floor(col1), Math.floor(col2), Math.floor(col3), Math.floor(a))
    SetTextCentre(centre)
    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    Citizen.InvokeNative(0xADA9255D, font)
    DisplayText(CreateVarString(10, "LITERAL_STRING", str), x, y)
end

function notifyHelp(_message)
    SetTextScale(0.25, 0.25)
    SetTextCentre(1)
    Citizen.InvokeNative(0xFA233F8FE190514C, CreateVarString(10, "LITERAL_STRING", _message))
    Citizen.InvokeNative(0xE9990552DEC71600)
end

local noCrash = nil

function playAnim(dict, anim, speed)
    if IsEntityPlayingAnim(PlayerPedId(), dict, anim) then
        RequestAnimDict(dict)
        -- while HasAnimDictLoaded(dict) && !noCrash do
        --     -- noCrash = setTimeout(function ()
        --     --     RequestAnimDict(dict)
        --     -- }, 1000);
        -- end
        TaskPlayAnim(PlayerPedId(), dict, anim, speed, 1.0, -1, 0, 0, 0, 0, 0, 0, 0)
    end
end

function CreateBlip(id, pos, name, sprite)
    blip[id] = N_0x554d9d53f696d002(1664425300, pos.x, pos.y, pos.z)
    SetBlipSprite(blip[id], sprite, 1)
    SetBlipScale(blip[id], 0.2)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip[id], name)
end

function GetNearestPedAtOfTypeAtCoord(modelHash, x, y, z, radius)
    local itemSet = CreateItemset(true)
    local size = Citizen.InvokeNative(0x59B57C4B06531E1E, x, y, z, radius, itemSet, 1, Citizen.ResultAsInteger())
    -- number xPos, number yPox, number zPos, float distance, int itemSet, int entityType

    if size > 0 then
        for index = 0, size - 1 do
            local entity = GetIndexedItemInItemset(index, itemSet)
            if GetEntityModel(entity) == modelHash then
                return entity
            end
        end
    end

    if IsItemsetValid(itemSet) then
        DestroyItemset(itemSet)
    end

    return 0
end
