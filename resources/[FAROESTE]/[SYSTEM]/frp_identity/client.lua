local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local fakePeds = {}
local playerSelected = false

RegisterNetEvent("FRP:IDENTITY:DisplayCharSelection")
AddEventHandler(
    "FRP:IDENTITY:DisplayCharSelection",
    function(characterArray, charAppearence)
        Destroy()

        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER

        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER

        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER

        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER

        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER
        -- O characterARRAY tá enviando TODA INFORMAÇÃO DO CHARACTER

        cAPI.PlayerAsInitialized(false)

        local playerPed = PlayerPedId()

        SetFocusEntity(playerPed) 
        SetEntityInvincible(playerPed, true)
        SetEntityVisible(playerPed, false)
        NetworkSetEntityInvisibleToNetwork(playerPed, true)

        TriggerEvent("FRP:IDENTITY:SetTime")

        ShutdownLoadingScreen()
        createCamera()

        SendNUIMessage({type = 2}) -- clear UI

        Wait(2500)

        SetNuiFocus(true, true)
        SendNUIMessage(
            {
                type = 1,
                list = characterArray
            }
        )

        local fakePedCoords = {
            vec3(883.233,1269.009,234.920 - 0.98),            
            vec3(886.051,1272.002,235.121 - 0.98),            
            vec3(883.233,1269.009,234.920 - 0.98),
            vec3(885.192,1271.949,235.108 - 0.98)
        }

        if charAppearence ~= nil then
            for i = 1, #charAppearence do           

                if not HasModelLoaded(charAppearence[i][1].model) then
                    RequestModel(charAppearence[i][1].model)
                    while not HasModelLoaded(charAppearence[i][1].model) do
                        Citizen.Wait(10)
                    end
                end

                local ped = CreatePed(charAppearence[i][1].model, fakePedCoords[i], 350.77, 0, 0)

                Citizen.Wait(300)
                
                cAPI.SetSkin(ped, charAppearence[i][1].enabledComponents)   

                cAPI.SetPedFaceFeature(ped, charAppearence[i][1].faceFeatures)
                
                cAPI.SetPedScale(ped, charAppearence[i][1].pedHeight)

                cAPI.SetPedOverlay(ped, charAppearence[i][1].overlays)
                
                local bodySize = json.decode(charAppearence[i][1].enabledComponents)

                cAPI.SetPedPortAndWeight(ped, tonumber(bodySize['porte']), charAppearence[i][1].pedWeight)

                if charAppearence[i][1].clothes ~= nil then
                    cAPI.SetSkin(ped, charAppearence[i][1].clothes)   
                end

                table.insert(fakePeds, ped)
                            
                local coords = GetEntityCoords(ped, false)
                
                Citizen.InvokeNative(0x322BFDEA666E2B0E, ped,  coords.x, coords.y, coords.z, 5.0, -1, 1, 1, 1, 1)                
            end
        end
    end
)


RegisterNetEvent("FRP:IDENTITY:SetTime")
AddEventHandler(
    "FRP:IDENTITY:SetTime",
    function()
    while not playerSelected do
        Citizen.Wait(0)
        SetClockTime(14,01,01)
    end

end)

function Destroy()
    for _, ped in pairs(fakePeds) do
        DeleteEntity(ped)
    end

    if cam ~= nil then
        if DoesCamExist(cam) then
            DestroyCam(cam, true)
        end
    end

    FreezeEntityPosition(PlayerPedId(), false)
    fakePeds = {}

    playerSelected = false
    
    DestroyCam(tempCam, true)
    tempCam = nil

    local playerPed = PlayerPedId()

    Wait(1500)

    SetFocusEntity(playerPed) 
    SetEntityInvincible(playerPed, false)
    SetEntityVisible(playerPed, true)
    NetworkSetEntityInvisibleToNetwork(playerPed, false)
end

RegisterNUICallback(
    "createCharacter",
    function()
        SetNuiFocus(false, false)
        TriggerEvent("FRP:CHARCREATION:starting")
        Destroy()
    end
)

function createTempCam()
    tempCam = CreateCam("DEFAULT_SCRIPTED_CAMERA")
    SetCamActive(tempCam, true)
end

function interpCamera(entity)
    local entityCoords = GetEntityCoords(entity)

    AttachCamToEntity(tempCam, entity, 884.872 - entityCoords.x, 0.0, 0.6)

    local entityRot = GetEntityRotation(entity)
    SetCamRot(tempCam, entityRot.x, entityRot.y, entityRot.z - 180.0)
    
    SetCamActiveWithInterp(tempCam, cam, 1200, true, true)    
end


RegisterNUICallback(
    "selectCharacter",
    function(index)
        index = index + 1

        if fakePeds[index] ~= nil then
            if tempCam == nil then
                createTempCam()
            end

            interpCamera(fakePeds[index])
        end
    end
)



RegisterNUICallback(
    "spawnCharacterSelected",
    function(charId)
        SetNuiFocus(false, false)
        DisplayHud(true)
        TriggerServerEvent("FRP:IDENTITY:selectCharacter", charId)
        cAPI.StartFade(500)
        Citizen.Wait(500)
        Destroy()        
        playerSelected = false
        NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
        SetEntityInvincible(PlayerPedId(), false)
        Wait(1800)
        cAPI.EndFade(500)
    end
)

RegisterNUICallback(
    "deleteCharacter",
    function(charId)
        TriggerServerEvent("FRP:IDENTITY:deleteCharacter", charId)
        TriggerEvent("FRP:NOTIFY:Simple", "Personagem deletado.")
    end
)

RegisterCommand(
    "Deletarenti",
    function()
        Destroy()
    end
)

function createCamera()
    DisplayHud(false)

    NetworkSetEntityInvisibleToNetwork(PlayerPedId(), true)
    SetEntityInvincible(PlayerPedId(), true)
    SetEntityCoords(PlayerPedId(), 881.128,1263.624,234.630)
    FreezeEntityPosition(PlayerPedId(), true)

    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 881.128,1263.624,236.630, 0.00, 0.00, 0.00, 50.00, false, 0) -- CAMERA COORDS
    PointCamAtCoord(cam, 882.818,1265.922, 235.682)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() or resourceName == "_core" then
            Destroy()
        end
    end
)
