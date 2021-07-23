function API.ItemData(id, name, description, type, stackSize, weight)
    local self = {}

    self.id = id
    self.name = name
    self.description = description
    self.type = type
    self.stackSize = stackSize
    self.weight = weight

    self.getId = function()
        return self.id
    end

    self.getName = function(this)
        return self.name or "nome"
    end

    self.getDescription = function()
        return self.description or "descricao"
    end

    self.getType = function()
        return self.type or "generic"
    end

    self.getStackSize = function()
        return self.stackSize or 1
    end

    self.getWeight = function()
        return self.weight or 1
    end

    self.triggerUse = function(this, User)
        return triggerUse(User, self)
    end

    self.isMelee = function()
        return isMelee(self:getId())
    end

    self.isThrowable = function()
        return isThrowable(self:getId())
    end

    return self
end

-- self.getSlotType = function()
--     if self.type == "food" or self.type == "beverage" then
--         return "Food"
--     end

--     if self.type == "tonics" or self.type == "boost" then
--         return "Tonics"
--     end

--     if self.type == "weapon" or self.type == "ammo" then
--         return "Tools_Weapons"
--     end

--     -- local slotTypes = {
--     --     "Recents",
--     --     "Food",
--     --     "Tonics",
--     --     "Ingredients",
--     --     "Tools_Weapons",
--     --     "Kit",
--     --     "Valuables",
--     --     "Documents"
--     --     "Hotbar",
--     -- }
--     return "Food"

