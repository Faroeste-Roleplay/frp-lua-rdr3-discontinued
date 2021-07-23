local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Tunnel.getInterface("API")
cAPI = Proxy.getInterface("API")

adding = true
inCustomization = false
cam = nil
hided = false
spawnedCamera = nil
choosePed = {}
pedSelected = PlayerPedId()
sex = nil
positionBack = nil

InterP = false
CamActive = false
zoom = 1.0
offset = 0.5
fixedCam = nil
tempCam2 = nil
tempCam = nil
groundCam = nil


cameraUsing = {
    {
        name = "Pernas",
        x = -1.0,
        y = 0.0,
        z = 0.5
    },
    {
        name = "Rosto",
        x = -0.5,
        y = 0.0,
        z = 0.6
    },
    {
        name = "Corpo",
        x = -1.3,
        y = 0.0,
        z = 0.4
    }
}

Citizen.CreateThread(
    function()
        while adding do
            Citizen.Wait(0)
            --print("Dzieje sie")
            for i, v in ipairs(MaleComp) do
                if v.category == "hats" then
                    table.insert(hats_m, v.Hash)
                elseif v.category == "spurs" then
                    table.insert(spurs_m, v.Hash)
                elseif v.category == "chaps" then
                    table.insert(chaps_m, v.Hash)
                elseif v.category == "cloaks" then
                    table.insert(cloaks_m, v.Hash)
                elseif v.category == "spats" then
                    table.insert(spats_m, v.Hash)   
                end
            end
            adding = false
        end
    end
)

Citizen.CreateThread(
    function()
        while adding2 do
            Citizen.Wait(0)
            --print("Dzieje sie 2")
            for i, v in ipairs(FemaleComp) do
                if v.category == "hats" then
                    table.insert(hats_f, v.hash)
                elseif v.category == "spurs" then
                    table.insert(spurs_f, v.hash)
                elseif v.category == "chaps" then
                    table.insert(chaps_f, v.hash)
                elseif v.category == "cloaks" then
                    table.insert(cloaks_f, v.hash)
                elseif v.category == "spats" then
                    table.insert(spats_f, v.hash)
                elseif v.category == "eyewear" then
                    table.insert(eyewear_f, v.hash)
                elseif v.category == "access" then
                    table.insert(access_f, v.hash)
                end           
            end
            adding2 = false
        end
    end
)

RegisterCommand(
    "openClothingShopMenu",
    function(source, args)
        inCustomization = true
        hided = false
        CamActive = false
        cAPI.InFade(500)
        Citizen.InvokeNative(0xF1CA12B18AEF5298, PlayerPedId(), true)
      --||  SetEveryoneAsInvisible()
    end
)

RegisterNetEvent("FRP:STORECLOTHES:OpenClothingMenu")
AddEventHandler(
    "FRP:STORECLOTHES:OpenClothingMenu",
    function()
        if not cAPI.GetWanted() then
            inCustomization = true
            hided = false
            CamActive = false
            cAPI.InFade(500)
            Citizen.InvokeNative(0xF1CA12B18AEF5298, PlayerPedId(), true)
        -- SetEveryoneAsInvisible()        
        else
            TriggerEvent('FRP:NOTIFY:Simple', 'Você ainda está como procurado, não pode trocar de roupa. ', 10000)
        end
    end
)

function rotation(dir)
    local pedRot = GetEntityHeading(PlayerPedId()) + dir
    SetEntityHeading(PlayerPedId(), pedRot % 360)
end

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

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if inCustomization and not hided then
                SetNuiFocus(true, true)
                local hashm = GetEntityModel(PlayerPedId())

                local female = -1481695040
                local male = -171876066

                if hashm == female then
                    sex = "mp_female"
                elseif hashm == male then
                    sex = "mp_male"
                else
                    sex = "other"
                end





                if not CamActive then
                    createCamera()
                    CamActive = true
                end
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

-- function SetEveryoneAsInvisible()
--    NetworkSetEntityInvisibleToNetwork(PlayerPedId(), true)
--   while inCustomization do
--   	Citizen.Wait(0)
-- 	    for _, pid in pairs(GetActivePlayers()) do
-- 	    	print('1 '.. pid)
-- 	       SetEntityVisible(GetPlayerPed(pid), false)
-- 	    end
--    end

--  	for _, pid in pairs(GetActivePlayers()) do
--  		print('2 '.. pid)
--       SetEntityVisible(GetPlayerPed(pid), true)
--    	end
--    	NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
-- end

