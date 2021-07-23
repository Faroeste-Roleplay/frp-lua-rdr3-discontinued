Citizen.CreateThread(
    function()
        -- WBTOCOMPOSITE()
        -- WBTOCOMPOSITEARRAY()
        -- OPENIVTOWB()

        ReadHerbFile("herbs_bay.txt")
        ReadHerbFile("herbs_bgv.txt")
        ReadHerbFile("herbs_cho.txt")
        ReadHerbFile("herbs_cml.txt")
        ReadHerbFile("herbs_gap.txt")
        ReadHerbFile("herbs_grt.txt")
        ReadHerbFile("herbs_gze.txt")
        ReadHerbFile("herbs_gzw.txt")
        ReadHerbFile("herbs_hen.txt")
        ReadHerbFile("herbs_hrt.txt")
        ReadHerbFile("herbs_rio.txt")
        ReadHerbFile("herbs_roa.txt")
        ReadHerbFile("herbs_scm.txt")
        ReadHerbFile("herbs_tal.txt")
        -- HerbVectorsToFile()
        HerbVectorsToFile2()
    end
)

local ArrayWbToComposite = {
    ["WB_HERB_ALASKAN_GINSENG"] = "COMPOSITE_LOOTABLE_ALASKAN_GINSENG_ROOT_DEF",
    ["WB_HERB_AMERICAN_GINSENG"] = "COMPOSITE_LOOTABLE_AMERICAN_GINSENG_ROOT_DEF",
    ["WB_HERB_BLACK_CURRANT"] = "COMPOSITE_LOOTABLE_BLACK_CURRANT_DEF",
    ["WB_HERB_BURDOCK_ROOT"] = "COMPOSITE_LOOTABLE_BURDOCK_ROOT_DEF",
    ["WB_HERB_BURDOCK_ROOT_SINGLE"] = "COMPOSITE_LOOTABLE_BURDOCK_ROOT_DEF",
    ["WB_HERB_DESERT_SAGE"] = "COMPOSITE_LOOTABLE_DESERT_SAGE_DEF",
    ["WB_HERB_ENGLISH_MACE"] = "COMPOSITE_LOOTABLE_ENGLISH_MACE_DEF",
    ["WB_HERB_ENGLISH_MACE_SINGLE"] = "COMPOSITE_LOOTABLE_ENGLISH_MACE_DEF",
    ["WB_HERB_GOLDEN_CURRANT"] = "COMPOSITE_LOOTABLE_GOLDEN_CURRANT_DEF",
    ["WB_HERB_HUMMINGBIRD_SAGE"] = "COMPOSITE_LOOTABLE_HUMMINGBIRD_SAGE_DEF",
    ["WB_HERB_INDIAN_TOBACCO"] = "COMPOSITE_LOOTABLE_INDIAN_TOBACCO_DEF",
    ["WB_HERB_MILKWEED"] = "COMPOSITE_LOOTABLE_MILKWEED_DEF",
    ["WB_HERB_MILKWEED_SINGLE"] = "COMPOSITE_LOOTABLE_MILKWEED_DEF",
    ["WB_HERB_OLEANDER_SAGE"] = "COMPOSITE_LOOTABLE_OLEANDER_SAGE_DEF",
    ["WB_HERB_PRAIRIE_POPPY"] = "COMPOSITE_LOOTABLE_PRAIRIE_POPPY_DEF",
    ["WB_HERB_RED_SAGE"] = "COMPOSITE_LOOTABLE_RED_SAGE_DEF",
    ["WB_HERB_VANILLA_FLOWER"] = "COMPOSITE_LOOTABLE_ORCHID_VANILLA_DEF",
    ["WB_HERB_VIOLET_SNOWDROP"] = "COMPOSITE_LOOTABLE_VIOLET_SNOWDROP_DEF",
    ["WB_HERB_WILD_FEVERFEW"] = "COMPOSITE_LOOTABLE_WILD_FEVERFEW_DEF",
    ["WB_HERB_YARROW"] = "COMPOSITE_LOOTABLE_YARROW_DEF",
    ["WB_HERB_YARROW_SINGLE"] = "COMPOSITE_LOOTABLE_YARROW_DEF",
    ["WB_HORSE_HERB_COMMON_BULRUSH"] = "COMPOSITE_LOOTABLE_COMMON_BULRUSH_DEF",
    ["WB_HORSE_HERB_WILD_CARROTS"] = "COMPOSITE_LOOTABLE_WILD_CARROT_DEF",
    ["WB_FLOWER_AGARITA"] = "COMPOSITE_LOOTABLE_AGARITA_DEF",
    ["WB_FLOWER_AGARITA_SINGLE"] = "COMPOSITE_LOOTABLE_AGARITA_DEF",
    ["WB_FLOWER_BITTERWEED"] = "COMPOSITE_LOOTABLE_BITTERWEED_DEF",
    ["WB_FLOWER_BITTERWEED_SINGLE"] = "COMPOSITE_LOOTABLE_BITTERWEED_DEF",
    ["WB_FLOWER_BLOOD_FLOWER"] = "COMPOSITE_LOOTABLE_BLOODFLOWER_DEF",
    ["WB_FLOWER_BLOOD_FLOWER_SINGLE"] = "COMPOSITE_LOOTABLE_BLOODFLOWER_DEF",
    ["WB_FLOWER_CARDINAL_FLOWER"] = "COMPOSITE_LOOTABLE_CARDINAL_FLOWER_DEF",
    ["WB_FLOWER_CARDINAL_FLOWER_SINGLE"] = "COMPOSITE_LOOTABLE_CARDINAL_FLOWER_DEF",
    ["WB_FLOWER_CHOCOLATE_DAISY"] = "COMPOSITE_LOOTABLE_CHOC_DAISY_DEF",
    ["WB_FLOWER_CHOCOLATE_DAISY_SINGLE"] = "COMPOSITE_LOOTABLE_CHOC_DAISY_DEF",
    ["WB_FLOWER_CREEK_PLUM"] = "COMPOSITE_LOOTABLE_CREEKPLUM_DEF",
    ["WB_FLOWER_CREEK_PLUM_SINGLE"] = "COMPOSITE_LOOTABLE_CREEKPLUM_DEF",
    ["WB_FLOWER_TEXAS_BLUE_BONNET"] = "COMPOSITE_LOOTABLE_TEXAS_BONNET_DEF",
    ["WB_FLOWER_TEXAS_BLUE_BONNET_SINGLE"] = "COMPOSITE_LOOTABLE_TEXAS_BONNET_DEF",
    ["WB_FLOWER_WILD_RHUBARB"] = "COMPOSITE_LOOTABLE_WILD_RHUBARB_DEF",
    ["WB_FLOWER_WILD_RHUBARB_SINGLE"] = "COMPOSITE_LOOTABLE_WILD_RHUBARB_DEF",
    ["WB_FLOWER_WISTERIA"] = "COMPOSITE_LOOTABLE_WISTERIA_DEF",
    ["WB_FLOWER_WISTERIA_SINGLE"] = "COMPOSITE_LOOTABLE_WISTERIA_DEF",
    ["WB_MUSHROOM_BAY_BOLETE"] = "COMPOSITE_LOOTABLE_BAY_BOLETE_DEF",
    ["WB_MUSHROOM_CHANTERELLES"] = "COMPOSITE_LOOTABLE_CHANTERELLES_DEF",
    ["WB_MUSHROOM_PARASOL_MUSHROOM"] = "COMPOSITE_LOOTABLE_PARASOL_MUSHROOM_DEF",
    ["WB_MUSHROOM_RAMS_HEAD"] = "COMPOSITE_LOOTABLE_RAMS_HEAD_DEF",
    ["WB_BERRY_BLACK_BERRY"] = "COMPOSITE_LOOTABLE_BLACK_BERRY_DEF",
    ["WB_BERRY_EVERGREEN_HUCKLEBERRY"] = "COMPOSITE_LOOTABLE_EVERGREEN_HUCKLEBERRY_DEF",
    ["WB_BERRY_RED_RASPBERRY"] = "COMPOSITE_LOOTABLE_RED_RASPBERRY_DEF",
    ["WB_BERRY_WINTERGREEN_BERRY"] = "COMPOSITE_LOOTABLE_WINTERGREEN_BERRY_DEF",
    ["WB_SPICE_CREEPING_THYME"] = "COMPOSITE_LOOTABLE_CREEPING_THYME_DEF",
    ["WB_SPICE_OREGANO"] = "COMPOSITE_LOOTABLE_OREGANO_DEF",
    ["WB_SPICE_WILD_MINT"] = "COMPOSITE_LOOTABLE_WILD_MINT_DEF",
    ["WB_ORCHID_ACUNAS_STAR"] = "COMPOSITE_LOOTABLE_ORCHID_ACUNA_STAR_DEF",
    ["WB_ORCHID_CIGAR"] = "COMPOSITE_LOOTABLE_ORCHID_CIGAR_DEF",
    ["WB_ORCHID_CLAMSHELL"] = "COMPOSITE_LOOTABLE_ORCHID_CLAM_SHELL_DEF",
    ["WB_ORCHID_DRAGONS_MOUTH"] = "COMPOSITE_LOOTABLE_ORCHID_DRAGONS_DEF",
    ["WB_ORCHID_GHOST"] = "COMPOSITE_LOOTABLE_ORCHID_GHOST_DEF",
    ["WB_ORCHID_LADY_OF_NIGHT"] = "COMPOSITE_LOOTABLE_ORCHID_LADY_NIGHT_DEF",
    ["WB_ORCHID_LADY_SLIPPER"] = "COMPOSITE_LOOTABLE_ORCHID_LADY_SLIPPER_DEF",
    ["WB_ORCHID_MOCCASIN_FLOWER"] = "COMPOSITE_LOOTABLE_ORCHID_MOCCASIN_DEF",
    ["WB_ORCHID_NIGHT_SCENTED"] = "COMPOSITE_LOOTABLE_ORCHID_NIGHT_SCENTED_DEF",
    ["WB_ORCHID_QUEENS"] = "COMPOSITE_LOOTABLE_ORCHID_QUEENS_DEF",
    ["WB_ORCHID_RAT_TAIL"] = "COMPOSITE_LOOTABLE_ORCHID_RAT_TAIL_DEF",
    ["WB_ORCHID_SPARROWS_EGG"] = "COMPOSITE_LOOTABLE_ORCHID_SPARROWS_DEF",
    ["WB_ORCHID_SPIDER"] = "COMPOSITE_LOOTABLE_ORCHID_SPIDER_DEF"
}

