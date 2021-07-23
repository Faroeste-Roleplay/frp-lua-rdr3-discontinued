local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local prompt_buy_dollar
local prompt_buy_gold
local prompt_camera
local prompt_hide

local prompt_group

local houseCam

local show_house_prompts = false
local show_house_prompts_name
local show_house_prompts_id
local show_house_prompts_blocked = false

local houses = {
    -- ["house:1"] = {"Mansão Braithwaite", 20.0, 1.0, vec3(1011.094, -1772.385, 47.592), 34.0},
    ["house:1"] = {"Chalé Renegado"     , 200.0, 80.0, vec3(1370.606 , -874.264 , 70.132 ), 25.0},
    ["house:2"] = {"Recanto Dormente"   , 200.0, 80.0, vec3(1135.113 , -979.852 , 69.398 ), 25.0},
    ["house:3"] = {"Renascença Espaçosa", 200.0, 80.0, vec3(-1680.596, -338.923 , 174.025), 20.0},
    ["house:4"] = {"Refúgio Ensolarado" , 200.0, 80.0, vec3(-1412.024, -2672.382, 42.239 ), 15.0},
    ["house:5"] = {"Posto Manzanita"    , 200.0, 80.0, vec3(-1978.603, -1667.799, 118.181), 12.5},
    ["house:6"] = {"A Vista da Baía"    , 200.0, 80.0, vec3(-690.097 , 1044.061 , 135.004), 18.0},
    ["house:7"] = {"Aconchego Rochoso"  , 200.0, 80.0, vec3(900.425  , 261.278  , 116.005), 20.0}
}

local myhouseblips = {}

Citizen.CreateThread(
    function()
        local places = {
            vec3(-810.601, -1277.494, 43.638)
        }

        while true do
            Citizen.Wait(1000)

            SetWindowsInvincible()

            if houseCam == nil and cAPI.IsPlayerInitialized() then
                local ped = PlayerPedId()
                local pCoords = GetEntityCoords(ped)

                nearAValidPlace = false

                for _, v in pairs(places) do
                    local dist = #(pCoords - v)
                    if dist <= 2.0 then
                        nearAValidPlace = true
                        break
                    end
                end

                show_house_prompts = false
                show_house_prompts_name = ""
                show_house_prompts_id = nil

                for houseId, v in pairs(houses) do
                    local houseName = v[1]
                    local housePosition = v[4]

                    if cAPI.hasGroup(houseId) then
                        if not myhouseblips[houseId] then
                            local blip = N_0x554d9d53f696d002(1664425300, housePosition)
                            SetBlipSprite(blip, -2024635066, 1)
                            SetBlipScale(blip, 0.1)
                            -- Citizen.InvokeNative(0x9CB1A1623062F402, blip, houseName)
                            Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Minha Casa")

                            myhouseblips[houseId] = blip
                        end
                    else
                        if myhouseblips[houseId] then
                            RemoveBlip(myhouseblips[houseId])
                            myhouseblips[houseId] = nil
                        end
                    end
                end

                local playerInterior = GetInteriorAtCoords(pCoords)

                if playerInterior == 0 then
                    show_house_prompts_blocked = false
                end

                if show_house_prompts_blocked == false then
                    for houseId, v in pairs(houses) do
                        local houseName = v[1]
                        local housePriceDollar = v[2]
                        local housePriceGold = v[3]
                        local housePosition = v[4]

                        local interiorAtHouse = GetInteriorAtCoords(housePosition)

                        if playerInterior == interiorAtHouse and not cAPI.hasGroup(houseId) then
                            show_house_prompts = true
                            show_house_prompts_name = houseName
                            show_house_prompts_id = houseId

                            PromptSetText(prompt_buy_dollar, CreateVarString(10, "LITERAL_STRING", "$" .. housePriceDollar))
                            PromptSetEnabled(prompt_buy_dollar, true)
                            PromptSetText(prompt_buy_gold, CreateVarString(10, "LITERAL_STRING", "~t4~G" .. housePriceGold))
                            PromptSetEnabled(prompt_buy_gold, true)

                            PromptSetText(prompt_camera, CreateVarString(10, "LITERAL_STRING", "Inspecionar Casa"))

                            break
                        end
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        initiatePrompt()

        while true do
            Citizen.Wait(0)

            if show_house_prompts and show_house_prompts_blocked == false then
                PromptSetActiveGroupThisFrame(prompt_group, CreateVarString(10, "LITERAL_STRING", show_house_prompts_name))

                if PromptHasHoldModeCompleted(prompt_buy_dollar) then
                    PromptSetEnabled(prompt_buy_dollar, false)
                    Citizen.CreateThread(
                        function()
                            Citizen.Wait(1000)
                            PromptSetEnabled(prompt_buy_dollar, true)
                        end
                    )

                    TriggerServerEvent("FRP:HOUSING:TryToBuyHouse", show_house_prompts_id, false)
                end

                if PromptHasHoldModeCompleted(prompt_buy_gold) then
                    PromptSetEnabled(prompt_buy_gold, false)
                    Citizen.CreateThread(
                        function()
                            Citizen.Wait(1000)
                            PromptSetEnabled(prompt_buy_gold, true)
                        end
                    )

                    TriggerServerEvent("FRP:HOUSING:TryToBuyHouse", show_house_prompts_id, true)
                end

                if PromptIsJustPressed(prompt_camera) then
                    if houseCam ~= nil then
                        PromptSetText(prompt_camera, CreateVarString(10, "LITERAL_STRING", "Inspecionar Casa"))

                        PromptSetVisible(prompt_hide, true)

                        destroyHouseCam()
                    else
                        PromptSetText(prompt_camera, CreateVarString(10, "LITERAL_STRING", "Parar de Inspecionar"))

                        PromptSetVisible(prompt_hide, false)

                        local housePosition = houses[show_house_prompts_id][4]
                        local houseCameraRadius = houses[show_house_prompts_id][5]

                        initiateCameraAtCenter(GetEntityCoords(PlayerPedId()), housePosition, houseCameraRadius)
                    end
                end

                if PromptIsJustPressed(prompt_hide) then
                    show_house_prompts_blocked = true
                end
            end
        end
    end
)