function triggerUse(User, itemData)
    local source = User:getSource()

    --[[
        return false    : Item não será consumido
        return true     : Item será consumido
    ]]

    if cAPI.getHealth(source) <= 0 or cAPI.IsPlayerLassoed(source) then
        return false
    end

    local itemId = itemData:getId()
    local itemType = itemData:getType()

    if itemType == "food" then
        local var = itemData.varOnUse

        API.varyHunger(source, var)

        return true
    end

    if itemType == "beverage" then
        local var = itemData.varOnUse

        API.varyThirst(source, var)

        return true
    end

    if itemId == "opio" then
        local var = itemData.varOnUse
        cAPI.OpioUse(source, var)
        return true
    end

    if itemId:find("medicine") then
        -- medicine_good
        if itemId:find("horse") then
            local variation = 15.0
            local variationCore = 15.0

            if itemId:find("poor") then
                variation = 5.0
                variationCore = 5.0
            end

            if cAPI.IsPlayerMountedOnOwnHorse(source) then
                Citizen.CreateThread(
                    function()
                        cAPI.TaskAnimalInteraction(source, "injection")
                        cAPI.VaryHorseHealth(source, variation)
                        cAPI.VaryHorseCore(source, 0, variationCore)
                    end
                )
                return true
            end
        else
            local variation = 25.0
            local variationCore = 25.0
            local variationSickness = 0

            if itemId:find("poor") then
                variation = 5.0
                variationCore = 5.0
                variationSickness = 15
            end

            cAPI.TaskInteraction(source, "drink_tonic")
            cAPI.VaryPlayerHealth(source, variation)
            cAPI.VaryPlayerCore(source, 0, variationCore)
            if variationSickness > 0 then
                cAPI.VarySickness(source, variationSickness)
            end

            return true
        end

        return false
    end

    if itemId:find("stimulant") then
        -- medicine_good
        if itemId:find("horse") then
            local variation = 15.0
            local variationCore = 15.0

            if itemId:find("poor") then
                variation = 5.0
                variationCore = 5.0
            end

            if cAPI.IsPlayerMountedOnOwnHorse(source) then
                cAPI.TaskAnimalInteraction(source, "injection")
                cAPI.VaryHorseStamina(source, variation)
                cAPI.VaryHorseCore(source, 1, variationCore)

                return true
            end
        else
            local variation = 25.0
            local variationCore = 25.0
            local variationSickness = 0

            if itemId:find("poor") then
                variation = 4.0
                variationCore = 5.0
                variationSickness = 15
            end

            cAPI.TaskInteraction(source, "injection")
            cAPI.VaryPlayerStamina(source, variation)
            cAPI.VaryPlayerCore(source, 1, variationCore)
            if variationSickness > 0 then
                cAPI.VarySickness(source, variationSickness)
            end

            return true
        end

        return false
    end

    if itemId == "waterbottle" then
        cAPI.VaryPlayerStamina(source, 50)
        return true
    end

    if itemId == "pigeonpost" then
        TriggerEvent("FRP:PEAGLE:SendMessage", source)
    end

    if itemId == "chest_small" then
        local var = itemData.varOnUse
        TriggerEvent("FRP:CHESTS:StartPlayerPlacement", source, var)
        return true
    end

    if itemId:find("acamp") then
        local var = itemData.varOnUse
        TriggerClientEvent("FRP:TENTS:usedItem", source, var)
        User:closeInventory()
    end

    if itemId:find("_seed") then        
        TriggerClientEvent("FRP:FARM:StartPlacingSeed", source, itemId:sub(0, itemId:find("_") - 1))
        User:closeInventory()
        return false
    end
    
    if itemId == "p_baitBread01x" then
        TriggerClientEvent("redemrp_fishing:UseBait", source, itemId)
        User:closeInventory()
    end

    if itemId == "p_baitCheese01x" then
        TriggerClientEvent("redemrp_fishing:UseBait", source, itemId)
        User:closeInventory()
    end

    if itemId == "p_baitCricket01x" then
        TriggerClientEvent("redemrp_fishing:UseBait", source, itemId)
        User:closeInventory()
    end

    if itemId == "p_FinisdFishlure01x" then
        TriggerClientEvent("redemrp_fishing:UseBait", source, itemId)
        User:closeInventory()
    end

    if itemId == "p_finishdcrawd01x" then
        TriggerClientEvent("redemrp_fishing:UseBait", source, itemId)
        User:closeInventory()
    end

    if itemId == "pigeonpost" then
        TriggerClientEvent("FRP:PIGEONPOST:Init", source)
    end

    if itemId == "pan" then
        TriggerClientEvent("FrankieGoldPanner:StartGoldPan", source)
    end

    if itemId == "meat_cooked" then
        cAPI.VaryPlayerHealth(source, 15)
        -- cAPI.VaryPlayerStamina(source, 15)
        cAPI.VaryPlayerCore(source, 1, 20)
        cAPI.TaskScriptedAnim(source, "eat")

        cAPI.VarySickness(source, 10)

        User:closeInventory()
        return true
    end

    if itemId == "meat_oregano_cooked" then
        cAPI.VaryPlayerHealth(source, 30)
        -- cAPI.VaryPlayerStamina(source, 30)
        cAPI.VaryPlayerCore(source, 1, 70)
        cAPI.TaskScriptedAnim(source, "eat")
        API.varyHunger(source, tonumber(-20))
        cAPI.VarySickness(source, 10)

        User:closeInventory()
        return true
    end

    if itemId == "eagleeye" then
        cAPI.TaskInteraction(source, "drink_tonic")
        TriggerClientEvent("FRP:WANTED:UsedEagleEye", source)

        return true
    end

    if itemId == "lockpick" then
        User:closeInventory()
        TriggerClientEvent("FRP:LOCKPICK:StartLockpicking", source)
    end

    return false
end

local melee = {
    "lasso",
    "melee_lantern_electric",
    "melee_torch",
    "melee_broken_sword",
    "fishingrod",
    "melee_knife_john",
    "melee_knife",
    "melee_knife_bear",
    "melee_cleaver",
    "melee_ancient_hatchet",
    "melee_knife_jawbone",
    "melee_knife_hunter",
    "melee_knife_miner",
    "melee_machete"
}

local throwable = {
    "thrown_ancient_tomahawk",
    "thrown_dynamite",
    "thrown_molotov",
    "thrown_throwing_knives",
    "thrown_throwing_knives_improved",
    "melee_hatchet",
    "melee_hatchet_viking",
    "melee_hatchet_hewing",
    "melee_hatchet_double_bit",
    "melee_hatchet_double_bit_rusted",
    "melee_hatchet_hunter",
    "melee_hatchet_hunter_rusted"
}

function isMelee(itemId)
    -- itemId = 'weapon_' .. itemId

    for _, col in pairs(melee) do
        if itemId == col then
            return true
        end
    end

    return false
end

function isThrowable(itemId)
    -- itemId = 'weapon_' .. itemId

    for _, col in pairs(throwable) do
        if itemId == col then
            return true
        end
    end

    return false
end
