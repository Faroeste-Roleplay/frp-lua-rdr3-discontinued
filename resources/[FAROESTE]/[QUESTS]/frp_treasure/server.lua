local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local PlayerCount = 0
local list = {}
local bauId = {}
local chest_id = nil

local inventory_items = {
  [1] = {["melee_hatchet_hunter_rusted"] = 2, ["bow"] = 1, ["ammo_arrow"] = 20, ["medicine_good"] = 3},
  [2] = {["melee_knife_vampire"] = 1, ["revolver_cattleman_john"] = 1, ["raw_gold"] = 5, ["stimulant_good"] = 2},
  [3] = {["revolver_cattleman"] = 3, ["bow"] = 2, ["ammo_arrow"] = 20},
  [4] = {["medicine_good"] = 1, ["repeater_henry"] = 2, ["gold"] = 100},
  [5] = {["lasso"] = 3, ["repeater_winchester"] = 1, ["money"] = 5000},
  [6] = {["rifle_springfield"] = 1, ["repeater_winchester"] = 1, ["money"] = 5000}
}

local animals = {
 	[1] = {["A_C_Bear_01"] = 3},
	[2] = {["A_C_Alligator_02"] = 3},
	[3] = {["A_C_Wolf"] = 10},
  [4] = {["A_C_Panther_01"] = 3},
  [5] = {["G_M_M_UNISWAMP_01"] = 8}
}

local TREASURE = {
  [1] = {-1629.949,-394.500,178.458}, --strawberry
 -- [2] = {-575.34, 2033.95, 289.66}, -- montain tempest rim
--  [3] = {-4360.701, -2511.478, 1.832}, -- CHOLLA SPRINGS
 -- [4] = {-5110.177, -3745.233, -3.292}, --   benedict point
  [2] = {1887.26, 279.11, 77.11}, -- EMERALD STATION
  [3] = {-758.89, -380.43, 41.96}, -- dakota river
  [4] = {1829.993, -1633.500, 45.707},
  [5] = {2336.198,-751.916,41.709},
  [6] = {1399.832,1320.947,164.975}
  
}

RegisterServerEvent("TREASURE:playerActivated")
function ActivateTreasure()
  if (PlayerCount) >= 1 then
    TriggerEvent("TREASURE:timeCall")
  else
    SetTimeout(1000, ActivateTreasure)
  end
end

AddEventHandler(
  "TREASURE:playerActivated",
  function()
    if not list[source] then
      PlayerCount = PlayerCount + 1
      list[source] = true
      if (PlayerCount) == 1 then
        SetTimeout(15000, ActivateTreasure)
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

-- RegisterCommand(
--   "callbau",
--   function()
--     local random = math.random(1, 6)
--     TriggerEvent("TREASURE:create", random)
--   end
-- )

RegisterNetEvent("TREASURE:timeCall")
AddEventHandler(
  "TREASURE:timeCall",
  function()
    local hora = 60000 * 60
    local TimeSpawnMax = hora * 10
    local TimeSpawnMin = hora * 6

    local timeram = math.random(TimeSpawnMin, TimeSpawnMax)

    print(timeram)    

    Wait(timeram)

    local random = math.random(1, 6)
    TriggerEvent("TREASURE:create", random)
  end
)

RegisterNetEvent("TREASURE:create")
AddEventHandler(
  "TREASURE:create",
  function(id)
    if not TREASURE[id] then
      return
    end
    local x = TREASURE[id][1]
    local y = TREASURE[id][2]
    local z = TREASURE[id][3]
    local Chest = API.getChestFromChestId(chest_id)

    local inventory_capacity = 20 -- A mesma que a de cima
    local yram = math.random(2, 50)
    local xram = math.random(2, 20)

    local itensram = math.random(1, 6)

    local parsed = {}

    for itemId, itemAmount in pairs(inventory_items[itensram]) do
      local i = math.random(112, 128)
      local tries = 16
      while parsed[i] ~= nil and tries > 0 do
        i = math.random(112, 128)
        tries = tries - 1
      end

      local itemData = API.getItemDataFromId(itemId)

      if itemData:getType() == "weapon" then
        parsed[i] = {
          name = itemId, 
          amount = {itemAmount, 0, 1}        
        }

      else
        parsed[i] = {
          name = itemId,
          amount = {itemAmount}
        }
      end
    end

    chest_id = "e:" .. math.random(9999)

    local chest_Inventory = API.Inventory("chest:" .. chest_id, 20, parsed)

    chest_Inventory:setAutoSort(false)

    local Chest = API.Chest(chest_id)
    Chest:setPosition({x + xram, y + yram, z, 10.0})
    Chest:setInventory(0, chest_Inventory)
    Chest:cache() -- Se torna disponivel para sync com os clients

    bauId[chest_id] = true 

    print('Tesouro Perdido Spawn ID'..chest_id)
    TriggerClientEvent("TREASURE:create", -1, x, y, z)
    for AnimalHash, Quantity in pairs(animals[math.random(1,5)]) do
      TriggerClientEvent("TREASURE:createPedDefender", GetHostId(), x + xram, y + yram, z, AnimalHash, Quantity)      
    end
    TriggerEvent("TREASURE:timeCall")
  end
)

RegisterCommand('testtable', function()

  print(chest_id)
end)

AddEventHandler(
  "FRP:CHESTS:Open",
  function(chestId)
    if chest_id ~= nil then
      TriggerClientEvent("TREASURE:killblip", -1)
    end
  end
)


