local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Tunnel.getInterface("API")
cAPI = Proxy.getInterface("API")

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if IsControlJustPressed(0, 0x8CC9CD42) then
                local playerPed = PlayerPedId()
                if not IsEntityDead(playerPed) and not Citizen.InvokeNative(0x9682F850056C9ADE, playerPed) then
                    local animDict = "script_proc@robberies@homestead@lonnies_shack@deception"

                    if not IsEntityPlayingAnim(playerPed, animDict, "hands_up_loop", 3) then
                        if not HasAnimDictLoaded(animDict) then
                            RequestAnimDict(animDict)

                            while not HasAnimDictLoaded(animDict) do
                                Citizen.Wait(0)
                            end
                        end

                        TaskPlayAnim(playerPed, animDict, "hands_up_loop", 2.0, -2.0, -1, 67109393, 0.0, false, 1245184, false, "UpperbodyFixup_filter", false)

                        RequestAnimDict(animDict)
                    else
                        -- ClearPedTasks(playerPed)
                        ClearPedSecondaryTask(playerPed)
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            if IsControlPressed(0, 0x26E9DC00) then -- Z
                Citizen.InvokeNative(0xAE99FB955581844A, PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
            end

            if IsControlPressed(1, 0x4CC0E2FE) then
                RequestAnimDict("mech_loco_m@generic@reaction@pointing@unarmed@stand")
                while not HasAnimDictLoaded("mech_loco_m@generic@reaction@pointing@unarmed@stand") do
                    Citizen.Wait(100)
                end
                TaskPlayAnim(PlayerPedId(), "mech_loco_m@generic@reaction@pointing@unarmed@stand", "point_fwd_0", 8.0, 8.0, 3000, 31, 0, true, 0, false, 0, false)
            end

            if IsControlPressed(0, 0x43CDA5B0) then -- U | Cancelar animação
                local ped = PlayerPedId()

                if not IsPlayerFreeAiming(ped) then
                    ClearPedTasks(ped)
                    ClearPedSecondaryTask(ped)
                    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
                end
            end
            --   if IsControlPressed(1, 0x4CC0E2FE) then -- B
            --     print("apertou")
            --     RequestAnimDict("script_hideout@six_point_cabin@rob_discuss")
            --     while not HasAnimDictLoaded("script_hideout@six_point_cabin@rob_discuss") do
            --         Citizen.Wait(100)
            --     end
            --     TaskPlayAnim(PlayerPedId(), "script_hideout@six_point_cabin@rob_discuss", "conversation_1_1_pedc", 8.0, 8.0, 3000, 31, 0, true, 0, false, 0, false)
            --   end
        end
    end
)

RegisterCommand(
    "clipset",
    function(source, args, rawCommand)
        N_0x03ddbf2d73799f9e("CLIPSET@MECH_GRAPPLE@UNARMED@_MALE@_AMBIENT@_HEALTHY@MOUNTED@INTIMIDATION@LOCO@ATTACKER")
        local retval, clipset = N_0x85b8f04555ab49b8("CLIPSET@MECH_GRAPPLE@UNARMED@_MALE@_AMBIENT@_HEALTHY@MOUNTED@INTIMIDATION@LOCO@ATTACKER")

        print(clipset)
    end
)

RegisterCommand(
    "c",
    function(source)
        local ped = PlayerPedId()
        if not IsPlayerFreeAiming(ped) then
            ClearPedTasks(ped)
            ClearPedSecondaryTask(ped)
            SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
        end
    end
)

-- Citizen.CreateThread(
--     function()
--         local ply = PlayerPedId()
--         local plyped = GetPlayerPed(ply)

--         while true do
--             Citizen.Wait(0)
--             if IsControlJustPressed(0, 0xD8F73058) then --[U]
--                 ClearPedTasks(ply)
--             end
--         end
--     end
-- )

RegisterCommand(
    "anotar",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_WRITE_NOTEBOOK"), 200000, false, false, false, false)
    end
)