function createCamera()
    SetEntityCoords(PlayerPedId(), 2555.352,-1160.896,53.002)
    local coords = GetEntityCoords(PlayerPedId())
    groundCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 2554.450, -1161.843, 53.782)
  	SetEntityHeading(PlayerPedId(), 286.07)


  --	SetEntityVisible(PlayerPedId(), false)
    SetCamCoord(groundCam, 2554.450, -1161.843, 53.782)
 --  SetCamFov(groundCam, 100)
    SetCamRot(groundCam, -10.0, 0.0, 152.09)
    SetCamActive(groundCam, true)
    RenderScriptCams(true, false, 1, true, true)
    --Wait(3000)
    -- last camera, create interpolate
    fixedCam = CreateCam("DEFAULT_SCRIPTED_CAMERA")
    SetCamCoord(fixedCam, 2557.021,-1160.685,54.202)
    SetCamRot(fixedCam, -15.0, 0, 115.09)
    Wait(3000)
    cAPI.OutFade(500)
    TriggerEvent("FRP:NOTIFY:Simple", "Utilize as teclas A e D para rotacionar o personagem, e as setas do teclado para selecionar as opções.", 10000)
    --SetCamFov(fixedCam, 100)
    SetCamActive(fixedCam, true)
    SetCamActiveWithInterp(fixedCam, groundCam, 3900, true, true)
    Wait(3900)
    DestroyCam(groundCam)
    -- InterP = true
end

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
            -- NetworkSetEntityInvisibleToNetwork(choosePed[k], true)
            SetVehicleHasBeenOwnedByPlayer(choosePed[k], true)
        -- SetModelAsNoLongerNeeded(hash)
        end
    end
end

HatUsing = nil
ShirtsUsing = nil
VestsUsing = nil
PantsUsing = nil
BootsUsing = nil
MasksUsing = nil
CoatsUsing = nil
SkirtsUsing = nil
LegsUsing = nil
GlovesUsing = nil
NeckwearUsing = nil
GunbeltsUsing = nil
cloaksUsing = nil
coats2Using = nil

spursUsing = nil
chapsUsing = nil
spatsUsing = nil
eyewearUsing = nil
accessUsing = nil
necktiesUsing = nil
braceletsUsing = nil
suspendersUsing = nil
gauntletsUsing = nil
beltsUsing = nil
ponchosUsing = nil
offhandUsing = nil
beltbuckleUsing = nil

