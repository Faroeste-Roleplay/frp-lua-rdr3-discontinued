local fishing_minigame_struct = {}

local fishing_lure_cooldown = 0
local fishing_data = {
    fish = {
        weight = 0,
        rodweight
    },
    prompt_prepare_fishing = {
        group,
        change_bait,
        cancel
    },
    prompt_waiting_hook = {
        group,
        hook,
        cancel
    },
    prompt_hook = {
        group,
        reel,
        cancel
    },
    prompt_finish = {
        group,
        take,
        cancel
    }
}

local fishStatus = 0
local fishForce = 0.6
local nextAttTime = 0
local horizontalMove = 0

-- A_C_FISHBULLHEADCAT_01_SM       Peixe-Gato-Cabeçudo
-- A_C_FISHSALMONSOCKEYE_01_MS     Salmão-Vermelho
-- A_C_FISHRAINBOWTROUT_01_MS      Truta-Arco-Íris
-- A_C_FISHLARGEMOUTHBASS_01_MS    Achigã
-- A_C_FISHLARGEMOUTHBASS_01_LG    Achigã
-- A_C_FISHSMALLMOUTHBASS_01_MS    Achigã-Boca-Pequena
-- A_C_FISHSMALLMOUTHBASS_01_LG    Achigã-Boca-Pequena
-- A_C_FISHBLUEGIL_01_MS   Perca-Sol de Guelras Azuis
-- A_C_FISHMUSKIE_01_LG    Lúcio-Almiscarado
-- A_C_FISHCHANNELCATFISH_01_LG    Bagre-Americano
-- A_C_FISHSALMONSOCKEYE_01_ML     Salmão-Vermelho
-- A_C_FISHPERCH_01_MS     Perca
-- A_C_FISHPERCH_01_SM     Perca
-- A_C_FISHRAINBOWTROUT_01_LG      Truta-Arco-Íris
-- A_C_FISHROCKBASS_01_SM  Achigã-da-Rocha
-- A_C_FISHLAKESTURGEON_01_LG      Esturjão-de-Lago
-- A_C_FISHCHANNELCATFISH_01_XL    Bagre-Americano
-- A_C_FISHREDFINPICKEREL_01_SM    Lúcio-Colorado
-- A_C_FISHROCKBASS_01_MS  Achigã-da-Rocha
-- A_C_FISHREDFINPICKEREL_01_MS    Lúcio-Colorado
-- A_C_FISHBLUEGIL_01_SM   Perca-Sol de Guelras Azuis
-- A_C_FISHSALMONSOCKEYE_01_LG     Salmão-Vermelho
-- A_C_FISHNORTHERNPIKE_01_LG      Lúcio
-- A_C_FISHLONGNOSEGAR_01_LG       Boca-de-Jacaré
-- A_C_FISHBULLHEADCAT_01_MS       Peixe-Gato-Cabeçudo
-- A_C_FISHCHAINPICKEREL_01_MS     Lúcio-Negro
-- A_C_FISHCHAINPICKEREL_01_SM     Lúcio-Negro
local fishs = {
    [0X6F4C2A6C] = "Perca-Sol de Guelras Azuis", -- A_C_FISHBLUEGIL_01_MS
    [0X81D4FAB9] = "Perca-Sol de Guelras Azuis", -- A_C_FISHBLUEGIL_01_SM
    [0X29F1CB9D] = "Peixe-Gato-Cabeçudo", -- A_C_FISHBULLHEADCAT_01_MS
    [0X5905A300] = "Peixe-Gato-Cabeçudo", -- A_C_FISHBULLHEADCAT_01_SM
    [0XB97D1BFD] = "Lúcio-Negro", -- A_C_FISHCHAINPICKEREL_01_MS
    [0X0FBEB3FF] = "Lúcio-Negro", -- A_C_FISHCHAINPICKEREL_01_SM
    [0X5BAEE06E] = "Bagre-Americano", -- A_C_FISHCHANNELCATFISH_01_LG
    [0X876CAA75] = "Bagre-Americano", -- A_C_FISHCHANNELCATFISH_01_XL
    [0XEE111F34] = "Esturjão-de-Lago", -- A_C_FISHLAKESTURGEON_01_LG
    [0X1BA2A2E8] = "Achigã", -- A_C_FISHLARGEMOUTHBASS_01_LG
    [0X0750FD65] = "Achigã", -- A_C_FISHLARGEMOUTHBASS_01_MS
    [0XD5931B3F] = "Boca-de-Jacaré", -- A_C_FISHLONGNOSEGAR_01_LG
    [0XA3660A8D] = "Lúcio-Almiscarado", -- A_C_FISHMUSKIE_01_LG
    [0X298C8600] = "Lúcio", -- A_C_FISHNORTHERNPIKE_01_LG
    [0XE50B98F0] = "Perca", -- A_C_FISHPERCH_01_MS
    [0X2A1C1C20] = "Perca", -- A_C_FISHPERCH_01_SM
    [0X080814B2] = "Truta-Arco-Íris", -- A_C_FISHRAINBOWTROUT_01_LG
    [0X1D373E24] = "Truta-Arco-Íris", -- A_C_FISHRAINBOWTROUT_01_MS
    [0XF1813D52] = "Lúcio-Colorado", -- A_C_FISHREDFINPICKEREL_01_MS
    [0X1E9790B6] = "Lúcio-Colorado", -- A_C_FISHREDFINPICKEREL_01_SM
    [0X89E3C580] = "Achigã-da-Rocha", -- A_C_FISHROCKBASS_01_MS
    [0X00173415] = "Achigã-da-Rocha", -- A_C_FISHROCKBASS_01_SM
    [0X206B229A] = "Salmão-Vermelho", -- A_C_FISHSALMONSOCKEYE_01_LG
    [0X657C2DBF] = "Salmão-Vermelho", -- A_C_FISHSALMONSOCKEYE_01_ML
    [0X027C67C1] = "Salmão-Vermelho", -- A_C_FISHSALMONSOCKEYE_01_MS
    [0X8FACF62D] = "Achigã-Boca-Pequena", -- A_C_FISHSMALLMOUTHBASS_01_LG
    [0X6EE63594] = "Achigã-Boca-Pequena" -- A_C_FISHSMALLMOUTHBASS_01_MS
}

