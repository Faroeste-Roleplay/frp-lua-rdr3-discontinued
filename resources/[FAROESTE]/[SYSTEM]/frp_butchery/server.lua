local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local sellables = {
    [-2011226991] = 175, -- eastern wild turkey black
    [-466054788] = 175, -- eastern wild turkey white
    [1458540991] = 300, -- Racoon
    [90267823] = 1050, -- Cougar
    [1110710183] = 550, -- whitetail deer
    [-1963605336] = 550, -- whitetail buck
    [480688259] = 300, -- california valley coyote
    [-1414989025] = 175, -- virginia opossum
    [-2063183075] = 175, -- Dominique Chicken
    [-1170118274] = 175, -- American Badger
    [-1458540991] = 200, -- North American Raccoon
    [1755643085] = 500, -- American Pronghorn Doe
    [-1464167925] = 225, -- Southern Copperhead Snake
    [-723190474] = 175, -- Canada Goose
    [-8651544272] = 200, -- Great Horned Owl
    [-1465438313] = 300, -- American Red Squirrel
    [-1568716381] = 500, -- Rocky Mountain Bighorn Ram
    [-885451903] = 775, -- Timber Wolf
    [-541762431] = 175, -- Black-Tailed Jackrabbit
    [252669332] = 625, -- American Red Fox
    [-861544272] = 200, -- Coastal Horned Owl
    [-1003616053] = 200, -- Pekin Duck
    [-829273561] = 350, -- gray wolf
    [-885451903] = 450, -- gray wolf
    [-1143398950] = 340, -- gray wolf
    [-2145890973] = 750, -- Red-Tailed Hawk
    [1007418994] = 85, -- Berkshire Pig
    [40345436] = 85,-- Merino Sheep
    [-1568716381] = 275, -- Rocky Mountain Bighorn Sheep
    [-575340245] = 350, -- Western Raven
    [1416324601] = 175, -- Ring-neck Phesant
    [-1553593718] = 500, -- Muskie
    [-1295720802] = 250, -- Aligator
    [-1211566332] = 275, -- Striped Skunk
    [-593056309] = 375, -- Desert Iguana
    [457416415] = 275, -- Banded Gila Monster
    [1265966684] = 175, -- American White Pelican
    [-300867788] = 350, -- Lake Sturgeon
    [90264823] = 1350, -- Cougar
    [-1134449699] = 175, -- American Musckrat
    [-2073130256] = 175, -- Neotropic Cormorant
    [-407730502] = 775, -- Alligator Snapping Turtle
    [-564099192] = 175, -- Whooping Crane
    [-1854059305] = 500, -- Green Iguana
    [831859211] = 175, -- Little Egret
    [1095117488] = 175, -- Tricolored Heron
    [2079703102] = 175, -- Greater Prairie Chicken
    [545068538] = 375, -- Timber Rattlesnake
    [1464167925] = 275, -- Nothern Copperhead Snake
    [1538187374] = 275, -- Channel Catfish
    [-1076508705] = 275, -- Roseate Spoonbill
    [1459778951] = 675, -- Bald Eagle
    [1104697660] = 175, -- Eastern Turkey Vulture
    [-164963696] = 175, -- Laughing Gull
    [386506078] = 175, -- Yellow-Billed Loon
    [-1797625440] = 275, -- Nine-Banded Armadillo
    [759906147] = 175, -- North American Beaver
    [-753902995] = 275, -- Alpine Goat
    [1654513481] = 3075, -- Legendary Panther
    [723190474] = 175, -- Canada Goose
    [-711779521] = 275, -- Longnose Gar
    [697075200] = 275, -- Northen Pike
    [-1553593715] = 375, -- Muskie
    [1205982615] = 175 -- Californian Condor
}

RegisterNetEvent("FRP:BUTCHER:TryToSell")
AddEventHandler(
    "FRP:BUTCHER:TryToSell",
    function(entType, entModel, entity, quality)
        local _source = source

        local User = API.getUserFromSource(_source)

        local payment = sellables[tonumber(entModel)]

        if payment == nil then
            TriggerClientEvent("FRP:BUTCHER:EntityNotAccepted", _source, entity)
            User:notify("error", "O açogueiro não quer este animal")
            return
        end

        local Character = User:getCharacter()
        local Inventory = Character:getInventory()

        if Inventory:addItem("money", payment) then
            User:notify("item", "money", payment / 100)

            -- "dollar"

            Character:varyExp(5)

            TriggerClientEvent("FRP:BUTCHER:EntityAccepted", _source, entity)
        else
            TriggerClientEvent("FRP:BUTCHER:EntityNotAccepted", _source, entity)
        end
    end
)