function SetWindowsInvincible()
    local windows = {
        -- HOUSE:1
        {1457176412, vec3(1380.36, -875.92, 70.01)},
        {449377254, vec3(1374.91, -878.91, 70.0)},
        {449377254, vec3(1371.97, -869.12, 70.0)},
        {1757176412, vec3(1375.39, -870.92, 70.15)},
        -- HOUSE:2
        {-1484366741, vec3(-5206.49, -3493.25, -21.63)},
        {-1484366741, vec3(-5207.82, -3488.29, -21.63)},
        {1757176412, vec3(1365.99, -874.96, 70.09)},
        -- HOUSE:3
        {958665900, vec3(1133.95, -983.34, 69.41)}
    }

    for _, v in pairs(windows) do
        local windowModel = v[1]
        local windowVec3 = v[2]

        -- if #(pedVec3 - windowVec3) <= 100 then
        local window = GetClosestObjectOfType(windowVec3, 1.0, windowModel, false, 0, 0)
        if window ~= 0 then
            SetEntityInvincible(window, true)
            SetEntityHealth(window, 100)
        end
        -- end
    end
end

function initiatePrompt()
    prompt_group = GetRandomIntInRange(0, 0xffffff)

    prompt_camera = PromptRegisterBegin()
    PromptSetControlAction(prompt_camera, 0xDFF812F9) -- E
    PromptSetText(prompt_camera, CreateVarString(10, "LITERAL_STRING", "Camera"))
    PromptSetEnabled(prompt_camera, 1)
    PromptSetVisible(prompt_camera, 1)
    PromptSetStandardMode(prompt_camera, 1)
    PromptSetGroup(prompt_camera, prompt_group)
    PromptRegisterEnd(prompt_camera)

    prompt_buy_dollar = PromptRegisterBegin()
    PromptSetControlAction(prompt_buy_dollar, 0x07CE1E61) -- LMB
    PromptSetText(prompt_buy_dollar, CreateVarString(10, "LITERAL_STRING", "$"))
    PromptSetEnabled(prompt_buy_dollar, 1)
    PromptSetVisible(prompt_buy_dollar, 1)
    PromptSetHoldMode(prompt_buy_dollar, 1)
    PromptSetGroup(prompt_buy_dollar, prompt_group)
    PromptRegisterEnd(prompt_buy_dollar)

    prompt_buy_gold = PromptRegisterBegin()
    PromptSetControlAction(prompt_buy_gold, 0xF84FA74F) -- RMB
    PromptSetText(prompt_buy_gold, CreateVarString(10, "LITERAL_STRING", "~t4~G"))
    PromptSetEnabled(prompt_buy_gold, 1)
    PromptSetVisible(prompt_buy_gold, 1)
    PromptSetHoldMode(prompt_buy_gold, 1)
    PromptSetGroup(prompt_buy_gold, prompt_group)
    PromptRegisterEnd(prompt_buy_gold)

    prompt_hide = PromptRegisterBegin()
    PromptSetControlAction(prompt_hide, 0x7F8D09B8) --
    PromptSetText(prompt_hide, CreateVarString(10, "LITERAL_STRING", "Esconder"))
    PromptSetEnabled(prompt_hide, 1)
    PromptSetVisible(prompt_hide, 1)
    PromptSetStandardMode(prompt_hide, 1)
    PromptSetGroup(prompt_hide, prompt_group)
    PromptRegisterEnd(prompt_hide)