-- "p_baitBread01x";
-- "p_baitCorn01x";
-- "p_baitCheese01x";
-- "p_baitWorm01x";
-- "p_baitCricket01x";
-- "P_CRAWDAD01X";
-- "p_finishedragonfly01x";
-- "p_FinisdFishlure01x";
-- "p_finishdcrawd01x";
-- "P_FINISHEDRAGONFLYLEGENDARY01X";
-- "P_FINISDFISHLURELEGENDARY01X";
-- "P_FINISHDCRAWDLEGENDARY01X";
-- "P_LGOC_SPINNER_V4";
-- P_FISHHOOK02X -- Anzol

local lure = {
    [`p_baitBread01x`] = "p_baitBread01x",
    [`p_baitCorn01x`] = "p_baitCorn01x",
    [`p_baitCheese01x`] = "p_baitCheese01x",
    [`p_baitWorm01x`] = "p_baitWorm01x",
    [`p_baitCricket01x`] = "p_baitCricket01x",
    [`P_CRAWDAD01X`] = "P_CRAWDAD01X",
    [`p_finishedragonfly01x`] = "p_finishedragonfly01x",
    [`p_FinisdFishlure01x`] = "p_FinisdFishlure01x",
    [`p_finishdcrawd01x`] = "p_finishdcrawd01x",
    [`P_FINISHEDRAGONFLYLEGENDARY01X`] = "P_FINISHEDRAGONFLYLEGENDARY01X",
    [`P_FINISDFISHLURELEGENDARY01X`] = "P_FINISDFISHLURELEGENDARY01X",
    [`P_FINISHDCRAWDLEGENDARY01X`] = "P_FINISHDCRAWDLEGENDARY01X",
    [`P_LGOC_SPINNER_V4`] = "P_LGOC_SPINNER_V4",
}
local atualLure = "P_FINISHDCRAWDLEGENDARY01X"

local lureFish = {
    ["P_FINISHDCRAWDLEGENDARY01X"] = {
        "A_C_FISHBLUEGIL_01_MS",
        "A_C_FISHBLUEGIL_01_SM",
        "A_C_FISHBULLHEADCAT_01_MS",
        "A_C_FISHBULLHEADCAT_01_SM",
        "A_C_FISHCHAINPICKEREL_01_MS",
        "A_C_FISHCHAINPICKEREL_01_SM",
        "A_C_FISHCHANNELCATFISH_01_LG",
        "A_C_FISHCHANNELCATFISH_01_XL",
        "A_C_FISHLAKESTURGEON_01_LG",
        "A_C_FISHLARGEMOUTHBASS_01_LG",
        "A_C_FISHLARGEMOUTHBASS_01_MS",
        "A_C_FISHLONGNOSEGAR_01_LG",
        "A_C_FISHMUSKIE_01_LG",
        "A_C_FISHNORTHERNPIKE_01_LG",
        "A_C_FISHPERCH_01_MS",
        "A_C_FISHPERCH_01_SM",
        "A_C_FISHRAINBOWTROUT_01_LG",
        "A_C_FISHRAINBOWTROUT_01_MS",
        "A_C_FISHREDFINPICKEREL_01_MS",
        "A_C_FISHREDFINPICKEREL_01_SM",
        "A_C_FISHROCKBASS_01_MS",
        "A_C_FISHROCKBASS_01_SM",
        "A_C_FISHSALMONSOCKEYE_01_LG",
        "A_C_FISHSALMONSOCKEYE_01_ML",
        "A_C_FISHSALMONSOCKEYE_01_MS",
        "A_C_FISHSMALLMOUTHBASS_01_LG",
        "A_C_FISHSMALLMOUTHBASS_01_MS"
    }
}
local lastState = 0

