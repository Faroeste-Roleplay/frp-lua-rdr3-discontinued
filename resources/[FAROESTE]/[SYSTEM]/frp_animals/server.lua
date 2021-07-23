local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local PlayerCount = 0
local list = {}

local ANIMALSHASH = {
 -- {Pos = {-921.25, -1577.69, 66.03}, Animals = {"A_C_Horse_Andalusian_Perlino","A_C_Horse_Andalusian_DarkBay","A_C_Horse_AmericanStandardbred_Buckskin","A_C_Horse_Nokota_ReverseDappleRoan"}},
--  {Pos = {-921.25, -1577.69, 66.03}, Animals = {"A_C_Horse_Andalusian_DarkBay","A_C_Horse_Andalusian_Perlino"}},
  {Pos = {301.100,-321.573,115.650}, Animals = {"A_C_Horse_Andalusian_DarkBay","A_C_Horse_Andalusian_Perlino"}}
}

local LEGENDARYANIMALS = {
  [1] = {Pos = {87.084,191.581,108.899}, Animals = "A_C_Alligator_02"},
  [2] = {Pos = {87.084,191.581,108.899}, Animals = "A_C_Alligator_02"},
  [3] = {Pos = {87.084,191.581,108.899}, Animals = "A_C_Alligator_02"},
}


RegisterServerEvent("FRP:ANIMALS:playerActivated")
function ActivateANIMALS()
  if (PlayerCount) >= 1 then
    TriggerEvent("FRP:ANIMALS:timeCallLegendary")
  else
    SetTimeout(1000, ActivateANIMALS)
  end
end

AddEventHandler(
  "FRP:ANIMALS:playerActivated",
  function()
    if not list[source] then
      PlayerCount = PlayerCount + 1
      list[source] = true
      if (PlayerCount) == 1 then
        SetTimeout(15000, ActivateANIMALS)
      end
    end
  end
)

AddEventHandler(
  "playerDropped",
  function()
    if list[source] then
      PlayerCount = PlayerCount - 1
      list[source] = nil
    end
  end
)

RegisterCommand(
  "CALLANIMALS",
  function(source, rawCommand)
    local random = math.random(1, 6)
    TriggerEvent("FRP:ANIMALS:create", random)
  end
)

RegisterCommand(
  "CALLLEGENDARY",
  function(source, rawCommand)
    local random = math.random(1, 3)
    TriggerEvent("FRP:ANIMALS:createLegendary", random)
  end
)

RegisterNetEvent("FRP:ANIMALS:timeCallLegendary")
AddEventHandler(
  "FRP:ANIMALS:timeCallLegendary",
  function()
    local hora = 60000 * 70
    local horas = 60000 * 180
    local timeram = math.random(hora, horas)
    Wait(timeram)
    local random = math.random(1, 6)
    TriggerEvent("FRP:ANIMALS:createLegendary", random)
  end
)

RegisterNetEvent("FRP:ANIMALS:create")
AddEventHandler(
  "FRP:ANIMALS:create",
  function()
    for _,k in pairs(ANIMALSHASH) do
      local yram = math.random(2, 50)
      local xram = math.random(2, 20)

      local x = k.Pos[1]
      local y = k.Pos[2]
      local z = k.Pos[3]

      local modelhash = k.Animals

      for i = 1, #k.Animals do        
        TriggerClientEvent("FRP:ANIMALS:createPeds", GetHostId(), modelhash[i], x + xram, y + yram, z)
      end
    end
  end
)

RegisterNetEvent("FRP:ANIMALS:createLegendary")
AddEventHandler(
  "FRP:ANIMALS:createLegendary",
  function(id)    

    if not LEGENDARYANIMALS[id] then
      return
    end

    local x = LEGENDARYANIMALS[id].Pos[1]
    local y = LEGENDARYANIMALS[id].Pos[2]
    local z = LEGENDARYANIMALS[id].Pos[3]

    local yram = math.random(2, 50)
    local xram = math.random(2, 20)

    local modelhash = LEGENDARYANIMALS[id].Animals
    
    TriggerClientEvent("FRP:ANIMALS:create", -1, x, y, z)
    TriggerClientEvent("FRP:ANIMALS:createPeds", GetHostId(), tostring(modelhash), x + xram, y + yram, z)
  end
)