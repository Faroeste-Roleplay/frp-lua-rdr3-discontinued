local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local verificationData = {
    -- min_level, price_dollar, price_gold
    ["revolver_lemat"] = {0, 31700, 1300},
    ["revolver_cattleman"] = {0, 5000, 200},
    -- ["revolver_navy"] = {0, 257, 11},
    ["pistol_volcanic"] = {0, 30000, 1400},
    ["shotgun_sawedoff"] = {0, 6500, 1500},
    ["repeater_carbine"] = {0, 9000, 400},
    ["repeater_henry"] = {0, 23400, 1000},
    ["sniperrifle_rollingblock"] = {0, 50000, 2000},
    ["rifle_varmint"] = {0, 7200, 300},
    ["rifle_boltaction"] = {0, 21600, 900},
    -- AMMO
    ["ammo_revolver"] = {0, 200, 100, 20},
    ["ammo_pistol"] = {0, 200, 100, 20},
    ["ammo_repeater"] = {0, 200, 100, 20},
    ["ammo_rifle"] = {0, 200, 100, 20},
    ["ammo_shotgun"] = {0, 200, 100, 20},
    ["ammo_22"] = {0, 200, 100, 20},
}

-- ["revolver_lemat"] = {1, 7, 317, 13},
-- ["revolver_cattleman"] = {1, 1, 50, 2},
-- ["REVOLVER_NAVY"] = {1, 5, 257, 11},
-- -- PISTOL
-- ["pistol_volcanic"] = {1, 24, 300, 14},
-- --shotgun
-- ["shotgun_sawedoff"] = {1, 5, 111, 13},
-- -- repeater
-- ["repeater_carbine"] = {1, 2, 90, 4},
-- ["repeater_henry"] = {1, 17, 234, 10},
-- -- precision rifle
-- ["sniperrifle_rollingblock"] = {1, 15, 500, 20},
-- -- MELEE
-- --  ["BOLAS"] = {1, 1, 30, 2},
-- ["thrown_throwing_knives"] = {1, 1, 2.5, 0.5},
-- ["melee_cleaver"] = {1, 5, 8, 1},
-- ["melee_knife"] = {1, 1, 0.5, 0.1},
-- -- manual rifle
-- ["rifle_varmint"] = {1, 7, 72, 3},
-- ["rifle_boltaction"] = {1, 9, 216, 9},

RegisterNetEvent("FRP:GUNSMITH:TryToBuy")
AddEventHandler(
    "FRP:GUNSMITH:TryToBuy",
    function(itemId, withGold)
        local _source = source

        if not verificationData[itemId] then
            return
        end

        local User = API.getUserFromSource(_source)
        local Character = User.getCharacter()

        local itemData = verificationData[itemId]
        local itemLevel = itemData[1]

        if Character:getLevel() < itemLevel then
            User:notify("error", "Você não tem level suficiente")
            return
        end

        local Inventory = Character:getInventory()

        local currencyItem = "money"
        local itemPrice = itemData[2]

        if withGold then
            currencyItem = "gold"
            itemPrice = itemData[3]
        end

        if Inventory:getItemAmount(currencyItem) < itemPrice then
            User:notify("error", "Você não tem dinheiro suficiente")
            return
        end

        local itemAmount = itemData[4] or 1

        if Inventory:addItem(itemId, itemAmount) then
            Inventory:removeItem(-1, currencyItem, itemPrice)
            if itemPrice > 0 then
                if not withGold then
                    User:notify("item", "money", -(itemPrice))
                else
                    User:notify("item", "gold", -(itemPrice))
                end
            end
            User:notify("item", itemId, itemAmount)
        else
            User:notify("error", "Espaço insuficiente na bolsa!")
        end
    end
)