Citizen.CreateThread(
    function()
        Citizen.InvokeNative(0x1096603B519C905F, "MMFSH")

        local sleep = 100
        prepareMyPrompt()

        while true do
            GET_TASK_FISHING_DATA()

            -- for i = 0, 27 do
            --     local k = "f_" .. i
            --     local v = fishing_minigame_struct[k]

            --     if v ~= nil then
            --         DrawTxt(k, 0.65, 0.05 + (i * 0.025), 0.4, 0.4, true, 247, 88, 20, 255, false)
            --         DrawTxt("" .. v, 0.75, 0.05 + (i * 0.025), 0.4, 0.4, true, 247, 88, 20, 255, false)
            --     end
            -- end

            if FISHING_GET_MINIGAME_STATE() == 1 then
                if IsControlJustPressed(0, GetHashKey("INPUT_ATTACK")) then
                    atualLure = "P_FINISHDCRAWDLEGENDARY01X"                    
                    TaskSwapFishingBait(PlayerPedId(), atualLure, 0)    
                    Citizen.InvokeNative(0x9B0C7FA063E67629, PlayerPedId(), atualLure, 0, 1)
                end
                
                if IsControlJustPressed(0, 0xDB096B85) then
                    -- CANCELAR PESCA
                    local playerPed = PlayerPedId()
                    SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), false)
                end
            end

            if hasMinigameOn then
                sleep = 0

                local playerPed = PlayerPedId()

                if FISHING_GET_MINIGAME_STATE() == 2 then
                    FISHING_GET_MAX_THROWING_DISTANCE(math.random(25.0, 30.0))
                end

                if FISHING_GET_MINIGAME_STATE() == 6 then
                    if IsControlJustPressed(0, 0x8FFC75D6) then
                        FISHING_SET_F_(6, 128)
                    end

                    local bobberPosition = FISHING_GET_BOBBER_HANDLE()

                    local hookHandle = FISHING_GET_HOOK_HANDLE()
                    local hookPosition = GetEntityCoords(hookHandle)
                    -- if IsControlJustPressed(0, GetHashKey("INPUT_GAME_MENU_OPTION")) or
                    --     (IsControlPressed(0, GetHashKey("INPUT_GAME_MENU_OPTION")) == 1 and GetGameTimer() % 10 == 0) then
                    --     FISHING_SET_ROD_WEIGHT(4)
                    --     print('puxando')
                    --     TaskGoToEntity(hookHandle, playerPed, 50, 5000, 10.0, 1.0, 0)
                    -- end

                    -- if IsControlJustReleased(0, GetHashKey("INPUT_GAME_MENU_OPTION")) then
                    --     FISHING_SET_ROD_WEIGHT(2)
                    -- end

                    local lured = false

                    if FISHING_GET_LINE_DISTANCE() < 4.0 then
                        FISHING_SET_F_(14, 1.0)
                    else
                        FISHING_SET_F_(14, 0.4)
                    end

                    local fishHandle

                    for _, f in pairs(GetNearbyFishs(hookPosition, 50.0)) do
                        local fishPosition = GetEntityCoords(f)

                        Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, fishPosition, fishPosition + vec3(0, 0, 2.0), 255, 255, 0, 255)

                        if fishing_lure_cooldown <= GetGameTimer() then
                            local dist = #(hookPosition - fishPosition)
                            if dist <= 1.6 then
                                fishHandle = f
                            else
                                if peixeEhAtraidoPelaIsca(GetEntityModel(f)) then
                                    TaskGoToEntity(f, bobberPosition, 100, 1, 1.0, 2.0, 0)
                                end
                            end

                            if lured == false then
                                lured = true
                            end
                        end
                    end

                    if lured then
                        fishing_lure_cooldown = GetGameTimer() + (1 * 1000)
                    end

                    if fishHandle then
                        local probabilidadePuxar = math.random()
                        print(probabilidadePuxar)
                        if probabilidadePuxar > 0.9 or probabilidadePuxar < 0.2 then -- soltar linha
                            if FISHING_GET_F_(5) == 1 then
                                Citizen.InvokeNative(0xF0FBF193F1F5C0EA, fishHandle)

                                SetPedConfigFlag(fishHandle, 17, true)

                                Citizen.InvokeNative(0x1F298C7BD30D1240, playerPed)

                                ClearPedTasksImmediately(fishHandle, false, true)
                                TaskSetBlockingOfNonTemporaryEvents(fishHandle, true)

                                Citizen.InvokeNative(0x1A52076D26E09004, playerPed, fishHandle)
                                -- SET_FISHINGROD_HOOKED_ENTITY

                                FISHING_SET_FISH_HANDLE(fishHandle)
                                fishForce = 0.6

                                FISHING_SET_TRANSITION_FLAG(4)
                            end
                        end
                    end
                end

                if FISHING_GET_MINIGAME_STATE() == 7 then
                    fishing_data.fish.weight = FISHING_GET_F_(8)

                    if IsControlJustPressed(0, 0x8FFC75D6) then
                        FISHING_SET_F_(6, 11)
                    end
                    local fishHandle = FISHING_GET_FISH_HANDLE()

                    if GetControlNormal(0, 0x390948DC) > 0 then -- Direita
                        horizontalMove = horizontalMove - (0.05 * GetControlNormal(0, 0x390948DC))
                    end
                    if GetControlNormal(0, 0x390948DC) < 0 then -- Esquerda
                        horizontalMove = horizontalMove + (0.05 * -GetControlNormal(0, 0x390948DC))
                    end
                    if horizontalMove < 0 then
                        horizontalMove = 0
                    end
                    if horizontalMove > 1 then
                        horizontalMove = 1
                    end
                    FISHING_SET_F_(22, horizontalMove)

                    -- Unused?
                    if FISHING_GET_LINE_DISTANCE() < 4.0 then
                        FISHING_SET_F_(6, 12)
                        FISHING_SET_F_(14, 1.0)
                    else
                        FISHING_SET_F_(14, 1.0)
                    end

                    if GetGameTimer() >= nextAttTime then
                        local probabilidadePuxar = math.random()
                        if probabilidadePuxar > 0.8 or probabilidadePuxar < 0.2 then -- soltar linha
                            fishForce = 0.8
                            tempoPuxando = math.random(3, 5) * 1000
                            fishStatus = 1 -- agitado
                            nextAttTime = GetGameTimer() + tempoPuxando

                            local fishHandle = FISHING_GET_FISH_HANDLE()

                            local x,y,z = table.unpack(GetEntityCoords(fishHandle))

                            local r = exports["frp_fishing"]:VERTICAL_PROBE(x, y,  z, 1)
                            local valid, height = r[1], r[2]

                            local particleFx = StartNetworkedParticleFxLoopedOnEntityBone("scr_mg_fishing_drips", fishHandle, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, GetEntityBoneIndexByName(fishHandle, "SKEL_Tail5"), 1065353216, 0, 0, 0);
                            SetParticleFxLoopedEvolution(particleFx, "fade", 0.0, false)
                            StartNetworkedParticleFxNonLoopedAtCoord("scr_mg_fish_struggle", x, y, height, 0.0, 0.0, math.random(0, 360) + 0.0001, 1.2, 0, 0, 0);

                            animDict = "mini_games@fishing@shore@hooked_med@struggle"
                            
                            if not HasAnimDictLoaded(animDict) then
                                RequestAnimDict(animDict)
		                        while not HasAnimDictLoaded(animDict) do
			                        Citizen.Wait(0)
                                end
                            end

                            

                            -- struggle_pullup
                            -- struggle_a

                            PlayEntityAnim(fishHandle, "struggle_a", animDict, 1000.0, false, true, false, 0.0, 0)
                        else -- deixar puxar
                            fishForce = 0
                            tempoPuxando = math.random(6, 10) * 1000
                            fishStatus = 0 -- calmo
                            nextAttTime = GetGameTimer() + tempoPuxando
                        end
                    end

                    if fishStatus == 1 then -- agitado
                        if IsControlPressed(0, GetHashKey("INPUT_GAME_MENU_OPTION")) then
                            FISHING_SET_ROD_WEIGHT(4)
                            fishForce = fishForce + 0.005
                        else
                            fishForce = fishForce - 0.005
                        end

                        if IsControlJustReleased(0, GetHashKey("INPUT_GAME_MENU_OPTION")) then
                            FISHING_SET_ROD_WEIGHT(2)
                        end

                        if fishForce >= 1.4 then
                            FISHING_SET_F_(6, 11)
                        else
                            if fishForce < 0.8 then
                                fishForce = 0.8
                            end
                        end
                        TaskSmartFleeCoord(fishHandle, GetEntityCoords(playerPed), 40.0, 50, 8, 1077936128)
                    else -- calmo
                        if IsControlJustPressed(0, GetHashKey("INPUT_GAME_MENU_OPTION")) or (IsControlPressed(0, GetHashKey("INPUT_GAME_MENU_OPTION")) and GetGameTimer() % 25 == 0) then
                            FISHING_SET_ROD_WEIGHT(4)
                            -- #######################################################
                            -- SetBlockingOfNonTemporaryEvents(fishHandle, true)
                            -- TaskGoToEntity(fishHandle, playerPed, 500, 5, 2.0, 2.0, 0)
                            -- ApplyForceToEntity(fishHandle, 0, GetEntityCoords(playerPed))
                            -- SetEntityVelocity(fishHandle, GetEntityCoords(playerPed))
                            -- TaskGoToEntity(fishHandle, playerPed, 1000, 20, 1.0, 0.0, 1)
                            -- Citizen.InvokeNative(0x53187E563F938E76,1)
                            TaskGoToEntity(fishHandle, playerPed, -1, 1.0, 1.5, 0.0, 0)
                        end

                        if IsControlJustReleased(0, GetHashKey("INPUT_GAME_MENU_OPTION")) then
                            FISHING_SET_ROD_WEIGHT(2)
                        end
                    end

                    if FISHING_GET_F_(6) ~= 11 and FISHING_GET_F_(6) ~= 12 then
                        FISHING_SET_F_(13, fishForce)
                        FISHING_SET_F_(21, fishForce)
                    end

                    if IsControlJustPressed(0, GetHashKey("INPUT_ATTACK")) then
                        FISHING_SET_ROD_POSITION_UD(0.6)
                    end

                    if IsControlJustReleased(0, GetHashKey("INPUT_ATTACK")) then
                        FISHING_SET_ROD_POSITION_UD(0.0)
                    end
                end

                if FISHING_GET_MINIGAME_STATE() == 12 then
                    -- FICAR COM O PEIXE
                    if IsControlJustPressed(0, GetHashKey("INPUT_ATTACK")) then
                        FISHING_SET_TRANSITION_FLAG(32)
                    end

                    -- JOGAR O PEIXE DE VOLTA
                    if IsControlJustPressed(0, GetHashKey("INPUT_AIM")) then
                        FISHING_SET_TRANSITION_FLAG(64)
                    end

                    if FISHING_GET_F_(5) == 96 and FISHING_GET_F_(6) == 0 then
                        TriggerServerEvent("FRP:INVENTORY:getItem", fishs[GetEntityModel(FISHING_GET_FISH_HANDLE())], 1)
                        SetEntityVisible(FISHING_GET_FISH_HANDLE(), false)
                        SetEntityAsMissionEntity(FISHING_GET_FISH_HANDLE(), true, true)
                        DeleteEntity(FISHING_GET_FISH_HANDLE())
                    end
                end

                if IsControlJustPressed(0, GetHashKey("INPUT_TOGGLE_HOLSTER")) then
                    FISHING_SET_TRANSITION_FLAG(8)
                end
            end

            lastState = FISHING_GET_MINIGAME_STATE()
            Citizen.Wait(sleep)
        end
    end
)

