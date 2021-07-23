local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

cAPI = Proxy.getInterface('API')
API = Tunnel.getInterface('API')


local nbDelivery = 0
--CONFIGURATION--

local place = { x = 2746.816, y = -1394.401, z = 46.183} --Configuration marker prise de service
local placefin = { x = 2731.720, y = -1402.314, z = 46.183} --Configuration marker fin de service
local spawnwagon = { x = 2747.743, y = -1406.687, z = 46.109 } --Configuration du point de spawn du faggio

local livpt = { --Configuration des points de livraisons (repris ceux de Maykellll1 / NetOut)
[1] = {x= 2715.192,    y= -968.919,   z= 44.882},
[2] = {x= 2753.752,    y= -916.901,   z= 44.077},
[3] = {x= 2563.352,    y= -916.587,   z= 43.084},
[4] = {x= 2748.204,    y= -1171.547,  z= 52.515},
[5] = {x= 2862.136,    y= -1150.998,  z= 47.119},
[6] = {x= 2547.547,    y= -1114.459,  z= 53.715},
[7] = {x= 2373.469,    y= -1164.849,  z= 47.474},
[8] = {x= 2387.023,    y= -1263.916,  z= 46.479},
[9] = {x= 2672.298,    y= -1228.330,  z= 53.373},
[10] = {x= 2679.135,    y= -1192.016,  z= 61.592},
[11] = {x= 2725.858,    y= -1160.405,  z= 53.363},
[12] = {x= 862.118,     y= -1926.899,  z= 44.910},
[13] = {x= 894.505,     y= -1866.625,  z= 43.732},
[14] = {x= 1424.234,    y= -1138.709,  z= 76.080},
[15] = {x= 1348.208,    y= -1323.396,  z= 77.871},
[16] = {x= 1344.430,    y= -1242.983,  z= 79.953},
[17] = {x= 1296.933,    y= -1144.774,  z= 82.258},
[18] = {x= 1371.932,    y= -1154.007,  z= 80.819},
[19] = {x= 1699.274,    y= -389.838,   z= 50.105},
[20] = {x= 1785.086,    y= -401.818,   z= 47.526},
[21] = {x= 2116.760,    y= -595.170,   z= 42.690},
[22] = {x= 1173.354,    y= -188.168,   z= 100.914},
[23] = {x= 724.088,     y= -467.444,   z= 79.982},
[24] = {x= 347.520,     y= -666.643,   z= 42.865},
[25] = {x= 1458.879,    y= 320.330,    z= 90.637},
[26] = {x= 1778.286,    y= 461.139,    z= 112.953},
[27] = {x= 2238.104,    y= -141.446,   z= 47.684},
[28] = {x= 2626.500,    y= -909.146,   z= 43.094},
[29] = {x= 1710.045,    y= -1002.634,  z= 43.500},
[30] = {x= 2020.745,    y= -780.338,   z= 42.891}
}

local blip

local coefflouze = 0.1 --Coeficient multiplicateur qui en fonction de la distance definit la paie

--INIT--

local isInJobDelivery = false
local livr = 0
local plateab = "POPJOBS"
local isToHouse = false
local isToPizzaria = false
local paie = 0

local pourboire = 0
local posibilidad = 0
local px = 0
local py = 0
local pz = 0

--THREADS--