-- RegisterCommand(
--     "bandana",
--     function(source, args, rawCommand)
--         RequestAnimDict("mech_inventory@equip_facemask@fallbacks")
--         while not HasAnimDictLoaded("mech_inventory@equip_facemask@fallbacks") do
--             Citizen.Wait(100)
--         end

--         TaskPlayAnim(PlayerPedId(), "mech_inventory@equip_facemask@fallbacks", "bandana_enter_r", 8.0, 8.0, 3000, 31, 0, true, 0, false, 0, false)
--     end
-- )

local Bandana = false
RegisterCommand(
    "bandana",
    function(source, args, rawCommand)
        RequestAnimDict("mech_inventory@clothing@bandana")
        while not HasAnimDictLoaded("mech_inventory@clothing@bandana") do
            Citizen.Wait(100)
        end
        if not cAPI.IsWanted() then
            if not Bandana then
                TaskPlayAnim(PlayerPedId(), "mech_inventory@clothing@bandana", "NECK_2_FACE_RH", 8.0, 8.0, 2300, 31, 0, true, 0, false, 0, false)
                Wait(2000)
                Citizen.InvokeNative(0x1902C4CFCC5BE57C, PlayerPedId(), 879715242)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
                Bandana = true
            else
                TaskPlayAnim(PlayerPedId(), "mech_inventory@clothing@bandana", "NECK_2_FACE", 8.0, 8.0, 2300, 31, 0, true, 0, false, 0, false)
                Wait(2000)
                Citizen.InvokeNative(0x1902C4CFCC5BE57C, PlayerPedId(), -972364774)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, false)
                Bandana = false
            end
        else
            TriggerEvent("FRP:NOTIFY:Simple", "Você ainda está como procurado, não pode retirar a bandana. ", 10000)
        end
    end
)

RegisterCommand(
    "avomitar",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_VOMIT"), 100000, true, false, false, false)
    end
)

RegisterCommand(
    "afumar",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_SMOKE"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "afumar2",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_SMOKE_CIGAR"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "afumar3",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_SMOKE_NERVOUS_STRESSED"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "afumar4",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_SMOKE_INTERACTION"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "afumar5",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_LEAN_RAILING_SMOKING"), 100000, true, false, false, false)
    end
)

RegisterCommand(
    "abeber",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_SIT_GROUND_DRINK_DRUNK"), 100000, true, false, false, false)
    end
)

RegisterCommand(
    "alerjornal",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_SIT_GROUND_READING_JOURNAL"), 100000, true, false, false, false)
    end
)

RegisterCommand(
    "awhisky",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_DRINK_FLASK"), 100000, true, false, false, false)
    end
)

RegisterCommand(
    "ataca",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_DRINK_CHAMPAGNE"), 100000, true, false, false, false)
    end
)

RegisterCommand(
    "acerveja",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_DRINKING_INTERACTION"), 100000, true, false, false, false)
    end
)

RegisterCommand(
    "awhisky2",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_DRINKING_DRUNK"), 100000, true, false, false, false)
    end
)

RegisterCommand(
    "ajanela",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_CLEAN_WINDOW"), 100000, true, false, false, false)
    end
)

RegisterCommand(
    "amesa",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_CLEAN_TABLE"), 100000, true, false, false, false)
    end
)

RegisterCommand(
    "apiano",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("PROP_HUMAN_PIANO_RIVERBOAT"), 100000, true, false, false, false)
    end
)

RegisterCommand(
    "adeitar",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_CAMP_JACK_ES_SLEEP"), 100000, true, false, false, false)
    end
)

