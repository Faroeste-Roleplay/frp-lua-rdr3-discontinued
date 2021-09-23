local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

adding = true
vpcreator = false
inCustomization = false
groundCam = nil
hided = false
spawnedCamera = nil
choosePed = {}
pedSelected = nil
sex = nil
InterP = false
InterP2 = false
zoom = 1.0
offset = 0.5
fixedCam = nil
tempCam2 = nil
tempCam = nil
groundCam = nil
--
--[[ Male {}
A_M_M_CHELONIAN_01
A_M_M_FOREMAN
]] local light = {
    {x = -559.59, y = -3780.757, z = 238.59, r = 50.0, f = 50.0}
}

local peds = {
    {genrer = "mp_male", x = -558.9098, y = -3775.616, z = 238.59, h = 137.98},
    {genrer = "mp_female", x = -558.9098, y = -3776.978, z = 238.59, h = 47.11}
}

local cams = {
    {
        type = "customization",
        x = -561.8157,
        y = -3780.966,
        z = 239.0805,
        rx = -4.2146,
        ry = -0.0007,
        rz = -87.8802,
        fov = 30.0
    },
    {
        type = "selection",
        x = -562.8157,
        y = -3776.266,
        z = 239.0805,
        rx = -4.2146,
        ry = -0.0007,
        rz = -87.8802,
        fov = 30.0
    }
}

cameraUsing = {
    {
        name = "Selection",
        x=-1.0,
        y=0.0,
        z=0.5,
    },
    {
        name = "Rosto",
        x=-0.5,
        y=0.0,
        z=0.6,
    },
    {
        name = "Corpo",
        x=-1.3,
        y=0.0,
        z=0.4,
    },
}


Citizen.CreateThread(
    function()
        RequestImap(-1699673416)
        RequestImap(1679934574)
        RequestImap(183712523)
        while true do
            Citizen.Wait(0)
            if vpcreator then
                for k, v in pairs(light) do
                    DrawLightWithRange(light[k].x, light[k].y, light[k].z, 255, 255, 255, light[k].r, light[k].f)
                end
            end
            if vpcreator and not inCustomization then
                if groundCam == nil then
                    DisplayHud(false)
                  --  createCam("selection")                  
                    createPeds()
                    DestroyAllCams(true)
                    createCamera()
                    TriggerEvent('FRP:NOTIFY:Simple', 'Utilize as setas do seu teclado e aperte enter para escolher um personagem.', 15000)
                else
                    for k, v in pairs(choosePed) do
                        if IsControlJustReleased(0, 0xA65EBAB4) and GetEntityModel(choosePed[k]) == GetHashKey("mp_male") then -- male
                        --   AttachCamToEntity(cam, choosePed[k], -3.5, 0.0, 0.5, false)
                            InterP = true
                            interpCamera("Selection", choosePed[k])
                            PlaySoundFrontend("gender_left", "RDRO_Character_Creator_Sounds", true, 0)
                            pedSelected = choosePed[k]
                            sex = "mp_male"
                        elseif IsControlJustReleased(0, 0xDEB34313) and GetEntityModel(choosePed[k]) == GetHashKey("mp_female") then --female
                        --   AttachCamToEntity(cam, choosePed[k], -3.5, 0.0, 0.5, false)
                            InterP = true   
                            interpCamera("Selection", choosePed[k])
                            PlaySoundFrontend("gender_right", "RDRO_Character_Creator_Sounds", true, 0)
                            pedSelected = choosePed[k]
                            sex = "mp_female"
                        end
                    end
                    if IsControlJustReleased(0, 0xC7B5340A) and pedSelected ~= nil then
                        DoScreenFadeOut(1800)
                        Wait(2000)
                        interpCamera2("Corpo", pedSelected)
                        InterP2 = true
                        SetEntityCoords(pedSelected, -558.56, -3781.16, 237.59)
                        SetEntityHeading(pedSelected, 87.21)
                        inCustomization = true
                        DoScreenFadeIn(3000)
                        vpcreator = true
                        DeletePed = true
                    end
                end
            end

            if inCustomization and not hided then
                SetNuiFocus(true, true)
                SendNUIMessage(
                    {
                        action = "show",
                        gender = sex
                    }
                )
            end
        end
    end
)