function ConvertHashToWb(Hash)
    Hash = tonumber(Hash)

    for wbAsString, _ in pairs(ArrayWbToComposite) do
        if GetHashKey(wbAsString) == Hash then
            return wbAsString
        end
    end
end

function ConvertWbToComposite(Wb)
    return ArrayWbToComposite[Wb]
end

local ArrayHerbFileVectors = {}

function ReadHerbFile(fileName)
    local file = io.open(fileName, "r")

    local lastHash


    for line in file:lines() do
        local Hash = line:match("<ScenarioType>(.-)</ScenarioType>")

        if Hash ~= nil then

            -- if Hash == "0x43B5F53E" then
            --     print("found", Hash, tonumber(Hash), GetHashKey("WB_HERB_ALASKAN_GINSENG"))
            -- end

            local Wb = ConvertHashToWb(Hash)
            if Wb ~= nil then
                local Composite = ConvertWbToComposite(Wb)

                -- print(Hash, Wb, Composite)

                if ArrayHerbFileVectors[Composite] == nil then
                    ArrayHerbFileVectors[Composite] = {}
                end

                lastHash = Hash
            else
                lastHash = nil
            end
        else
            local x, y, z = line:match('<UNK_MEMBER_0x00477CED x="(.-)" y="(.-)" z="(.-)"')
            if x ~= nil and y ~= nil and z ~= nil then
                if lastHash ~= nil then
                    local Wb = ConvertHashToWb(lastHash)
                    local Composite = ConvertWbToComposite(Wb)

                    table.insert(ArrayHerbFileVectors[Composite], {x, y, z})
                end
            end
        end
    end

    io.close(file)
