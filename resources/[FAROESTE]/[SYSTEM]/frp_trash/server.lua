local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent("FRP:TRASH:receive")
AddEventHandler("FRP:TRASH:receive", function()
    local _source = source
    local User = API.getUserFromSource(_source)
    local Character = User:getCharacter()
    local Inventory = Character:getInventory()

    local sort = math.random(0, 102)
    local qtd = math.random(1, 3)

    if sort >= 0 and sort <= 5 then        
        Inventory:addItem("money", qtd*20)
        User:notify("item", "money", qtd*20)
    elseif sort >=6 and sort <=13 then
        Inventory:addItem("raw_iron", qtd)
        User:notify("item", "raw_iron", qtd)     
    elseif sort >=14 and sort <=29 then
        Inventory:addItem("corn", qtd)
        User:notify("item", "corn", qtd)     
    elseif sort >=30 and sort <=50 then
        Inventory:addItem("flask", qtd)
        User:notify("item", "flask", qtd)
    elseif sort >=51 and sort <=62 then
        Inventory:addItem("coal", qtd)
        User:notify("item", "coal", qtd)
    elseif sort >=63 and sort <=74 then
        Inventory:addItem("ropecut", qtd)
        User:notify("item", "ropecut", qtd)
    elseif sort >=75 and sort <=84 then
        Inventory:addItem("stick", qtd)
        User:notify("item", "stick", qtd)
    elseif sort >=85 and sort <=92 then
        Inventory:addItem("marijuana_seed", qtd)
        User:notify("item", "marijuana_seed", qtd)
    elseif sort >=93 and sort <=102 then
        Inventory:addItem("potassio", qtd)
        User:notify("item", "potassio", qtd)
    end
end)
