local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local PlayerCount = 0
local list = {}

RegisterServerEvent("FRP:TRAIN:playerActivated")
function ActivateFRPTRAIN()
  if (PlayerCount) >= 1 then
    TriggerClientEvent("FRP:Trainroute", GetHostId())
    print("chamou train")
  else
    SetTimeout(1000, ActivateFRPTRAIN)
  end
end

AddEventHandler(
  "FRP:TRAIN:playerActivated",
  function()
    if not list[source] then
      PlayerCount = PlayerCount + 1
      list[source] = true
      if (PlayerCount) == 1 then
        SetTimeout(5000, ActivateFRPTRAIN)
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
  "calltrain",
  function()
    TriggerClientEvent("FRP:Trainroute", GetHostId())
  end
)

RegisterNetEvent("FRP:TRAIN:timeCall")
AddEventHandler(
  "FRP:TRAIN:timeCall",
  function()
    local hora = 6000 * 60
    local horas = 60000 * 180
    local timeram = math.random(hora, horas)

    Wait(timeram)

    local random = math.random(1, 6)
    TriggerEvent("FRP:TRAIN:createBAU", random)

    TriggerClientEvent("FRP:TRAIN:createPedDefender", GetHostId(), x + xram, y + yram, z)
    TriggerClientEvent("FRP:TRAIN:create", -1, x, y, z)
    TriggerEvent("FRP:TRAIN:timeCall")
  end
)

RegisterNetEvent("FRP:TRAIN:createBAU")
AddEventHandler(
  "FRP:TRAIN:createBAU",
  function(id)
    if not FRPTRAIN[id] then
      return
    end
    local x = FRPTRAIN[id][1]
    local y = FRPTRAIN[id][2]
    local z = FRPTRAIN[id][3]
    local Chest = API.getChestFromChestId(chest_id)

    local chest_id = "e." .. math.random(9999)
    local chest_owner_id = 0 -- Não tem dono, então o id é 0, irrelevante
    local chest_type = 0 -- Global, os items são sempre os mesmos
    local chest_capacity = 20 -- Capacidade maxima de peso
    local chest_group = nil -- Grupo necessaria para abrir o baú(nenhum)
    local inventory_id = nil
    local inventory_capacity = 20 -- A mesma que a de cima
    local yram = math.random(2, 50)
    local xram = math.random(2, 20)

    chest_position = {x + xram, y + yram, z, 10.0}

    local itensram = math.random(1, 6)

    local chest_Inventory = API.Inventory(inventory_id, inventory_capacity, inventory_items[itensram])
    local Chest = API.Chest(chest_id, chest_owner_id, chest_position, chest_type, chest_capacity, chest_Inventory, chest_group)
    Chest:cache() -- Se torna disponivel para sync com os clients

    bauId[chest_id] = true
  end
)

AddEventHandler(
  "FRP:CHESTS:Open",
  function()
    if bauId[chest_id] ~= nil then
      TriggerClientEvent("FRP:TRAIN:killblip", GetHostId())
    end
  end
)