RegisterNetEvent("FRP:CHARCREATION:starting")
AddEventHandler(
    "FRP:CHARCREATION:starting",
    function()
        vpcreator = true
        inCustomization = false
        cAPI.EndFade(500)
        NetworkSetEntityInvisibleToNetwork(PlayerPedId(), true)
        SetEntityVisible(PlayerPedId(), false)
        SetEntityCoords(PlayerPedId(), -561.8157, -3780.966, 239.0805)
        DeletePed = false
    end
)

RegisterNUICallback(
    "rotate",
    function(data, cb)
        if (data["key"] == "left") then
            rotation(20)
        else
            rotation(-20)
        end
        cb("ok")
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end
        SetNuiFocus(false, false)
        SendNUIMessage(
            {
                action = "hide"
            }
        )
    end
)

CharacterName = nil
CharacterAge = 18
HeadUsing = nil
HairUsing = nil
TorsoUsing = nil
LegsUsing = nil
EyesUsing = nil
PorteUsing = nil
TeethUsing = nil
MustacheUsing = nil
PedScaleUsing = 1.0
pedWeight = 1


RegisterNUICallback(
    "CheckButtons",
    function(data)
        TriggerEvent('FRP:NOTIFY:Simple', data, 5000)
    end
)

RegisterNUICallback(
    "HeadType",
    function(data)
        interpCamera2("Rosto", pedSelected)      
        if sex == "mp_male" then            
            for k, v in pairs(MaleHeads) do
                if MaleHeads[k].id == tonumber(data.id) then
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, MaleHeads[k].hash, true, true, true) -- FACE
                    HeadUsing = MaleHeads[k].hash
                end
            end
        else
            for k, v in pairs(FemaleHeads) do
                if FemaleHeads[k].id == tonumber(data.id) then
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, FemaleHeads[k].hash, true, true, true) -- FACE
                    HeadUsing = FemaleHeads[k].hash
                end
            end
        end
    end
)

RegisterNUICallback(
    "TomPele",
    function(data)
        interpCamera2("Corpo", pedSelected)   

        if sex == "mp_male" then
            for k, v in pairs(MaleTorsos) do
                if MaleTorsos[k].id == tonumber(data.id) then
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, MaleTorsos[k].hash, true, true, true)
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, MaleLegs[k].hash, true, true, true)
                    TorsoUsing = MaleTorsos[k].hash
                    LegsUsing = MaleLegs[k].hash
                end
            end
        else
            for k, v in pairs(FemaleTorsos) do
                if FemaleTorsos[k].id == tonumber(data.id) then
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, FemaleTorsos[k].hash, true, true, true)
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, FemaleLegs[k].hash, true, true, true)
                    TorsoUsing = FemaleTorsos[k].hash
                    LegsUsing = FemaleLegs[k].hash
                end
            end
        end

    end
)

RegisterNUICallback(
    "Idade",
    function(data)
        CharacterAge = tonumber(data.change)
    end
)

RegisterNUICallback(
    "Olhos",
    function(data)
        interpCamera2("Rosto", pedSelected)
        if sex == "mp_male" then
            for k, v in pairs(MaleEyes) do
                if MaleEyes[k].id == tonumber(data.id) then
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, MaleEyes[k].hash, true, true, true)
                    EyesUsing = MaleEyes[k].hash
                end
            end
        else
            for k, v in pairs(FemaleEyes) do
                if FemaleEyes[k].id == tonumber(data.id) then
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, FemaleEyes[k].hash, true, true, true)
                    EyesUsing = FemaleEyes[k].hash
                end
            end
        end
    end
)

RegisterNUICallback(
    "Porte",
    function(data)
        interpCamera2("Corpo", pedSelected)   
        local offset = 132

        if sex == "mp_female" then
            offset = 114
        end

        local finalIndex = offset + data.id

        PorteUsing = finalIndex

        Citizen.InvokeNative(0xA5BAE410B03E7371, pedSelected, finalIndex, false, true)        
        Citizen.InvokeNative(0xCC8CA3E88256E58F, pedSelected, 0, 1, 1, 1, 0)

    end
)


