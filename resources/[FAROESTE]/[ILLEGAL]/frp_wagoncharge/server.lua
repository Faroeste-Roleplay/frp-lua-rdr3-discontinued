local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local PlayerCount = 0
local list = {}
local FinishedDelivery

local reward_itens = {
  [1] = {["melee_hatchet_hunter_rusted"] = 2, ["bow"] = 1, ["ammo_arrow"] = 20, ["medicine_good"] = 3},
  [2] = {["melee_knife_vampire"] = 1, ["revolver_cattleman_john"] = 1, ["raw_gold"] = 5, ["stimulant_good"] = 2},
  [3] = {["revolver_cattleman"] = 3, ["bow"] = 2, ["ammo_arrow"] = 20},
  [4] = {["medicine_good"] = 1, ["repeater_henry"] = 2, ["gold"] = 100},
  [5] = {["lasso"] = 3, ["repeater_winchester"] = 1, ["money"] = 5000},
  [6] = {["rifle_springfield"] = 1, ["repeater_winchester"] = 1, ["money"] = 5000}
}

local SPAWNWAGON = {
  [1] = {-1247.230,418.908,83.747}, --strawberry
 -- [2] = {-575.34, 2033.95, 289.66}, -- montain tempest rim
--  [3] = {-4360.701, -2511.478, 1.832}, -- CHOLLA SPRINGS
 -- [4] = {-5110.177, -3745.233, -3.292}, --   benedict point
  [2] = {-1247.230,418.908,83.747}, -- EMERALD STATION
  [3] = {-1247.230,418.908,83.747}, -- dakota river
  [4] = {-1247.230,418.908,83.747},
  [5] = {-1247.230,418.908,83.747},
  [6] = {-1247.230,418.908,83.747}  
}

local DESTINYWAGON = {
  [1] = {-1311.280,382.569,95.536}, --strawberry
  [2] = {-1311.280,382.569,95.536}, -- montain tempest rim
  [3] = {-1311.280,382.569,95.536}, -- CHOLLA SPRINGS
  [5] = {-1311.280,382.569,95.536}, --   benedict point
  [6] = {-1311.280,382.569,95.536}, -- EMERALD STATION
  [7] = {-1311.280,382.569,95.536}, -- dakota river
  [8] = {-1311.280,382.569,95.536},
  [9] = {-1311.280,382.569,95.536},
  [10] = {-1311.280,382.569,95.536}  
}

RegisterServerEvent("FRP:WAGONCHARGE:playerActivated")
function ActivateWAGONCHARGE()
  if (PlayerCount) >= 1 then
    TriggerEvent("FRP:WAGONCHARGE:timeCall")
  else
    SetTimeout(1000, ActivateWAGONCHARGE)
  end
end

AddEventHandler(
  "FRP:WAGONCHARGE:playerActivated",
  function()
    if not list[source] then
      PlayerCount = PlayerCount + 1
      list[source] = true
      if (PlayerCount) == 1 then
        SetTimeout(15000, ActivateWAGONCHARGE)
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

RegisterNetEvent("FRP:WAGONCHARGE:timeCall")
AddEventHandler(
  "FRP:WAGONCHARGE:timeCall",
  function()
    local hora = 60000 * 60
    local TimeSpawnMax = hora * 10
    local TimeSpawnMin = hora * 6

    local timeram = math.random(TimeSpawnMin, TimeSpawnMax)

    print(timeram)    

    Wait(timeram)


  end
)

RegisterCommand('testeWagon', function()
  math.randomseed(GetGameTimer())
  local r1 = math.random(1, 6)
  local r2 = math.random(1, 10)
  TriggerEvent("FRP:WAGONCHARGE:create", r1, r2)

end)


RegisterNetEvent("FRP:WAGONCHARGE:create")
AddEventHandler(
  "FRP:WAGONCHARGE:create",
  function(id, r2)
    FinishedDelivery = false

    if not SPAWNWAGON[id] then
      return      
    end

    if not DESTINYWAGON[r2] then
      return
    end
        --print(vector3(json.encode(SPAWNWAGON[id])), DESTINYWAGON[r2])
    TriggerClientEvent("FRP:WAGONCHARGE:StartNotify", -1, vector3(table.unpack(SPAWNWAGON[id])), vector3(table.unpack(DESTINYWAGON[r2])))
    Wait(200)
    TriggerClientEvent("FRP:WAGONCHARGE:StartMission", GetHostId())
     

  --  TriggerEvent("FRP:WAGONCHARGE:timeCall")
  end
)

RegisterNetEvent("FRP:WAGONCHARGE:Finished")
AddEventHandler(
  "FRP:WAGONCHARGE:Finished",
  function()
    local User = API.getUserFromSource(source)
    local Character = User:getCharacter()
    local Inventory = Character:getInventory()


    local itensram = math.random(1, 6)



    if not FinishedDelivery then
      for k, v in pairs(reward_itens[itensram]) do
        Inventory:addItem(k, tonumber(v))
      end
      FinishedDelivery = true
    end

    TriggerClientEvent("FRP:WAGONCHARGE:killblip", source)
    print('sumiu')
  end
)