Citizen.CreateThread(function() --Thread lancement + livraison depuis le marker vert
  while true do

    Citizen.Wait(0)

    if isInJobDelivery == false then
      Citizen.InvokeNative(0x2A32FAA57B937173,0x6903B113, place.x,place.y,place.z-0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 20, 0, 0, 2, 0, 0, 0, false)    


      if GetDistanceBetweenCoords(place.x, place.y, place.z, GetEntityCoords(PlayerPedId(),true)) < 1.5 then
        DrawText("Aperte ALT para pegar as cartas" , 0.925, 0.96, 0.25, 0.25, false, 255, 255, 255, 145, 1, 7)

        if IsControlJustReleased(0, 0xE8342FF2) then -- LEFT ALT
            notif = true
            isInJobDelivery = true
            isToHouse = true

            livr = math.random(1, 30)

            px = livpt[livr].x
            py = livpt[livr].y
            pz = livpt[livr].z
            distance = round(GetDistanceBetweenCoords(place.x, place.y, place.z, px,py,pz))
            paie = distance * coefflouze

          --  spawn_faggio()
            goliv(livpt,livr)
            nbDelivery = 5
           -- TriggerServerEvent("FRP:DELIVERY:itemadd", nbDelivery)
        end
      end
    end

    if isToHouse == true then

      destinol = livpt[livr].name

      while notif == true do

        TriggerEvent('FRP:NOTIFY:Simple', 'Entregue as cartas no destino marcado', 10000)
        notif = false

        i = 1
      end
      Citizen.InvokeNative(0x2A32FAA57B937173,0x6903B113, livpt[livr].x,livpt[livr].y,livpt[livr].z-0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 20, 0, 0, 2, 0, 0, 0, false)    



      if GetDistanceBetweenCoords(px,py,pz, GetEntityCoords(PlayerPedId(),true)) < 3 then
    --    HelpText("Appuyez sur ~INPUT_CONTEXT~ pour livrer la pizza",0,1,0.5,0.8,0.6,255,255,255,255)

        DrawText("Aperte ALT para entregar" , 0.925, 0.96, 0.25, 0.25, false, 255, 255, 255, 145, 1, 7)

        if IsControlJustReleased(0, 0xE8342FF2) then -- LEFT ALT

          notif2 = true
          posibilidad = math.random(1, 100)
          afaitunepizzamin = true

         -- TriggerServerEvent("FRP:DELIVERY:itemrm")
          nbDelivery = nbDelivery - 1

          if (posibilidad > 70) and (posibilidad < 90) then

            pourboire = math.random(25, 60)

            TriggerEvent('FRP:NOTIFY:Simple', 'Você recebeu $'.. pourboire, 10000)

            TriggerServerEvent("FRP:DELIVERY:pay", pourboire)

          end

          RemoveBlip(blip) 
          ClearGpsMultiRoute()
          Wait(250)
          if nbDelivery == 0 then
            isToHouse = false
            isToPizzaria = true
          else
            isToHouse = true
            isToPizzaria = false
            livr = math.random(1, 30)

            px = livpt[livr].x
            py = livpt[livr].y
            pz = livpt[livr].z

            distance = round(GetDistanceBetweenCoords(place.x, place.y, place.z, px,py,pz))
            paie = distance * coefflouze

            goliv(livpt,livr)
          end


        end
      end
    end

    if isToPizzaria == true then

      while notif2 == true do
     --   SetNewWaypoint(place.x,place.y)

        TriggerEvent('FRP:NOTIFY:Simple', 'Volte para pegar mais cartas.', 10000)

        notif2 = false

      end
      Citizen.InvokeNative(0x2A32FAA57B937173,0x6903B113, place.x,place.y,place.z-0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 20, 0, 0, 2, 0, 0, 0, false)    


      if GetDistanceBetweenCoords(place.x,place.y,place.z, GetEntityCoords(PlayerPedId(),true)) < 3 and afaitunepizzamin == true then
        DrawText("Aperte ALT para pegar as cartas" , 0.925, 0.96, 0.25, 0.25, false, 255, 255, 255, 145, 1, 7)

        -- local CoordsCarroca = GetEntityCoords(GetPlayersLastVehicle(PlayerPedId()))
      --  if IsVehicleModel(GetVehiclePedIsIn(PlayerPedId(), true), GetHashKey("UTILLIWAG"))  then

          if IsControlJustReleased(0, 0xE8342FF2) then -- LEFT ALT
   
        --    if GetDistanceBetweenCoords(place.x,place.y,place.z, CoordsCarroca) > 30 then

              afaitunepizzamin = false

              TriggerEvent('FRP:NOTIFY:Simple', 'Obrigado pelo seu trabalho, aqui está seu pagamento $'.. paie, 10000)

              TriggerServerEvent("FRP:DELIVERY:pay", paie)

              isInJobDelivery = true
              isToHouse = true
              livr = math.random(1, 48)

              px = livpt[livr].x
              py = livpt[livr].y
              pz = livpt[livr].z

              distance = round(GetDistanceBetweenCoords(place.x, place.y, place.z, px,py,pz))
              paie = distance * coefflouze

              goliv(livpt,livr)
              nbDelivery = 5

        --      TriggerServerEvent("FRP:DELIVERY:itemadd", nbDelivery)

           --[[ else
              notifmoto1 = true
              while notifmoto1 == true do                
                TriggerEvent('FRP:NOTIFY:Simple', 'Cadê a carroça?', 10000)
              notifmoto1 = false
              end
            end ]]
          end
      --[[  else     
          while notifmoto2 == true do
            TriggerEvent('FRP:NOTIFY:Simple', 'Cadê a carroça?', 10000)
            notifmoto2 = false
          end
        end ]]
      end




    end
    if IsEntityDead(PlayerPedId()) then

      isInJobDelivery = false
      livr = 0
      isToHouse = false
      isToPizzaria = false

      paie = 0
      px = 0
      py = 0
      pz = 0
      RemoveBlip(blip) 
      ClearGpsMultiRoute()

    end
  end
end)