RegisterCommand(
    "anim",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_TREE_CHOP_RAYFIRE"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "anim2",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("PROP_HUMAN_SEAT_CHAIR_FAN"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "asentar",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("GENERIC_SIT_GROUND_SCENARIO"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "asentar2",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("PROP_CAMP_FIRE_SEATED"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "asentar3",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_PLAYER_CAMP_FIRE_SIT"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "ainspecionar",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("MP_LOBBY_WORLD_HUMAN_CROUCH_INSPECT"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "ainspecionar2",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("MP_LOBBY_WORLD_HUMAN_CROUCH_INSPECT_MALE_A"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "astare",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("MP_LOBBY_WORLD_HUMAN_STARE_STOIC"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "adormir",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_SLEEP_GROUND_ARM"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "adormir2",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_SLEEP_GROUND_PILLOW"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "acintura",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_STERNGUY_IDLES"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "avarrer",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_STRAW_BROOM_WORKING"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "atrompete",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_TRUMPET"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "abalcao",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_VAL_BANKTELLER"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "aagachar",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_PLAYER_CAMP_FIRE_SQUAT"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "aencherbalde",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_PLAYER_CHORES_BUCKET_FILL"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "ajogaragua",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_PLAYER_CHORES_BUCKET_POUR_HIGH"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "alargarbalde",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_PLAYER_CHORES_BUCKET_PUT_DOWN_FULL"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "acomidadegalinha",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_PLAYER_CHORES_FEED_CHICKENS"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "atest",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_CONCERTINA_PICKUP_NO_CONCERTINA"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "aesperando",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_WAITING_IMPATIENT"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "aviolao2",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_SIT_GUITAR_DOWNBEAT"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "acafenochao",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_SIT_GROUND_COFFEE_DRINK"), -1, true, false, false, false)
    end
)

RegisterCommand(
    "anim3",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_FAN"), 100, true, false, false, false)
    end
)

RegisterCommand(
    "aviolao",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("PROP_HUMAN_SEAT_CHAIR_GUITAR"), 100000, true, false, false, false)
    end
)

RegisterCommand(
    "afeno",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_BALE_PUT_DOWN_1_MALE_A"), 100000, true, false, false, false)
    end
)

RegisterCommand(
    "aespelho",
    function(source, args, rawCommand)
        local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_POCKET_MIRROR"), 100000, true, false, false, false)
    end
)

RegisterCommand(
    "awhisky3",
    function(source, args)
        local propEntity = CreateObject(GetHashKey("p_bottleJD01x"), GetEntityCoords(PlayerPedId()), false, true, false, false, true)

        local task = TaskItemInteraction_2(PlayerPedId(), -1199896558, propEntity, GetHashKey("ID_PH_R_HAND"), GetHashKey("EAT_STEW_BOWL_TABLE_BASE"), 1, 0, -1.0)
        local istask = Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, PlayerPedId())
        print(istask)
    end
)

RegisterCommand(
    "achamps",
    function(source, args)
        local propEntity = CreateObject(GetHashKey("p_glass001x"), GetEntityCoords(PlayerPedId()), false, true, false, false, true)

        TaskItemInteraction_2(PlayerPedId(), -1199896558, propEntity, GetHashKey("p_glass001x_PH_R_HAND"), GetHashKey("DRINK_CHAMPAGNE_HOLD"), 1, 0, -1.0)
    end
)
RegisterCommand(
    "acerveja2",
    function(source, args)
        local propEntity = CreateObject(GetHashKey("p_bottleBeer01a"), GetEntityCoords(PlayerPedId()), false, true, false, false, true)

        local task = TaskItemInteraction_2(PlayerPedId(), -1199896558, propEntity, GetHashKey("p_bottleBeer01x_PH_R_HAND"), GetHashKey("DRINK_BOTTLE@Bottle_Cylinder_D1-55_H18_Neck_A8_B1-8_TABLE_HOLD"), 1, 0, -1.0)
    end
)

RegisterCommand(
    "acafe",
    function(source, args)
        local propEntity = CreateObject(GetHashKey("p_mugCoffee01x"), GetEntityCoords(PlayerPedId()), false, true, false, false, true)

        local task = TaskItemInteraction_2(PlayerPedId(), -1199896558, propEntity, GetHashKey("p_mugCoffee01x_ph_r_hand"), GetHashKey("DRINK_COFFEE_HOLD"), 1, 0, -1.0)
    end
)

RegisterCommand(
    "acomida",
    function(source, args)
        local bowl = CreateObject("p_bowl04x_stew", GetEntityCoords(PlayerPedId()), true, true, false, false, true)
        local spoon = CreateObject("p_spoon01x", GetEntityCoords(PlayerPedId()), true, true, false, false, true)

        Citizen.InvokeNative(0x669655FFB29EF1A9, bowl, 0, "Stew_Fill", 1.0)
        Citizen.InvokeNative(0xCAAF2BCCFEF37F77, bowl, 20)

        Citizen.InvokeNative(0xCAAF2BCCFEF37F77, spoon, 82)

        TaskItemInteraction_2(PlayerPedId(), 599184882, bowl, GetHashKey("p_bowl04x_stew_ph_l_hand"), -583731576, 1, 0, -1.0)
        TaskItemInteraction_2(PlayerPedId(), 599184882, spoon, GetHashKey("p_spoon01x_ph_r_hand"), -583731576, 1, 0, -1.0)

        Citizen.InvokeNative(0xB35370D5353995CB, PlayerPedId(), -583731576, 1.0)
    end
)

RegisterCommand(
    "afeno2",
    function(source, args, rawCommand)
        local model = "p_haybale03x"
        if IsModelValid(model) then
            if not HasModelLoaded(model) then
                RequestModel(model)
                while not HasModelLoaded(model) do
                    Citizen.Wait(10)
                end
            end
        end

        local coords = GetEntityCoords(PlayerPedId()) + (GetEntityForwardVector(PlayerPedId()) * 0.7)
        local object = CreateObject(model, coords, true, true, false, false, true)
        PlaceObjectOnGroundProperly(object)

        Citizen.InvokeNative(0x3BBDD6143FF16F98, PlayerPedId(), object, "p_hayBale03x_PH_R_HAND", "WORLD_HUMAN_COTTONBALE_PICKUP_2", 0, 0)
    end
)

local prompts = {}

local controlsorder = {
    -- 0x5966D52A,
    -- 0xB73BCA77,
    -- 0xCEFD9220,
    -- 0x760A9C6F,
    -- 0x760A9C6F,
    0x05CA7C52,
    0x6319DB71,
    0xA65EBAB4,
    0xDEB34313
    -- 0x760A9C6F J
    ---
    -- 0x13C42BB2,
    -- 0x470DC190,
    -- 0x72BAD5AA,
    -- 0x661857B3,
    -- 0xF311100C,
    -- 0x04FB8191
}

local groups = {
    {
        -- name = "Emotes",
        actions = {
            {"Acenar", -339257980},
            {"Tirar o Chapéu", -1457020913},
            {"Acenar com a Cabeça", -822629770},
            {"Cuspir", -2106738342}
        }
        -- prompt_group
    },
    {
        -- name = "Emotes",
        actions = {
            {"Siga-me", 1115379199},
            {"HissyFit", 796723886},
            {"Apontar", 486225122},
            {"Mandar Biejo", 1927505461}
        }
        -- prompt_group
    }
    -- {
    --     -- name = "Emotes",
    --     actions = {
    --         {"LetsGo", 1593752891},
    --         {"PlaySomeCards", -843470756},
    --         {"LookToDistance", 935157006},
    --         {"LookYonder", 7918540}
    --     }
    --     -- prompt_group
    -- },
    -- {
    --     -- name = "Emotes",
    --     actions = {
    --         {"WannaFish", 1159716480},
    --         {"Boast", -1252070669},
    --         {"HellYeah ", -402959},
    --         {"Flex", -773960361}
    --     }
    --     -- prompt_group
    -- }
}

function init()
    for groupIndex, v in pairs(groups) do
        -- local name = v.name
        local actions = v.actions

        -- v.name = CreateVarString(10, "LITERAL_STRING", name)

        local prompt_group = GetRandomIntInRange(0, 0xffffff)
        groups[groupIndex].prompt_group = prompt_group

        nextpreviouspromptsforgroup(groupIndex, prompt_group)

        for index, av in pairs(actions) do
            local actionName = av[1]
            -- local action = av[2]

            local controlAtIndex = controlsorder[index]

            prompt = PromptRegisterBegin()
            PromptSetControlAction(prompt, controlAtIndex)
            PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", actionName))
            PromptSetEnabled(prompt, 1)
            PromptSetVisible(prompt, 1)
            PromptSetStandardMode(prompt, 1)
            PromptSetGroup(prompt, prompt_group)
            PromptRegisterEnd(prompt)

            table.insert(prompts, prompt)

            Citizen.Wait(50)
        end
    end
end

function nextpreviouspromptsforgroup(groupIndex, group)
    local prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, 0x07CE1E61)
    if groupIndex > 1 then
        PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "voltar"))
    else
        PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "fechar"))
    end
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetStandardMode(prompt, true)
    PromptSetGroup(prompt, group)

    PromptRegisterEnd(prompt)
    table.insert(prompts, prompt)

    if groupIndex < #groups then
        local prompt = PromptRegisterBegin()
        PromptSetControlAction(prompt, 0xF84FA74F)
        PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "proximo"))
        PromptSetEnabled(prompt, true)
        PromptSetVisible(prompt, true)
        PromptSetStandardMode(prompt, true)
        PromptSetGroup(prompt, group)
        PromptRegisterEnd(prompt)

        table.insert(prompts, prompt)
    end