Citizen.CreateThread(
    function()
        prepareMyPrompt()
        while true do
            if FISHING_GET_MINIGAME_STATE() == 1 then
                PromptSetActiveGroupThisFrame(fishing_data.prompt_prepare_fishing.group, CreateVarString(10, "LITERAL_STRING", "Pesca"))
            end

            if FISHING_GET_MINIGAME_STATE() == 6 then
                PromptSetActiveGroupThisFrame(fishing_data.prompt_waiting_hook.group, CreateVarString(10, "LITERAL_STRING", "Esperando Fisgar"))
            end

            if FISHING_GET_MINIGAME_STATE() == 7 then
                fishing_data.fish.weight = FISHING_GET_F_(8)
                PromptSetActiveGroupThisFrame(fishing_data.prompt_hook.group, CreateVarString(10, "LITERAL_STRING", "Puxando Peixe"))
            end

            if FISHING_GET_MINIGAME_STATE() == 12 then
                PromptSetActiveGroupThisFrame(fishing_data.prompt_finish.group, CreateVarString(10, "LITERAL_STRING", "Peixe " .. fishs[GetEntityModel(FISHING_GET_FISH_HANDLE())] .. " Kg" .. (fishing_data.fish.weight * 54.25)))
            end
            Citizen.Wait(0)
        end
    end
)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    Citizen.InvokeNative(0xADA9255D, 4)
    DisplayText(str, x, y)
