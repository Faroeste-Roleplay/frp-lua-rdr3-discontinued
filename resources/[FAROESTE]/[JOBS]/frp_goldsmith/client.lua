local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local nearMiningSpotIndex
local nearRefiningSpotIndex
local prompt
local promptGroup
local varString
local holdModeOn = false
local isMining = false
local carriables = {}

Citizen.CreateThread(
    function()
        -- // 0x18FF3110CF47115D
        -- void _TOGGLE_FLAG

        -- flags
        -- 2 = can pickup from ground
        -- 11 = ? place on ground when spawned
        -- 4 = can put on the ground

        while true do
            Citizen.Wait(1000)
            local pedVector = GetEntityCoords(PlayerPedId())

            nearMiningSpotIndex = nil
            nearRefiningSpotIndex = nil

            local lastDist = 50

            for _, v in pairs(Config.LocationsProcess) do
                local ve = vec3(v[1], v[2], v[3])
                local dist = #(pedVector - ve)
                if dist < lastDist then
                    nearRefiningSpotIndex = _
                    lastDist = dist

                    if GetClosestObjectOfType(ve, 2.5, 942176598, false, false, false) == 0 then
                        if not HasModelLoaded(942176598) then
                            RequestModel(942176598)
                            while not HasModelLoaded(942176598) do
                                Citizen.Wait(10)
                            end
                        end
                        
                        local obj = CreateObject(942176598, ve, true, true, false, true, true)
                        PlaceObjectOnGroundProperly(obj)
                        FreezeEntityPosition(obj, true)
                        -- SetModelAsNoLongerNeeded(942176598)
        
                        Citizen.InvokeNative(0x7DFB49BCDB73089A, obj, true)
                    end
                end
            end

            if nearMiningSpotIndex == nil and nearRefiningSpotIndex == nil then
                PromptDelete(prompt)
                prompt = nil
                promptGroup = nil
                varString = nil
            end

            for _, carriable in pairs(carriables) do
                if not DoesEntityExist(carriable) then
                    carriables[_] = nil
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        ClearPedTasksImmediately(PlayerPedId())
        while true do
            Citizen.Wait(0)

            if nearRefiningSpotIndex ~= nil and isRefining == false then
                local d = Config.LocationsProcess[nearRefiningSpotIndex]
                local v = vec3(d[1], d[2], d[3])

                if #(pedVector - v) <= 1.5 then
                    drawPrompt()
                    if PromptIsJustPressed(prompt) then
                        TriggerServerEvent("FRP:GOLDSMITH:TryToStartRefining")
                    end
                end
            end
        end
    end
)

function drawPrompt(refining)
    if prompt == nil then
        local text = "Começar"
        varString = CreateVarString(10, "LITERAL_STRING", "Mineirar")
        if refining then
            text = "Começar"
            varString = CreateVarString(10, "LITERAL_STRING", "Processamento")
        end

        prompt = PromptRegisterBegin()
        promptGroup = GetRandomIntInRange(0, 0xffffff)
        PromptSetControlAction(prompt, 0x7F8D09B8)
        PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", text))
        PromptSetEnabled(prompt, 1)
        PromptSetVisible(prompt, 1)
        PromptSetStandardMode(prompt, true)
        PromptSetGroup(prompt, promptGroup)
        PromptRegisterEnd(prompt)
    end
    PromptSetActiveGroupThisFrame(promptGroup, varString)
end


RegisterNetEvent("FRP:GOLDSMITH:StartMiningAnimation")
AddEventHandler(
    "FRP:GOLDSMITH:StartMiningAnimation",
    function()
        isMining = true
        TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_PICKAXE_WALL"), 20000, true, false, false, false)
        -- exports['progressBars']:startUI(2000, 'Minerando')
        Wait(20000)
        ClearPedTasksImmediately(PlayerPedId())
        isMining = false

        TriggerServerEvent("FRP:GOLDSMITH:CollectMineral")
    end
)

RegisterNetEvent("FRP:GOLDSMITH:StartProcessingAnimation")
AddEventHandler(
    "FRP:GOLDSMITH:StartProcessingAnimation",
    function(num)
        TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_CLEAN_TABLE"), 20000, true, false, false, false) -- colocar uma animação para processar
        --exports['progressBars']:startUI(20000, Language.translate[Config.lang]['process'])
        Wait(20000)
        -- TriggerServerEvent("FRP:GOLDSMITH:processitem", num)
        ClearPedTasksImmediately(PlayerPedId())
    end
)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    Citizen.InvokeNative(0xADA9255D, 10)
    DisplayText(str, x, y)
end

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end