end

function HerbVectorsToFile()
    local file = io.open("vectors.txt", "a")

    file:write("CompositeVectors = {")
    file:write("\n")
    for Composite, v in pairs(ArrayHerbFileVectors) do
        file:write('    ["' .. Composite .. '"] = {')
        file:write("\n")
        for _, vec in pairs(v) do
            local x, y, z = table.unpack(vec)
            file:write("        vec3(" .. x .. ", " .. y .. ", " .. z .. "),")
            file:write("\n")
        end
        file:write("    },")
        file:write("\n")
    end
    file:write("}")
    file:write("\n")

    io.close(file)
end

function HerbVectorsToFile2()
    local file = io.open("vectors2.txt", "a")

    file:write("local CompositeVectors2 = {")
    file:write("\n")
    for Composite, v in pairs(ArrayHerbFileVectors) do
        file:write("    {")
        file:write("\n")
        file:write("        name = " .. '"' .. Composite .. '",')
        file:write("\n")
        file:write("        vectors = {")
        file:write("\n")
        for _, vec in pairs(v) do
            local x, y, z = table.unpack(vec)
            file:write("             vec3(" .. x .. ", " .. y .. ", " .. z .. "),")
            file:write("\n")
        end
        file:write("        }")
        file:write("\n")
        file:write("    },")
        file:write("\n")
    end
    file:write("}")
    file:write("\n")

    io.close(file)
end