end

RegisterCommand(
    "garmas",
    function()
        RemoveAllPedWeapons(PlayerPedId(), true, true)
    end,
    false
)

function GET_TASK_FISHING_DATA()
    local r = exports["research"]:GET_TASK_FISHING_DATA()

    hasMinigameOn = r[1]
    local outAsInt = r[2]
    local outAsFloat = r[3]

    fishing_minigame_struct = {}

    fishing_minigame_struct = {
        f_0 = outAsInt["0"],
        f_1 = outAsFloat["2"],
        f_2 = outAsFloat["4"],
        f_3 = outAsFloat["6"],
        f_4 = outAsFloat["8"],
        f_5 = outAsInt["10"],
        f_6 = outAsInt["12"],
        f_7 = outAsInt["14"],
        f_8 = outAsFloat["16"],
        f_9 = outAsFloat["18"],
        f_10 = outAsInt["20"],
        f_11 = outAsInt["22"],
        f_12 = outAsInt["24"],
        f_13 = outAsFloat["26"],
        f_14 = outAsFloat["28"],
        f_15 = outAsFloat["30"],
        f_16 = outAsInt["32"],
        f_17 = outAsFloat["34"],
        f_18 = outAsInt["36"],
        f_19 = outAsInt["38"],
        f_20 = outAsFloat["40"],
        f_21 = outAsFloat["42"],
        f_22 = outAsFloat["44"], -- Rod position [LEFT-RIGHT] -1.0: Center, 0.0: Right, 1.0: Left
        f_23 = outAsFloat["46"], -- Rod position [UP-DOWN] -1.0: Center, 0.0: Down, 1.0: Up
        f_24 = outAsFloat["48"], -- 7.0 - 15.0
        f_25 = outAsFloat["50"], -- 10.0 - 20.0
        f_26 = outAsFloat["52"],
        f_27 = outAsFloat["54"] -- Radians/Degrees
    }
end

function peixeEhAtraidoPelaIsca(modeloPeixe)
    local peixesAtraidos = lureFish[atualLure]
    if peixesAtraidos ~= nil then
        for _, peixe in pairs(peixesAtraidos) do
            if fishs[modeloPeixe] == peixe then
                return true
            end
        end
    end
    return false
end

function SET_TASK_FISHING_DATA()
    if fishing_minigame_struct.f_0 ~= nil then
        exports["research"]:SET_TASK_FISHING_DATA(fishing_minigame_struct)
    end
end

function FISHING_HAS_MINIGAME_ON()
    return hasMinigameOn
end

function FISHING_GET_F_(f)
    return fishing_minigame_struct["f_" .. f]
end

function FISHING_GET_MINIGAME_STATE()
    return FISHING_GET_F_(0)
end

function FISHING_GET_MAX_THROWING_DISTANCE()
    return FISHING_GET_F_(1)
end

function FISHING_GET_LINE_DISTANCE()
    return FISHING_GET_F_(2)
end

function FISHING_GET_TRANSITION_FLAG()
    return FISHING_GET_F_(6)
end

function FISHING_GET_FISH_HANDLE()
    return FISHING_GET_F_(7)
end

function FISHING_GET_CALCULATED_FISH_WEIGHT()
    return FISHING_GET_F_(8)
end