end

function initiateCameraAtCenter(coordsFrom, center, r)
    SetCamActive(houseCam, false)
    DestroyCam(houseCam, true)
    houseCam = nil

    -- houseCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",coordsFrom, 300.00, 0.00, 0.00, 60.0, false, 2) -- CAMERA COORDS
    -- PointCamAtCoord(houseCam, center)
    -- SetCamActive(houseCam, true)

    local minHeightAboveGround = 3.5

    local Cx = center.x
    local Cy = center.y
    local z = center.z + minHeightAboveGround

    X_deg0 = Cx + (r * math.cos(0))
    Y_deg0 = Cy + (r * math.sin(0))

    -- local initialCam = houseCam

    houseCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", vec3(X_deg0, Y_deg0, z), 300.00, 0.00, 0.00, 60.0, false, 2) -- CAMERA COORDS
    PointCamAtCoord(houseCam, center)
    -- SetCamActiveWithInterp(houseCam, initialCam, 60000, true, true)
    SetCamActive(houseCam, true)

    RenderScriptCams(true, true, 1, true, true)
    -- RenderScriptCams(true, true, 500, true, true)

    SetFocusPosAndVel(center, 0.0, 0.0, 0.0)

    Citizen.CreateThread(
        function()
            local points = {}

            for i = 0, 360, 0.50 do
                i = math.rad(i)
                local X_deg0 = Cx + (r * math.cos(i))
                local Y_deg0 = Cy + (r * math.sin(i))

                local camVec = vec3(X_deg0, Y_deg0, z)

                local _, groundZ, _ = GetGroundZAndNormalFor_3dCoord(camVec.x, camVec.y, camVec.z)

                if _ and math.abs(z - groundZ) < minHeightAboveGround then
                    camVec = vec3(camVec.xy, groundZ + minHeightAboveGround)
                end

                table.insert(points, camVec)
            end

            local i = 1

            while houseCam ~= nil do
                Citizen.Wait(0)

                DisableAllControlActions(0)
                DisableAllControlActions(1)
                DisableAllControlActions(2)

                EnableControlAction(0, 0xDFF812F9, true)
                EnableControlAction(0, 0x07CE1E61, true)
                EnableControlAction(0, 0xF84FA74F, true)
                --EnableControlAction(0, 0x7F8D09B8, true)

                if IsCamRendering(houseCam) and houseCam ~= nil then
                    if initialCam ~= nil then
                        SetCamActive(initialCam, false)
                        DestroyCam(initialCam, true)
                        initialCam = nil
                    end

                    for i = 0, 32 do
                        if NetworkIsPlayerActive(i) then
                            SetPlayerInvisibleLocally(i, true)
                        end
                    end

                    SetFocusPosAndVel(center, 0.0, 0.0, 0.0)

                    local v = points[i]

                    SetCamCoord(houseCam, v, v, v)

                    PointCamAtCoord(houseCam, center)

                    i = i + 1

                    if i == #points then
                        i = 1
                    end
                end
            end
        end
    )
end

function destroyHouseCam()
    SetCamActive(houseCam, false)
    DestroyCam(houseCam, true)
    houseCam = nil
    ClearFocus()

    for i = 0, 32 do
        if NetworkIsPlayerActive(i) then
            SetPlayerInvisibleLocally(i, false)
        end
    end
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            PromptDelete(prompt_open)
            PromptDelete(prompt_buy_dollar)
            PromptDelete(prompt_buy_gold)
            PromptDelete(prompt_camera)
            PromptDelete(prompt_hide)
            destroyHouseCam()

            for _, blip in pairs(myhouseblips) do
                RemoveBlip(blip)
            end
        end
    end
)