RegisterNUICallback(
    "Gordura",
    function(data)
        interpCamera2("Corpo", pedSelected)   

        local WAIST_TYPES = {
            -2045421226,    -- smallest
            -1745814259,
            -325933489,
            -1065791927,
            -844699484,
            -1273449080,
            927185840,
            149872391,
            399015098,
            -644349862,
            1745919061,      -- default
            1004225511,
            1278600348,
            502499352,
            -2093198664,
            -1837436619,
            1736416063,
            2040610690,
            -1173634986,
            -867801909,
            1960266524,      -- biggest    
        }

        local waistIndex = data.id

        pedWeight = waistIndex

        Citizen.InvokeNative(0x1902C4CFCC5BE57C,pedSelected, WAIST_TYPES[waistIndex])
        Citizen.InvokeNative(0xCC8CA3E88256E58F,pedSelected, 0, 1, 1, 1, false)
    end
)


RegisterNUICallback(
    "Dentes",
    function(data)
        interpCamera2("Rosto", pedSelected)   
        if sex == "mp_male" then
            for k, v in pairs(MaleTeeth) do
                if MaleTeeth[k].id == tonumber(data.id) then
                    RequestAnimDict("FACE_HUMAN@GEN_MALE@BASE")
                    while not HasAnimDictLoaded("FACE_HUMAN@GEN_MALE@BASE") do
                        Citizen.Wait(100)
                    end
                    TaskPlayAnim(pedSelected, "FACE_HUMAN@GEN_MALE@BASE", "Face_Dentistry_Loop", 1090519040, -4, -1, 17, 0, 0, 0, 0, 0, 0)
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, MaleTeeth[k].hash, true, true, true)
                    TeethUsing = MaleTeeth[k].hash
                end
            end
        else
            for k, v in pairs(FemaleTeeth) do
                if FemaleTeeth[k].id == tonumber(data.id) then
                    RequestAnimDict("FACE_HUMAN@GEN_MALE@BASE")
                    while not HasAnimDictLoaded("FACE_HUMAN@GEN_MALE@BASE") do
                        Citizen.Wait(100)
                    end
                    TaskPlayAnim(pedSelected, "FACE_HUMAN@GEN_MALE@BASE", "Face_Dentistry_Loop", 1090519040, -4, -1, 17, 0, 0, 0, 0, 0, 0)
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, FemaleTeeth[k].hash, true, true, true)
                    TeethUsing = FemaleTeeth[k].hash
                end
            end
        end
    end
)

RegisterNUICallback(
    "Cabelos",
    function(data)
        interpCamera2("Rosto", pedSelected)   
        if data.id == 0 then
            HairUsing = 0
            Citizen.InvokeNative(0xD710A5007C2AC539, pedSelected, 0x864B03AE, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, pedSelected, 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                for k, v in pairs(MaleHairs) do
                    if MaleHairs[k].id == tonumber(data.id) then
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, MaleHairs[k].hash, true, true, true)
                        HairUsing = MaleHairs[k].hash
                    end
                end
            else
                for k, v in pairs(FemaleHairs) do
                    if FemaleHairs[k].id == tonumber(data.id) then
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, FemaleHairs[k].hash, true, true, true)
                        HairUsing = FemaleHairs[k].hash
                    end
                end
            end
        end
    end
)

-- RegisterNUICallback(
--     "Sobrancelha",
--     function(value)
--         interpCamera2("Rosto", pedSelected)
--         if sex == "mp_male" then
--             -- print(N_0xfd1ba1eef7985bb8(pedSelected, 0xD266))
--             N_0x5653ab26c82938cf(pedSelected, 0xD266, value)
--             HairBrownHairUsing = value
--         else
--             --print(value)
--             N_0x5653ab26c82938cf(pedSelected, 0x03F5, value)
--             HairUsing = value
--         end
--     end
-- )

-- RegisterCommand(
--     "deleteped",
--     function()
--         DeleteEntity(pedSelected)
--     end
-- )

RegisterNUICallback(
    "BarbaMenu",
    function(data)
        interpCamera("Rosto", pedSelected)
        if data.id == 0 then
            MustacheUsing = 0
            Citizen.InvokeNative(0xD710A5007C2AC539, pedSelected, 0xF8016BCA, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, pedSelected, 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                for k, v in pairs(MaleMustache) do
                    if MaleMustache[k].id == tonumber(data.id) then
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, pedSelected, MaleMustache[k].hash, true, true, true)
                        MustacheUsing = MaleMustache[k].hash
                    end
                end
            end
        end
    end
)

