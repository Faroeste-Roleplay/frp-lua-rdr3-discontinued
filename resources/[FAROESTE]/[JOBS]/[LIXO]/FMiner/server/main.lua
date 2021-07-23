local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local Loot = {
    {item = "raw_iron", amountToGive = math.random(1, 2)},
    {item = "raw_coal", amountToGive = math.random(1, 2)},
    {item = "raw_copper", amountToGive = math.random(1, 2)}
    -- {item = "raw_gold", amountToGive = math.random(1, 2)}
}

-- local LootRare = {
--     {item = "coal", amountToGive = math.random(2, 4)},
--     {item = "quartz", amountToGive = math.random(1, 3)},
--     {item = "emerald", amountToGive = math.random(1, 3)},
--     {item = "diamond", amountToGive = math.random(1, 2)}
-- }

RegisterServerEvent("FF_MinerJob:sdfjds8ufh")
AddEventHandler(
    "FF_MinerJob:sdfjds8ufh",
    function()
        local _source = source

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if Character == nil then
            return
        end

        local Inventory = Character:getInventory()

        local FinalLoot = LootToGive()

        for k, v in pairs(Loot) do
            if v.item == FinalLoot then
                if Inventory:addItem(FinalLoot, v.amountToGive) then
                    User:notify("item", FinalLoot, v.amountToGive)
                    Character:varyExp(0.5)
                else
                    User:notify("error", "Aforje sem espaço!")
                end
                break
            end
        end
    end
)

function LootToGive(HasRares) -- kek
    local LootsToGive = {}
    local LootsToGiveR = {}
    for k, v in pairs(Loot) do
        table.insert(LootsToGive, v.item)
    end

    if LootsToGive[1] ~= nil then
        local value = math.random(1, #LootsToGive)
        local picked = LootsToGive[value]
        return picked
    elseif LootsToGiveR[1] ~= nil then
        local value = math.random(1, #LootsToGiveR)
        local picked = LootsToGiveR[value]
        return picked
    end
end
