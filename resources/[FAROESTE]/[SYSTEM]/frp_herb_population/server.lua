local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local toItem = {
    "AGARITA_DEF",
    ["ALASKAN_GINSENG_ROOT_DEF"] = "herb_alaskan_ginseng",
    ["AMERICAN_GINSENG_ROOT_DEF"] = "herb_american_ginseng",
    "BAY_BOLETE_DEF",
    "BITTERWEED_DEF",
    -- "BITTERWEED_INTERACTABLE_DEF",
    ["BLACK_BERRY_DEF"] = "herb_black_berry",
    ["BLACK_CURRANT_DEF"] = "herb_black_current",
    "BLOODFLOWER_DEF",
    -- "BLOODFLOWER_INTERACTABLE_DEF",
    ["BURDOCK_ROOT_DEF"] = "herb_burdock_root",
    "CARDINAL_FLOWER_DEF",
    -- "CARDINAL_FLOWER_INTERACTABLE_DEF",
    "CHANTERELLES_DEF",
    "CHOC_DAISY_DEF",
    -- "CHOC_DAISY_INTERACTABLE_DEF",
    ["COMMON_BULRUSH_DEF"] = "herb_common_bullrush",
    "CREEKPLUM_DEF",
    "CREEPING_THYME_DEF",
    ["DESERT_SAGE_DEF"] = "herb_desert_sage",
    "DUCK_EGG_5_DEF",
    "ENGLISH_MACE_DEF",
    "EVERGREEN_HUCKLEBERRY_DEF",
    "GOLDEN_CURRANT_DEF",
    "GOOSE_EGG_4_DEF",
    "HUMMINGBIRD_SAGE_DEF",
    "INDIAN_TOBACCO_DEF",
    "LOON_EGG_3_DEF",
    "MILKWEED_DEF",
    ["OLEANDER_SAGE_DEF"] = "herb_oleander_sage", -- 
    "ORCHID_ACUNA_STAR_DEF",
    "ORCHID_CIGAR_DEF",
    "ORCHID_CLAM_SHELL_DEF",
    "ORCHID_DRAGONS_DEF",
    "ORCHID_GHOST_DEF",
    "ORCHID_LADY_NIGHT_DEF",
    ["ORCHID_LADY_SLIPPER_DEF"] = "herb_lady_slipper",
    "ORCHID_MOCCASIN_DEF",
    "ORCHID_NIGHT_SCENTED_DEF",
    "ORCHID_QUEENS_DEF",
    "ORCHID_RAT_TAIL_DEF",
    "ORCHID_SPARROWS_DEF",
    "ORCHID_SPIDER_DEF",
    "ORCHID_VANILLA_DEF",
    ["OREGANO_DEF"] = "herb_oregano",
    ["PARASOL_MUSHROOM_DEF"] = "herb_parasol_mushroom",
    ["PRAIRIE_POPPY_DEF"] = "herb_prairie_poppy", -- 
    ["RAMS_HEAD_DEF"] = "herb_rams_head", -- opio
    "RED_RASPBERRY_DEF",
    ["RED_SAGE_DEF"] = "herb_red_sage",
    "TEXAS_BONNET_DEF",
    -- "TEXAS_BONNET_INTERACTABLE_DEF",
    "VIOLET_SNOWDROP_DEF",
    "VULTURE_EGG_DEF",
    ["WILD_CARROT_DEF"] = "herb_wild_carrot",
    ["WILD_FEVERFEW_DEF"] = "herb_wild_feverfew",
    ["WILD_MINT_DEF"] = "herb_wild_mint",
    "WILD_RHUBARB_DEF",
    -- "WILD_RHUBARB_INTERACTABLE_DEF",
    "WINTERGREEN_BERRY_DEF",
    "WISTERIA_DEF",
    "YARROW_DEF"
}

local SUPPRESSION_WEAROFF_SECONDS = 10 * 60

local popSuppressed = {}

RegisterNetEvent("FRP:HERB_POPULATION:Gathered")
AddEventHandler(
    "FRP:HERB_POPULATION:Gathered",
    function(compositeTypeFormatted, indexComposite, index)
        local _source = source
        if not IsVectorIndexSuppressed(indexComposite, index) then
            local item = toItem[compositeTypeFormatted]
            if item ~= nil then
                local User = API.getUserFromSource(_source)
                local Character = User:getCharacter()

                if Character == nil then
                    return
                end

                local Inventory = Character:getInventory()

                if Inventory:addItem(item, 1) then
                    SetVectorIndexSuppressed(indexComposite, index, true)

                    if not User:hasInventoryOpen() then
                        User:notify("item", item, 1)
                    end

                    Character:varyExp(2)
                    User:notify("xp", 2)
                else
                    User:notify("error", "Sem espaço no aforje!")
                    TriggerClientEvent("FRP:HERB_POPULATION:ForceVectorIndexReload", _source, indexComposite, index)
                end
            end
        end
    end
)

function IsVectorIndexSuppressed(indexComposite, index)
    return popSuppressed[indexComposite] ~= nil and popSuppressed[indexComposite][index] ~= nil or false
end

function SetVectorIndexSuppressed(indexComposite, index, suppress)
    if suppress then
        -- end
        -- if not IsVectorIndexSuppressed(indexComposite, index) then
        if popSuppressed[indexComposite] == nil then
            popSuppressed[indexComposite] = {}
        end

        popSuppressed[indexComposite][index] = os.time() + SUPPRESSION_WEAROFF_SECONDS
    else
        -- end
        -- if IsVectorIndexSuppressed(indexComposite, index) then
        popSuppressed[indexComposite][index] = nil
    end

    TriggerClientEvent("FRP:HERB_POPULATION:SetVectorIndexSuppressed", -1, indexComposite, index, suppress)
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1 * 60 * 1000) -- 1 Min

            local timestamp = os.time()

            for indexComposite, v in pairs(popSuppressed) do
                for index, suppression_wearoff_timestamp in pairs(v) do
                    if suppression_wearoff_timestamp <= timestamp then
                        SetVectorIndexSuppressed(indexComposite, index, false)
                    end
                end
            end
        end
    end
)

RegisterNetEvent("API:playerSpawned")
AddEventHandler(
    "API:playerSpawned",
    function(source, user_id, isFirstSpawn)
        if isFirstSpawn then
            TriggerClientEvent("FRP:HERB_POPULATION:SetPopSuppressed", source, popSuppressed)
        end
    end
)