local index = nil

RegisterNUICallback(
    "FaceFeatured",
    function(data)
        if sex == "mp_male" then
            interpCamera2("Rosto", pedSelected)   
        else
            interpCamera2("Rosto", pedSelected)   
        end
        local ped = pedSelected
        local index = tonumber(data.facefeature)
        local value = tonumber(data.id)
        Citizen.InvokeNative(0x5653AB26C82938CF, ped, index, value)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, false, true, true, true, false)
    end
)

RegisterNUICallback(
    "PedSize",
    function(data)
        if sex == "mp_male" then
            interpCamera2("Rosto", pedSelected)   
        else
            interpCamera2("Rosto", pedSelected)   
        end
        local ped = pedSelected



        local value = tonumber(data.id)
        local isPositive =  value > 185
        local variation = (math.abs(185 - value) * 0.005333)
        if not isPositive then 
          variation = -(variation)
        end

        SetPedScale(ped, 1.0 + variation)

        PedScaleUsing = 1.0 + variation
    end
)


RegisterNUICallback(
    "NomePlayer",
    function(dados)
        CharacterName = dados.change
    end
)

local faceFeatures = {
    0x84D6,
    0x3303,
    0x2FF9,
    0x4AD1,
    0xC04F,
    0xB6CE,
    0x2844,
    0xED30,
    0x6A0B,
    0xABCF,
    0x358D,
    0x8D0A,
    0xEBAE,
    0x1DF6,
    0x3C0F,
    0xC3B2,
    0xE323,
    0x8B2B,
    0x1B6B,
    0xEE44,
    0xD266,
    0xA54E,
    0xDDFB,
    0x6E7F,
    0x3471,
    0x03F5,
    0x34B1,
    0xF156,
    0x561E,
    0xF065,
    0xAA69,
    0x7AC3,
    0x410D,
    0x1A00,
    0x91C1,
    0xC375,
    0xBB4D,
    0xB0B0,
    0x5D16
}

-- RegisterCommand('setmod', function(source,args)
--     local ped = pedSelected
--    for _, index in pairs(faceFeatures) do
--         local value = 1.0
--         print(ped, index, value)

--         Citizen.InvokeNative(0x5653AB26C82938CF, ped, index, value)
--         Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, false, true, true, true, false)
--     end
-- end)

local floatIndex = nil
RegisterNUICallback(
    "CloseCreator",
    function()
        SendNUIMessage(
            {
                action = "hide"
            }
        )
        SetEntityVisible(PlayerPedId(), true)
   
        local ffDados = {}

        for _, value in pairs(faceFeatures) do

            local facemod = Citizen.InvokeNative(0xFD1BA1EEF7985BB8, pedSelected, tonumber(value), Citizen.ResultAsFloat())
    
            if facemod then
                ffDados[value] = facemod
            end
        end

        local pedAppearance = {
            ["heads"] = HeadUsing,
            ["BODIES_UPPER"] = TorsoUsing,
            ["BODIES_LOWER"] = LegsUsing,
            ["hair"] = HairUsing,
            ["eyes"] = EyesUsing,
            ["teeth"] = TeethUsing,
            ["Mustache"] = MustacheUsing,
            ["porte"] = PorteUsing
        }

        local SkinModf = {
            ["model"] = sex,
            ["modSkin"] = json.encode(pedAppearance),
            ["pedSize"] = tonumber(PedScaleUsing),
            ['pedWeight'] = tonumber(pedWeight),
            ["features"] = json.encode(ffDados)
        }

        TriggerServerEvent("FRP:CREATOR:saveCreation", CharacterName, CharacterAge, SkinModf, IsPedMale(pedSelected))
        closeAll()

        SetNuiFocus(false, false)   
        cAPI.StartFade(500)

        Wait(12000)
        cAPI.EndFade(500)
    end
)

function closeAll()
    DestroyAllCams(true)
    SetNuiFocus(false, false)
    DisplayHud(true)

    vpcreator = false
    inCustomization = false

    SetEntityVisible(PlayerPedId(), true)
    SetEntityInvincible(PlayerPedId(), false)
    NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)

    choosePed = {}
    local ped = pedSelected

    --  SetEntityVisible(ped, true)
    --  NetworkSetEntityInvisibleToNetwork(ped, false)
