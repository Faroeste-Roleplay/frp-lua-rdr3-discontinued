local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local verificationData = {
    -- ["Armeiro"] = {
    --     -- Level, Dollar, Gold, Amount(optional)
    --     ["revolver_lemat"] = {0, 317, 13},
    --     ["revolver_cattleman"] = {0, 50, 2},
    --     ["revolver_navy"] = {0, 257, 11},
    --     ["pistol_volcanic"] = {0, 300, 14},
    --     ["shotgun_sawedoff"] = {0, 65, 15},
    --     ["repeater_carbine"] = {0, 90, 4},
    --     ["repeater_henry"] = {0, 234, 10},
    --     ["sniperrifle_rollingblock"] = {0, 500, 20},
    --     ["rifle_varmint"] = {0, 72, 3}
    -- },
    ["Arsenal"] = {
        group = "trooper",
        -- Level, Price, Amount(optional)
        ["revolver_doubleaction"] = {0, 0, 0},
        ["rifle_springfield"] = {0, 0, 0},
        ["repeater_evans"] = {0, 0, 0},
        ["ammo_revolver"] = {0, 0, 0, 100},
        ["ammo_rifle"] = {0, 0, 0, 75},
        ["ammo_repeater"] = {0, 0, 0, 50},
        ["melee_lantern_electric"] = {0, 0, 0, 1},
        ["melee_torch"] = {0, 0, 0, 1},
        ["lasso"] = {0, 0, 0, 1},
        ["melee_knife"] = {0, 0, 0, 1},
        ["eagleeye"] = {0, 200, 80, 1},
    },
    -- ["Mercadinho"] = {
    --     -- Level, Price, Amount(optional)
    --     ["consumable_vodka"] = {1, 50}
    -- },
    -- ["Planeta Semente'"] = {
    --     ["tobacco_seed"] = {1, 100, 10}
    -- }
    ["Mercado Clandestino"] = {			
        ["medicine_poor"] = {0, 1000, 100, 1},
        ["stimulant_poor"] = {0, 1000, 100, 1},
        ["pigeonpost"] = {0, 500, 30, 1},
        ["acamp_tents_small"] = {0, 3000, 200, 1},
        ["acamp_tents_med_closed"] = {0, 5000, 350, 1},
        ["acamp_bedroll"] = {0, 500, 40, 1},
        ["acamp_firesmall"] = {0, 500, 40, 1},
        ["acamp_firesmal_pan"] = {0, 800, 60, 1}		
	},

    ["Mercado Geral"] = {
        ["tobacco_seed"] = {0, 10, 4, 5},
        ["corn_seed"] = {0, 10, 4, 5},
        ["sugarcane_seed"] = {0, 10, 4, 5},
        -- ["pickaxe"] = {0, 100, 40, 1},
        ["lasso"] = {0, 3000, 1200, 1},
        ["melee_knife"] = {0, 2000, 800, 1},
        ["melee_lantern_electric"] = {0, 200, 80, 1},
        ["melee_torch"] = {0, 200, 80, 1},
        ["bow"] = {0, 7000, 2800, 1},
        ["ammo_arrow"] = {0, 100, 40, 1}
    }
}

RegisterNetEvent("FRP:SHOP:TryToBuy")
AddEventHandler(
    "FRP:SHOP:TryToBuy",
    function(shopId, itemId, withGold)
        local _source = source

        if not verificationData[shopId] or not verificationData[shopId][itemId] then
            return
        end

        local data = verificationData[shopId]

        local User = API.getUserFromSource(_source)
        local Character = User.getCharacter()

        if data.group then
            if not Character:hasGroupOrInheritance(data.group) then
                User:notify("error", "Você não tem permissao")
                return
            end
        end

        local itemData = data[itemId]

        -- local itemLevel = itemData[1]

        -- if Character:getLevel() < itemLevel then
        --     User:notify("error", "Você não tem level suficiente")
        --     return
        -- end

        local Inventory = Character:getInventory()

        local currencyItem = "money"
        local itemPrice = itemData[2]

        if withGold then
            currencyItem = "gold"
            itemPrice = itemData[3]
        end

        if Inventory:getItemAmount(currencyItem) < itemPrice then
            if currencyItem == "money" then
                User:notify("error", "Doláres insuficientes")
            else
                User:notify("error", "Ouros insuficientes")
            end
            return
        end

        local itemAmount = itemData[4]

        if Inventory:addItem(itemId, itemAmount or 1) then
            Inventory:removeItem(-1, currencyItem, itemPrice)
            if itemPrice > 0 then
                if not withGold then
                    User:notify("item", "money", -(itemPrice))
                else
                    User:notify("item", "gold", -(itemPrice))
                end
            end
            User:notify("item", itemId, itemAmount or 1)
        else
            User:notify("error", "Espaço insuficiente na bolsa!")
        end
    end
)