end

Citizen.CreateThread(
    function()
        init()

        local activeGroupIndex = 0

        while true do
            Citizen.Wait(0)

            if activeGroupIndex == 0 then
                if IsControlJustPressed(0, 0x760A9C6F) then -- G
                    activeGroupIndex = 1
                end
            else
                -- PromptSetActiveGroupThisFrame(groups[activeGroupIndex].prompt_group, groups[activeGroupIndex].name)
                PromptSetActiveGroupThisFrame(groups[activeGroupIndex].prompt_group, CreateVarString(10, "LITERAL_STRING", "Emotes " .. activeGroupIndex .. "/" .. #groups))

                disablecontrols()

                if IsControlJustPressed(0, 0x760A9C6F) then -- G
                    activeGroupIndex = 0
                end

                if IsControlJustPressed(0, 0x07CE1E61) then
                    if NativeUipromptIsControlActionActive(0x07CE1E61) then
                        if activeGroupIndex > 1 then
                            activeGroupIndex = activeGroupIndex - 1
                        else
                            activeGroupIndex = 0
                        end
                    end
                end

                if IsControlJustPressed(0, 0xF84FA74F) then
                    if NativeUipromptIsControlActionActive(0xF84FA74F) then
                        -- if activeGroupIndex < #groups then
                        activeGroupIndex = activeGroupIndex + 1
                    -- else
                    --     activeGroupIndex = 1
                    -- end
                    end
                end

                for index, control in pairs(controlsorder) do
                    if IsControlJustPressed(0, control) then
                        if NativeUipromptIsControlActionActive(control) then
                            -- print(groups[activeGroupIndex].actions[index][2])
                            local emoteHash = groups[activeGroupIndex].actions[index][2]
                            Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, emoteHash, 1, 1, 0, 0)
                        end
                    end
                end
            end
        end
    end
)

function disablecontrols()
    DisableControlAction(0, 0xF8982F00, true)
end

function NativeUipromptIsControlActionActive(control)
    return Citizen.InvokeNative(0x1BE19185B8AFE299, control)
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if GetCurrentResourceName() == resourceName or resourceName == "_core" then
            for _, prompt in pairs(prompts) do
                PromptDelete(prompt)
            end
        end
    end
)