RegisterNUICallback(
    "Chapeu",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            HatUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x9925C067, 0) -- HAT REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. hats_m[num])
                setcloth(hash)
                HatUsing = ("0x" .. hats_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. hats_f[num])
                setcloth(hash)
                HatUsing = ("0x" .. hats_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Camisa",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            ShirtsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x2026C46D, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. shirts_m[num])
                setcloth(hash)
                ShirtsUsing = ("0x" .. shirts_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. shirts_f[num])
                setcloth(hash)
                ShirtsUsing = ("0x" .. shirts_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Colete",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            VestsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x485EE834, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. vests_m[num])
                setcloth(hash)
                VestsUsing = ("0x" .. vests_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. vests_f[num])
                setcloth(hash)
                VestsUsing = ("0x" .. vests_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Calca",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            PantsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x1D4C528A, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. pants_m[num])
                setcloth(hash)
                PantsUsing = ("0x" .. pants_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. pants_f[num])
                setcloth(hash)
                PantsUsing = ("0x" .. pants_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Sapato",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            BootsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x777EC6EF, 0) -- Set target category
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- REMOVE COMPONENT
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. boots_m[num])
                setcloth(hash)
                BootsUsing = ("0x" .. boots_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. boots_f[num])
                setcloth(hash)
                BootsUsing = ("0x" .. boots_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Mascara",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            MasksUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7505EF42, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. masks_m[num])
                setcloth(hash)
                MasksUsing = ("0x" .. masks_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. masks_f[num])
                setcloth(hash)
                MasksUsing = ("0x" .. masks_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Casaco",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            CoatsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x662AC34, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xE06D30CE, 0) -- cloaks REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. coats_m[num])
                setcloth(hash)
                CoatsUsing = ("0x" .. coats_m[num])
                coats2Using = 0
            else
                local num = tonumber(data.id)
                hash = ("0x" .. coats_f[num])
                setcloth(hash)
                CoatsUsing = ("0x" .. coats_f[num])
                coats2Using = 0
            end
        end
    end
)

RegisterNUICallback(
    "Saia",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            SkirtsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xA0E3AB7F, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                -- local num = tonumber(data.id)
                -- hash = ("0x" .. mustache_m[num])
                -- setcloth(hash)
            else
                local num = tonumber(data.id)
                hash = ("0x" .. skirts_f[num])
                setcloth(hash)
                SkirtsUsing = ("0x" .. skirts_f[num])
            end
        end
    end
)

-- RegisterNUICallback(
--     'Legs',
--     function(data)
--         if tonumber(data.id) == 0 then
--             num = 0
--             LegsUsing = num
--         else
--             if sex == 'mp_male' then
--                 local num = tonumber(data.id)
--                 hash = ("0x" .. legs_m[num])
--                 setcloth(hash)
--                 LegsUsing = ("0x" .. legs_m[num])
--             else
--                 local num = tonumber(data.id)
--                 hash = ("0x" .. legs_f[num])
--                 setcloth(hash)
--                 LegsUsing = ("0x" .. legs_f[num])
--             end
--         end
--     end
-- )

RegisterNUICallback(
    "Luva",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            GlovesUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xEABE0032, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. gloves_m[num])
                setcloth(hash)
                GlovesUsing = ("0x" .. gloves_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. gloves_f[num])
                setcloth(hash)
                GlovesUsing = ("0x" .. gloves_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Bandana",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            NeckwearUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x5FC29285, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. neckwear_m[num])
                setcloth(hash)
                NeckwearUsing = ("0x" .. neckwear_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. neckwear_f[num])
                setcloth(hash)
                NeckwearUsing = ("0x" .. neckwear_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Coldre",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            GunbeltsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x9B2C8B89, 0) -- Set target category, here the hash is for hats
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. gunbelts_m[num])
                setcloth(hash)
                GunbeltsUsing = ("0x" .. gunbelts_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. gunbelts_f[num])
                setcloth(hash)
                GunbeltsUsing = ("0x" .. gunbelts_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Beltbuckle",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            beltbuckleUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xFAE9107F, 0) -- beltbuckle REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. beltbuckle_m[num])
                setcloth(hash)
                beltbuckleUsing = ("0x" .. beltbuckle_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. beltbuckle_f[num])
                setcloth(hash)
                beltbuckleUsing = ("0x" .. beltbuckle_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Offhand",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            offhandUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xB6B6122D, 0) -- offhand REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. offhand_m[num])
                setcloth(hash)
                offhandUsing = ("0x" .. offhand_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. offhand_f[num])
                setcloth(hash)
                offhandUsing = ("0x" .. offhand_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Ponchos",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            ponchosUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xAF14310B, 0) -- ponchos REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. ponchos_m[num])
                setcloth(hash)
                ponchosUsing = ("0x" .. ponchos_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. ponchos_f[num])
                setcloth(hash)
                ponchosUsing = ("0x" .. ponchos_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Belts",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            beltsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xA6D134C6, 0) -- Belts REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. belts_m[num])
                setcloth(hash)
                beltsUsing = ("0x" .. belts_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. belts_f[num])
                setcloth(hash)
                beltsUsing = ("0x" .. belts_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Gauntlets",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            gauntletsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x91CE9B20, 0) -- Gauntlets REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. gauntlets_m[num])
                setcloth(hash)
                gauntletsUsing = ("0x" .. gauntlets_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. gauntlets_f[num])
                setcloth(hash)
                gauntletsUsing = ("0x" .. gauntlets_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Suspenders",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            suspendersUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x877A2CF7, 0) -- Suspenders REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. suspenders_m[num])
                setcloth(hash)
                suspendersUsing = ("0x" .. suspenders_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. suspenders_f[num])
                setcloth(hash)
                suspendersUsing = ("0x" .. suspenders_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Bracelets",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            braceletsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7BC10759, 0) -- Bracelets REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. bracelets_m[num])
                setcloth(hash)
                braceletsUsing = ("0x" .. bracelets_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. bracelets_f[num])
                setcloth(hash)
                braceletsUsing = ("0x" .. bracelets_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Neckties",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            necktiesUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x7A96FACA, 0) -- Neckties REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. neckties_m[num])
                setcloth(hash)
                necktiesUsing = ("0x" .. neckties_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. neckties_f[num])
                setcloth(hash)
                necktiesUsing = ("0x" .. neckties_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Access",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            accessUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x79D7DF96, 0) -- Access REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. access_m[num])
                setcloth(hash)
                accessUsing = ("0x" .. access_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. access_f[num])
                setcloth(hash)
                accessUsing = ("0x" .. access_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Cloaks",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            cloaksUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3C1A74CD, 0) -- cloaks REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. cloaks_m[num])
                setcloth(hash)
                cloaksUsing = ("0x" .. cloaks_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. cloaks_f[num])
                setcloth(hash)
                cloaksUsing = ("0x" .. cloaks_f[num])             
            end
        end
    end
)

RegisterNUICallback(
    "Jaqueta",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            coats2Using = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xE06D30CE, 0) -- cloaks REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x662AC34, 0) -- cloaks REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. coats2_m[num])
                setcloth(hash)
                coats2Using = ("0x" .. coats2_m[num])
                CoatsUsing = 0
            else
                local num = tonumber(data.id)
                hash = ("0x" .. coats2_f[num])
                setcloth(hash)
                coats2Using = ("0x" .. coats2_f[num])
                CoatsUsing = 0
            end
        end
    end
)

RegisterNUICallback(
    "Eyewear",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            eyewearUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x5E47CA6, 0) -- Eyewear REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. eyewear_m[num])
                setcloth(hash)
                eyewearUsing = ("0x" .. eyewear_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. eyewear_f[num])
                setcloth(hash)
                eyewearUsing = ("0x" .. eyewear_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Chaps",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            chapsUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3107499B, 0) -- Chaps REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. chaps_m[num])
                setcloth(hash)
                chapsUsing = ("0x" .. chaps_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. chaps_f[num])
                setcloth(hash)
                chapsUsing = ("0x" .. chaps_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Spurs",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            spursUsing = num
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x18729F39, 0) -- SPURS REMOVE
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
        else
            if sex == "mp_male" then
                local num = tonumber(data.id)
                hash = ("0x" .. spurs_m[num])
                setcloth(hash)
                spursUsing = ("0x" .. spurs_m[num])
            else
                local num = tonumber(data.id)
                hash = ("0x" .. spurs_f[num])
                setcloth(hash)
                spursUsing = ("0x" .. spurs_f[num])
            end
        end
    end
)

RegisterNUICallback(
    "Outfit",
    function(data)
        if tonumber(data.id) == 0 then
            num = 0
            OutfitUsing = num
        else
            local num = tonumber(data.id)
            SetPedOutfitPreset(PlayerPedId(), num)  
            OutfitUsing = num  
        end
    end
)


local Badge = false
RegisterCommand(
    "badge",
    function(source, args, rawCommand)
        if cAPI.hasGroup('trooper') then
            if not Badge then
                setcloth2(0x1FC12C9C)
                print(GetHashKey(0x3F7F3587))
            --  SetPedAsCop(PlayerPedId(),true)
                Citizen.InvokeNative(0xBB03C38DD3FB7FFD, PlayerPedId(), true)
                Badge = true
            else
                Citizen.InvokeNative(0xBB03C38DD3FB7FFD, PlayerPedId(), false)

                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3F7F3587, 0) -- SPURS REMOVE
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
                Badge = false
            end
        end
        if cAPI.hasGroup('sheriff') then
            if not Badge then
                setcloth2(0xDB4C451D)
                print(GetHashKey(0x3F7F3587))
            --  SetPedAsCop(PlayerPedId(),true)
                Citizen.InvokeNative(0xBB03C38DD3FB7FFD, PlayerPedId(), true)
                Badge = true
            else
                Citizen.InvokeNative(0xBB03C38DD3FB7FFD, PlayerPedId(), false)

                Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3F7F3587, 0) -- SPURS REMOVE
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0) -- Actually remove the component
                Badge = false
            end
        end
    end
)

function setcloth2(hash)
    local model2 = hash
    if not HasModelLoaded(model2) then
        Citizen.InvokeNative(0xFA28FE3A6246FC30, model2)
    end

    NativeSetPedComponentEnabled(PlayerPedId(), tonumber(hash), true, true)
    --Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true, true, true)
end


function setcloth(hash)
    local model2 = GetHashKey(tonumber(hash))
    if not HasModelLoaded(model2) then
        Citizen.InvokeNative(0xFA28FE3A6246FC30, model2)
    end

    NativeSetPedComponentEnabled(PlayerPedId(), tonumber(hash), true, true)
    --Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), true, true, true)
end

RegisterNUICallback(
    "Confirm",
    function()
        local dados = {
            ['hat'] = HatUsing,
            ['shirts'] = ShirtsUsing,
            ['vests'] = VestsUsing,
            ['pants'] = PantsUsing,
            ['boots'] = BootsUsing,
            ['masks'] = MasksUsing,
            ['coats'] = CoatsUsing,
            ['skirts'] = SkirtsUsing,
            ['legs'] = LegsUsing,
            ['gloves'] = GlovesUsing,
            ['neckwear'] = NeckwearUsing,
            ['gunbelts'] = GunbeltsUsing,
            ['spurs'] = spursUsing,
            ['chaps'] = chapsUsing,
            ['spats'] = spatsUsing,
            ['eyewear'] = eyewearUsing,
            ['access'] = accessUsing,
            ['neckties'] = necktiesUsing,
            ['bracelets'] = braceletsUsing,
            ['suspenders'] = suspendersUsing,
            ['gauntlets'] = gauntletsUsing,
            ['belts'] = beltsUsing,
            ['ponchos'] = ponchosUsing,
            ['offhand'] = offhandUsing,
            ['beltbuckle'] = beltbuckleUsing,
            ['cloaks'] = cloaksUsing,
            ['coats2'] = coats2Using,
            ['beltbuckle'] = beltbuckleUsing,
            ['Outfit'] = OutfitUsing
        }
    
        -- local dados = {
        --     HatUsing,
        --     ShirtsUsing,
        --     VestsUsing,
        --     PantsUsing,
        --     BootsUsing,
        --     MasksUsing,
        --     CoatsUsing,
        --     SkirtsUsing,
        --     LegsUsing,
        --     GlovesUsing,
        --     NeckwearUsing,
        --     GunbeltsUsing,
        --     spursUsing,
        --     chapsUsing,
        --     spatsUsing,
        --     eyewearUsing,
        --     accessUsing,
        --     necktiesUsing,
        --     braceletsUsing,
        --     suspendersUsing,
        --     gauntletsUsing,
        --     beltsUsing,
        --     ponchosUsing,
        --     offhandUsing,
        --     cloaksUsing,
        --     coats2Using,
        --     beltbuckleUsing
        -- }

       -- print(json.encode(dados))

        TriggerServerEvent("FRP:CLOTHES:SavePlayerClothing", dados, true)
        DestroyClothingMenu()
        cAPI.InFade(500)
        if positionBack ~= nil then
            SetEntityCoords(PlayerPedId(), positionBack)
        end
        Wait(4000)
        Citizen.InvokeNative(0xF1CA12B18AEF5298, PlayerPedId(), false)
       	NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
       	 --SetEntityVisible(PlayerPedId(), true)
        cAPI.OutFade(500)
    end
)



function DestroyClothingMenu()
    DestroyAllCams(true)
    SetNuiFocus(false, false)
    DisplayHud(true)

    inCustomization = false
    hided = false

    SendNUIMessage(
        {
            action = "hide"
        }
    )
end

Citizen.CreateThread(
    function()
        local shops = {
            vector3(-762.85, -1291.97, 43.84), -- Blackwater
            vector3(2549.83, -1160.05, 53.73), -- SAINT DENIS
            vector3(-322.25, 803.97, 116.95)
        }

        while true do
            Citizen.Wait(0)
            local pPosition = GetEntityCoords(PlayerPedId())

            for _, shopPosition in pairs(shops) do
                if #(pPosition - shopPosition) <= 1.5 then
                    positionBack = shopPosition
                    DrawTxt("Pressione ALT para abrir a loja de roupas.", 0.85, 0.95, 0.35, 0.35, true, 255, 255, 255, 200, true, 10000)
                    if IsControlJustReleased(0, 0xE8342FF2) then -- LEFT ALT
                        print('presses')
                        TriggerEvent("FRP:STORECLOTHES:OpenClothingMenu")
                    end
                end
            end
        end
    end
)



function NativeSetPedComponentEnabled(ped, componentHash, immediately, isMp)
    local categoryHash = NativeGetPedComponentCategory(not IsPedMale(ped), componentHash)
    -- print(componentHash, categoryHash, NativeGetMetapedType(ped))

    NativeFixMeshIssues(ped, categoryHash)

    Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, componentHash, immediately, isMp, true)
end

function NativeUpdatePedVariation(ped)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, false, true, true, true, false)
end

function NativeFixMeshIssues(ped, categoryHash)
    Citizen.InvokeNative(0x59BD177A1A48600A, ped, categoryHash)
end

function NativeIsPedComponentEquipped(ped, componentHash)
    return Citizen.InvokeNative(0xFB4891BD7578CDC1, ped, componentHash)
end

function NativeGetPedComponentCategory(isFemale, componentHash)
    return Citizen.InvokeNative(0x5FF9A878C3D115B8, componentHash, isFemale, true)
end

function NativeGetMetapedType(ped)
    return Citizen.InvokeNative(0xEC9A1261BF0CE510, ped)
end

function NativeHasPedComponentLoaded(ped)
    return Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, ped)
end


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