Citizen.CreateThread(function() -- Thread de "fin de service" depuis le point rouge
  while true do

    Citizen.Wait(0)

    if isInJobDelivery == true then
      Citizen.InvokeNative(0x2A32FAA57B937173,0x6903B113, placefin.x,placefin.y,placefin.z-0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 20, 0, 0, 2, 0, 0, 0, false)    
     -- DrawMarker(1,placefin.x,placefin.y,placefin.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,0,0, 200, 0, 0, 0, 0)

      if GetDistanceBetweenCoords(placefin.x, placefin.y, placefin.z, GetEntityCoords(PlayerPedId(),true)) < 1.5 then
        DrawText("Aperte ALT para cancelar as entregas.", 0.925, 0.96, 0.25, 0.25, false, 255, 255, 255, 145, 1, 7)

        if IsControlJustReleased(0, 0xE8342FF2) then -- LEFT ALT
     --     TriggerServerEvent('FRP:DELIVERY:deleteAllPizz')
          isInJobDelivery = false
          livr = 0
          isToHouse = false
          isToPizzaria = false

          paie = 0
          px = 0
          py = 0
          pz = 0

          if afaitunepizzamin == true then

            local vehicleu = GetVehiclePedIsIn(PlayerPedId(), false)

            SetEntityAsMissionEntity( vehicleu, true, true )
            deleteCar( vehicleu )

            TriggerEvent('FRP:NOTIFY:Simple', 'Obrigado pelos seus serviços.', 10000)

           -- TriggerServerEvent("FRP:DELIVERY:paiefinale")

            SetWaypointOff()

            afaitunepizzamin = false

          else

            local vehicleu = GetVehiclePedIsIn(PlayerPedId(), false)

            SetEntityAsMissionEntity( vehicleu, true, true )
            deleteCar( vehicleu )

            TriggerEvent('FRP:NOTIFY:Simple', 'Obrigado pelos seus serviços.', 10000)

          end
        end
      end
    end
  end
end)

--FONCTIONS--



function goliv(livpt,livr)
  ClearGpsMultiRoute()
  Wait(500)	
  StartGpsMultiRoute(76603059, true, true)
  liv = AddPointToGpsMultiRoute(livpt[livr].x,livpt[livr].y, livpt[livr].z)
  SetGpsMultiRouteRender(true) 

  blip = N_0x554d9d53f696d002(408396114, livpt[livr].x,livpt[livr].y, livpt[livr].z)
  SetBlipSprite(blip, 408396114, 1)
  SetBlipScale(blip, 0.1)
  Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Entrega')
end

function spawn_faggio() -- Thread spawn faggio
  local veh = GetHashKey('UTILLIWAG')
  local ply = GetPlayerPed()
  local coords = GetEntityCoords(ply)
  Citizen.CreateThread(
    function()
      RequestModel(veh)
      while not HasModelLoaded(veh) do
                  Wait(1000)                    
      end
      if HasModelLoaded(veh) then
          car = CreateVehicle(veh, spawnwagon.x,spawnwagon.y,spawnwagon.z, 264.0, true, true, false, true)
      end
    end)
end

function round(num, numDecimalPlaces)
  local mult = 5^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function deleteCar( entity )
  Citizen.InvokeNative( 0xE20A909D8C4A70F8, Citizen.PointerValueIntInitialized( entity ) ) --Native qui del le vehicule
end

function IsInVehicle() --Fonction de verification de la presence ou non en vehicule du joueur
  local ply = PlayerPedId()
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end


function playAnim(dict, anim, speed)
  if IsEntityPlayingAnim(PlayerPedId(), dict, anim) then
      RequestAnimDict(dict)
      -- while HasAnimDictLoaded(dict) && !noCrash do
      --     -- noCrash = setTimeout(function ()
      --     --     RequestAnimDict(dict)
      --     -- }, 1000);
      -- end
      TaskPlayAnim(PlayerPedId(), dict, anim, speed, 1.0, -1, 0, 0, 0, 0, 0, 0, 0)
  end
end

function DrawText(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre, font)
  SetTextScale(w, h)
  SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
  SetTextCentre(centre)
  if enableShadow then
      SetTextDropshadow(1, 0, 0, 0, 255)
  end
  Citizen.InvokeNative(0xADA9255D, font)
  DisplayText(CreateVarString(10, "LITERAL_STRING", str), x, y)
end