end

function rotation(dir)
    local playerPed = pedSelected
    if playerPed ~= nil then
        local pedRot = GetEntityHeading(playerPed) + dir
        SetEntityHeading(playerPed, pedRot % 360)
    end
end

function interpCamera(cameraName, entity)
    SetCamActiveWithInterp(fixedCam, tempCam, 1200, true, true)
    for k,v in pairs(cameraUsing) do
        if cameraUsing[k].name == cameraName then
            tempCam = CreateCam("DEFAULT_SCRIPTED_CAMERA")
            AttachCamToEntity(tempCam, entity, cameraUsing[k].x, cameraUsing[k].y, cameraUsing[k].z)
            --AttachCamToEntity(tempCam, entity, cameraUsing[k].x, cameraUsing[k].y, cameraUsing[k].z)
            SetCamActive(tempCam, true)
            SetCamRot(tempCam, -4.0, 0, 270.0)
            if InterP then
                SetCamActiveWithInterp(tempCam, fixedCam, 1200, true, true)
                InterP = false
            end
        end
    end
end

function interpCamera2(cameraName, entity)
    DestroyAllCams(true)
    SetCamActiveWithInterp(tempCam, tempCam2, 1200, true, true)
    for k,v in pairs(cameraUsing) do
        if cameraUsing[k].name == cameraName then
            tempCam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA")
            AttachCamToEntity(tempCam2, entity, cameraUsing[k].x, cameraUsing[k].y, cameraUsing[k].z)
            --AttachCamToEntity(tempCam, entity, cameraUsing[k].x, cameraUsing[k].y, cameraUsing[k].z)
            SetCamActive(tempCam2, true)
            SetCamRot(tempCam2, 0.0, 0, 270.0)
            if InterP2 then
                SetCamActiveWithInterp(tempCam2, tempCam, 1200, true, true)  
                InterP2 = false
            end     
        end
    end
end

function createCamera()
    groundCam = CreateCam("DEFAULT_SCRIPTED_CAMERA")    
    SetCamCoord(groundCam, -555.925,-3778.709,238.597)
    SetCamRot(groundCam, -20.0, 0.0, 83)
    SetCamActive(groundCam, true)    
    RenderScriptCams(true, false, 1, true, true)
    --Wait(3000)
    -- last camera, create interpolate
    fixedCam = CreateCam("DEFAULT_SCRIPTED_CAMERA")
    SetCamCoord(fixedCam, -561.206,-3776.224,239.597)
    SetCamRot(fixedCam, -20.0, 0, 270.0)
    SetCamActive(fixedCam, true)
    SetCamActiveWithInterp(fixedCam, groundCam, 3900, true, true)
    Wait(3900)
    DestroyCam(groundCam)
    InterP = true
end

DeletePed = false

function createPeds()
    for k, v in pairs(peds) do
        if choosePed[k] == nil then
            local waiting = 0
            local hash = GetHashKey(peds[k].genrer)
            RequestModel(hash)
            while not HasModelLoaded(hash) do
                Citizen.Wait(10)
            end
            choosePed[k] = CreatePed(hash, peds[k].x, peds[k].y, peds[k].z - 0.5, peds[k].h, false, 0)
            Citizen.InvokeNative(0x283978A15512B2FE, choosePed[k], true)
            Citizen.InvokeNative(0x58A850EAEE20FAA3, choosePed[k])
            NetworkSetEntityInvisibleToNetwork(choosePed[k], true)
            SetVehicleHasBeenOwnedByPlayer(choosePed[k], true)
            -- SetModelAsNoLongerNeeded(hash)
            if peds[k].genrer == "mp_female" then
                SetPedOutfitPreset(choosePed[k], 17)

                Citizen.InvokeNative(0xD710A5007C2AC539, choosePed[k], 0x9925C067, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, choosePed[k], 0, 1, 1, 1, 0)

            else
                SetPedOutfitPreset(choosePed[k], 43)
            end
        end
    end
end





AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if GetCurrentResourceName() == resourceName then
            for index, _ in pairs(choosePed) do
                DeleteEntity(choosePed[index])
            end
        end
    end
)