-- Fish current power?
function FISHING_GET_F_9()
    return FISHING_GET_F_(9)
end

function FISHING_GET_SCRIPT_TIMER()
    return FISHING_GET_F_(10)
end

function FISHING_GET_BOBBER_HANDLE()
    return FISHING_GET_F_(11)
end

function FISHING_GET_HOOK_HANDLE()
    return FISHING_GET_F_(12)
end

function FISHING_SET_F_(f, v)
    fishing_minigame_struct["f_" .. f] = v
    SET_TASK_FISHING_DATA()
end

function FISHING_SET_LINE_DISTANCE(v)
    FISHING_SET_F_(2, v)
end

function FISHING_SET_TRANSITION_FLAG(v)
    FISHING_SET_F_(6, v)
end

function FISHING_SET_FISH_HANDLE(v)
    FISHING_SET_F_(7, v)

    local weight_index = FishModelToSomeSortOfWeightIndex(GetEntityModel(v))

    FISHING_SET_CALCULATED_FISH_WEIGHT(GetRandomFishWeightForWeightIndex(weight_index) / 54.25)

    fishing_data.fish.rodweight = 2
    FISHING_SET_ROD_WEIGHT(fishing_data.fish.rodweight)
end

function FISHING_SET_CALCULATED_FISH_WEIGHT(v)
    fishing_data.fish.weight = v * 54.25

    FISHING_SET_F_(8, v)
end

function FISHING_SET_ROD_WEIGHT(v)
    FISHING_SET_F_(18, v)
end

--[[
    [LEFT-RIGHT] -1.0: Center, 0.0: Right, 1.0: Left
]]
function FISHING_SET_ROD_POSITION_LR(v)
    FISHING_SET_F_(22, v)
end

--[[
    [UP-DOWN] -1.0: Center, 0.0: Down, 1.0: Up
]]
function FISHING_SET_ROD_POSITION_UD(v)
    FISHING_SET_F_(23, v)
end

-- RegisterCommand(
--     "bait",
--     function(source, args, raw)
--         Citizen.InvokeNative(0x9B0C7FA063E67629, PlayerPedId(), "P_FINISHDCRAWDLEGENDARY01X", 0, 1)
--     end,
--     false
-- )

-- RegisterCommand(
--     "fset",
--     function(source, args, raw)
--         if tonumber(args[2]) then
--             args[2] = tonumber(args[2])
--         end

--         fishing_minigame_struct["f_" .. args[1]] = args[2]
--         SET_TASK_FISHING_DATA()
--     end,
--     false
-- )

-- RegisterCommand(
--     "hook",
--     function(source, args, rawCommand)
--         Citizen.InvokeNative(0x1A52076D26E09004, PlayerPedId(), tonumber(args[1]))
--     end
-- )

-- RegisterCommand(
--     "fish",
--     function(source, args, rawCommand)
--         local r = {
--             "A_C_FISHBLUEGIL_01_SM",
--             "A_C_FISHBULLHEADCAT_01_SM",
--             "A_C_FISHCHAINPICKEREL_01_SM",
--             "A_C_FISHCHANNELCATFISH_01_LG",
--             "A_C_FISHLAKESTURGEON_01_LG",
--             "A_C_FISHLARGEMOUTHBASS_01_MS",
--             "A_C_FISHLONGNOSEGAR_01_LG",
--             "A_C_FISHMUSKIE_01_LG",
--             "A_C_FISHNORTHERNPIKE_01_LG",
--             "A_C_FISHPERCH_01_SM",
--             "A_C_FISHREDFINPICKEREL_01_SM",
--             "A_C_FISHROCKBASS_01_SM",
--             "A_C_FISHSMALLMOUTHBASS_01_MS",
--             "A_C_FISHSALMONSOCKEYE_01_MS",
--             "A_C_FISHRAINBOWTROUT_01_MS"
--         }

--         local pedModel = r[math.random(1, #r)]

--         local pedModelHash = GetHashKey(pedModel)
--         if not IsModelValid(pedModelHash) then
--             print("model is not valid")
--             return
--         end

--         if not HasModelLoaded(pedModelHash) then
--             RequestModel(pedModelHash)
--             while not HasModelLoaded(pedModelHash) do
--                 Citizen.Wait(10)
--             end
--         end

--         local plped = PlayerPedId()
--         local forward = GetEntityForwardVector(plped)
--         local c = GetEntityCoords(plped) + (forward * 10.0)

--         local ped = CreatePed(pedModelHash, c, GetEntityHeading(plped), 1, 0)
--         Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
--         Citizen.InvokeNative(0x58A850EAEE20FAA3, ped)
--         print(ped)
--     end
-- )

function GetNearbyFishs(coords, radius)
    local r = {}

    local itemSet = CreateItemset(true)
    local size = Citizen.InvokeNative(0x59B57C4B06531E1E, coords, radius, itemSet, 1, Citizen.ResultAsInteger())
    -- number xPos, number yPox, number zPos, float distance, int itemSet, int entityType

    if size > 0 then
        for index = 0, size - 1 do
            local entity = GetIndexedItemInItemset(index, itemSet)
            if GetEntityPopulationType(entity) == 6 and not IsPedDeadOrDying(entity, 0) then
                table.insert(r, entity)
            end
        end
    end

    if IsItemsetValid(itemSet) then
        DestroyItemset(itemSet)
    end

    return r
end

function FishModelToSomeSortOfWeightIndex(fishModel)
    if fishModel == GetHashKey("A_C_FISHBLUEGIL_01_SM") or fishModel == GetHashKey("A_C_FISHBLUEGIL_01_MS") then
        return 0
    elseif fishModel == GetHashKey("A_C_FISHBULLHEADCAT_01_MS") or fishModel == GetHashKey("A_C_FISHBULLHEADCAT_01_SM") then
        return 1
    elseif fishModel == GetHashKey("A_C_FISHCHAINPICKEREL_01_MS") or fishModel == GetHashKey("A_C_FISHCHAINPICKEREL_01_SM") then
        return 2
    elseif fishModel == GetHashKey("A_C_FISHCHANNELCATFISH_01_XL") or fishModel == GetHashKey("A_C_FISHCHANNELCATFISH_01_LG") then
        return 3
    elseif fishModel == GetHashKey("A_C_FISHLAKESTURGEON_01_LG") then
        return 4
    elseif fishModel == GetHashKey("A_C_FISHLARGEMOUTHBASS_01_MS") or fishModel == GetHashKey("A_C_FISHLARGEMOUTHBASS_01_LG") then
        return 5
    elseif fishModel == GetHashKey("A_C_FISHLONGNOSEGAR_01_LG") then
        return 6
    elseif fishModel == GetHashKey("A_C_FISHMUSKIE_01_LG") then
        return 7
    elseif fishModel == GetHashKey("A_C_FISHNORTHERNPIKE_01_LG") then
        return 8
    elseif fishModel == GetHashKey("A_C_FISHPERCH_01_MS") or fishModel == GetHashKey("A_C_FISHPERCH_01_SM") then
        return 9
    elseif fishModel == GetHashKey("A_C_FISHREDFINPICKEREL_01_MS") or fishModel == GetHashKey("A_C_FISHREDFINPICKEREL_01_SM") then
        return 10
    elseif fishModel == GetHashKey("A_C_FISHROCKBASS_01_MS") or fishModel == GetHashKey("A_C_FISHROCKBASS_01_SM") then
        return 11
    elseif fishModel == GetHashKey("A_C_FISHSMALLMOUTHBASS_01_LG") or fishModel == GetHashKey("A_C_FISHSMALLMOUTHBASS_01_MS") then
        return 12
    elseif fishModel == GetHashKey("A_C_FISHSALMONSOCKEYE_01_MS") or fishModel == GetHashKey("A_C_FISHSALMONSOCKEYE_01_LG") then
        return 13
    elseif fishModel == GetHashKey("A_C_FISHRAINBOWTROUT_01_LG") or fishModel == GetHashKey("A_C_FISHRAINBOWTROUT_01_MS") then
        return 14
    end
end

function GetMinMaxWeightForWeightIndex(index)
    local min = 0.0
    local max = 0.0

    if index == 0 or index == 1 or index == 3 or index == 9 or index == 10 or index == 11 then
        min = 0.5
        max = 2.0
    elseif index == 3 or index == 4 or index == 6 or index == 7 or index == 8 then
        min = 14.0
        max = 20.0
    elseif index == 5 or index == 12 or index == 13 or index == 14 then
        min = 4.0
        max = 6.0
    end

    min = min * 0.25
    max = max * 0.25

    -- w = w + (w * 0.5)

    return min, max
end

function GetRandomFishWeightForWeightIndex(index)
    local min, max = GetMinMaxWeightForWeightIndex(index)

    local weight = math.random() * (max - min) + min

    -- implement fishing_core:func_377 ?

    return weight
end

function prepareMyPrompt()
    -- Preparando para pesca
    fishing_data.prompt_prepare_fishing.group = GetRandomIntInRange(0, 0xffffff)
    local prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, GetHashKey("INPUT_ATTACK")) -- MOUSE LEFT CLICK
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Trocar Isca"))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, false)
    PromptSetGroup(prompt, fishing_data.prompt_prepare_fishing.group)
    PromptRegisterEnd(prompt)
    fishing_data.prompt_prepare_fishing.change_bait = prompt

    prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, 0xDB096B85) -- LEFT CONTROL
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Cancelar Pesca"))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, false)
    PromptSetGroup(prompt, fishing_data.prompt_prepare_fishing.group)
    PromptRegisterEnd(prompt)
    fishing_data.prompt_prepare_fishing.cancel = prompt

    -- Esperando fisgar
    fishing_data.prompt_waiting_hook.group = GetRandomIntInRange(0, 0xffffff)
    prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, GetHashKey("INPUT_ATTACK")) -- MOUSE LEFT CLICK
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Fisgar"))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, false)
    PromptSetGroup(prompt, fishing_data.prompt_waiting_hook.group)
    PromptRegisterEnd(prompt)
    fishing_data.prompt_waiting_hook.hook = prompt

    prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, 0x8FFC75D6) -- LEFT SHIFT
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Recolher Linha"))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, false)
    PromptSetGroup(prompt, fishing_data.prompt_waiting_hook.group)
    PromptRegisterEnd(prompt)
    fishing_data.prompt_waiting_hook.cancel = prompt

    -- Puxando Peixe
    fishing_data.prompt_hook.group = GetRandomIntInRange(0, 0xffffff)
    prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, 0xFBD7B3E6) -- SPACE
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Puxar Linha"))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, false)
    PromptSetGroup(prompt, fishing_data.prompt_hook.group)
    PromptRegisterEnd(prompt)
    fishing_data.prompt_hook.reel = prompt

    prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, 0x8FFC75D6) -- LEFT SHIFT
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Cortar Linha"))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, false)
    PromptSetGroup(prompt, fishing_data.prompt_hook.group)
    PromptRegisterEnd(prompt)
    fishing_data.prompt_hook.cancel = prompt

    -- Peixe Pego
    fishing_data.prompt_finish.group = GetRandomIntInRange(0, 0xffffff)
    prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, GetHashKey("INPUT_ATTACK")) -- MOUSE LEFT CLICK
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Pegar o peixe"))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, false)
    PromptSetGroup(prompt, fishing_data.prompt_finish.group)
    PromptRegisterEnd(prompt)
    fishing_data.prompt_finish.take = prompt

    prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, GetHashKey("INPUT_AIM")) -- MOUSE RIGHT CLICK
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Devolver o peixe"))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, false)
    PromptSetGroup(prompt, fishing_data.prompt_finish.group)
    PromptRegisterEnd(prompt)
    fishing_data.prompt_finish.cancel = prompt
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            PromptDelete(fishing_data.prompt_prepare_fishing.change_bait)
            PromptDelete(fishing_data.prompt_prepare_fishing.cancel)
            PromptDelete(fishing_data.prompt_waiting_hook.hook)
            PromptDelete(fishing_data.prompt_waiting_hook.cancel)
            PromptDelete(fishing_data.prompt_hook.reel)
            PromptDelete(fishing_data.prompt_hook.cancel)
            PromptDelete(fishing_data.prompt_finish.take)
            PromptDelete(fishing_data.prompt_finish.cancel)
        end
    end
)

-- uParam0->f_18 = GRAPHICS::START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("scr_mg_fishing_drips", Global_1902942->f_5.f_7, 0f, 0f, 0f, 0f, 0f, 0f, ENTITY::GET_ENTITY_BONE_INDEX_BY_NAME(Global_1902942->f_5.f_7, "SKEL_Tail5"), 1065353216, 0, 0, 0);
-- 	GRAPHICS::SET_PARTICLE_FX_LOOPED_EVOLUTION(uParam0->f_18, "fade", uParam0->f_19, false);
-- GRAPHICS::START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_mg_fish_struggle", vVar0, 0f, 0f, MISC::GET_RANDOM_FLOAT_IN_RANGE(0f, 360f), fVar3, 0, 0, 0);

-- if (!ENTITY::_0x0C9DBF48C6BA6E4C(PLAYER::PLAYER_PED_ID(),VCETOR3 vVar0, 1))

-- 0x53187E563F938E76
-- FISH MODEL SIZE??

-- ENTITY::_0x978AA2323ED32209(Local_5.f_5, 0f);

-- Global_1902942->f_5
-- Global_1902942->f_5.f_7

-- Global_1902942->f_5 == 7

-- * _0x0C9DBF48C6BA6E4C
-- * _HAS_ENTITY_CLEAR_LOS_OF_COORD

--[[
    CURVATURE: FUNC_158
]]

--[[
// 0xF3735ACD11ACD500
Any _GET_TASK_FISHING_DATA(Ped ped, Any* structData);
/*
  STATES:
    0 = Not in fishing at all.
    1 = Idle (no aim).
    2 = Aiming.
    3 = Going to throw.
    4 = Throwing.
    5 = ??? (never seen, unused in scripts).
    6 = Fishing idle.
    7 = Fight with a fish (after the bait).
    8 = ??? (never seen). Removes prompts it seems.
    9 = Removes the float.
    10 = ??? (never seen).
    11 = perdeu o peixe
    12 = Holding fish in hand(s).
    13 = Changing bait.
  STRUCT:
    f_0 = Minigame state.
    f_1 = Throwing target distance (< 10 = close range, too small = you will not be able to throw).
    f_2 = Float distance (?). Always 0.2 when not throwed.
    f_3 = Float something. / Fishing line curvature
    f_4 = Unk float.
    f_5 = Is picking. / Flag
    f_6 = Transition flag (4 if for 6 -> 7, 512 is unknown for now).
    f_7 = Fish entity handle.
    f_8 = Calculated fish weight (value / 54.25).
    f_9 = Fish current power? / Heading?
    f_10 = Script timer.
    f_11 = Bobber Entity
    f_12 = Hook Entity
    f_13 = Rod shaking float.
    f_14 = float
    f_15 = float
    f_16 = Unk int. (Some state?)
    f_17 = Going to fight shake? (float)
    f_18 = Fish size index. (0 - 4 or so). / Setting to 4 when on state 7, will make you reel slowly
    f_19 = Unk.
    f_20 = Unk float.
    f_21 = Line break apart float.
    f_22 = hozintal orientation
    f_23 = vertical orientation
  FLAGS:
    2: LINE_SNAP_BUG
    4: HOOKED_TURN_RIGHT
    8: CANCEL_FISHING
    128: REEL_IN11

    GODD:
    5: GOOD HOOK FISH STRUGGLE RIGHT
    12: GOOD FAST REEL IN
*/
--]]

-- Global_1902942->f_5.f_16
