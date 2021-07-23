local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local isUiOpen = false 
local object = 0
local TestLocalTable = {}
local editingNotpadId = nil
local Notepad = false
function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
    local factor = (string.len(text)) / 150
    DrawSprite("generic_textures", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 52, 52, 52, 190, 0)
end

RegisterNUICallback('escape', function(data, cb)
    local text = data.text
    TriggerEvent("FRP:NOTEPAD:CloseNotepad")
end)

RegisterNUICallback('updating', function(data, cb)
    local text = data.text
    TriggerServerEvent("FRP:NOTEPAD:updateNote",editingNotpadId, text)
    editingNotpadId = nil
    TriggerEvent("FRP:NOTEPAD:CloseNotepad")
end)

RegisterNUICallback('droppingEmpty', function(data, cb)
    print('You cant drop empty notepad')
end)

RegisterNUICallback('dropping', function(data, cb)
    local text = data.text
    local location = GetEntityCoords(PlayerPedId())
    TriggerServerEvent("FRP:NOTEPAD:newNote",text,location["x"],location["y"],location["z"])
    TriggerEvent("FRP:NOTEPAD:CloseNotepad")
end)

RegisterNetEvent("FRP:NOTEPAD:OpenNotepadGui")
AddEventHandler("FRP:NOTEPAD:OpenNotepadGui", function()
    if not isUiOpen then
        openGui()
        Notepad = true
        Wait(100)
        TriggerEvent("FRP:NOTEPAD:note")
    end
end)

RegisterNetEvent("FRP:NOTEPAD:CloseNotepad")
AddEventHandler("FRP:NOTEPAD:CloseNotepad", function()
    SendNUIMessage({
        action = 'closeNotepad'
    })
    SetPlayerControl(PlayerId(), 1, 0)
    isUiOpen = false
    SetNuiFocus(false, false);
    TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Citizen.Wait(100)
    ClearPedSecondaryTask(PlayerPedId())
    DetachEntity(prop, 1, 1)
    DeleteObject(prop)
    DetachEntity(secondaryprop, 1, 1)
    DeleteObject(secondaryprop)
    Notepad = false
    Wait(100)
    TriggerEvent("FRP:NOTEPAD:note")

end)

-- RegisterNetEvent('FRP:NOTEPAD:note')
-- AddEventHandler('FRP:NOTEPAD:note', function()
--     local player = PlayerPedId()
--     local ad = "missheistdockssetup1clipboard@base"
                
--     local prop_name = prop_name or 'p_typewriter01x'
--     local secondaryprop_name = secondaryprop_name or 'p_typewriter01x'
    
--     if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
--         loadAnimDict( ad )
--         if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
--             TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
--             Citizen.Wait(100)
--             ClearPedSecondaryTask(PlayerPedId())
--             DetachEntity(prop, 1, 1)
--             DeleteObject(prop)
--             DetachEntity(secondaryprop, 1, 1)
--             DeleteObject(secondaryprop)
--         else
--             local x,y,z = table.unpack(GetEntityCoords(player))
--             prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
--             secondaryprop = CreateObject(GetHashKey(secondaryprop_name), x, y, z+0.2,  true,  true, true)
--             AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 18905), 0.1, 0.02, 0.05, 10.0, 0.0, 0.0, true, true, false, true, 1, true) -- lkrp_notepadpad
--             AttachEntityToEntity(secondaryprop, player, GetPedBoneIndex(player, 58866), 0.12, 0.0, 0.001, -150.0, 0.0, 0.0, true, true, false, true, 1, true) -- pencil
--             TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
--         end     
--     end
-- end)


RegisterNetEvent('FRP:NOTEPAD:note')
AddEventHandler('FRP:NOTEPAD:note', function()
    if Notepad then
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_WRITE_NOTEBOOK"), -1,false,false, false, false)
    else
        ClearPedTasks(PlayerPedId())
    end
end)


function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

RegisterNetEvent('FRP:NOTEPAD:updateNotes')
AddEventHandler('FRP:NOTEPAD:updateNotes', function(serverNotesPassed)
    TestLocalTable = serverNotesPassed
end)

function openGui() 
    local veh = GetVehiclePedIsUsing(PlayerPedId())  
    if GetPedInVehicleSeat(veh, -1) ~= PlayerPedId() then
        SetPlayerControl(PlayerId(), 0, 0)
        SendNUIMessage({
            action = 'openNotepad',
        })
        isUiOpen = true
        SetNuiFocus(true, true);
    end
end

function openGuiRead(text)
  local veh = GetVehiclePedIsUsing(PlayerPedId())
  if GetPedInVehicleSeat(veh, -1) ~= PlayerPedId() then
        SetPlayerControl(PlayerId(), 0, 0)
        TriggerEvent("FRP:NOTEPAD:note")
        isUiOpen = true
        Citizen.Trace("OPENING")
        SendNUIMessage({
            action = 'openNotepadRead',
            TextRead = text,
        })
        SetNuiFocus(true, true)
  end  
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if #TestLocalTable == 0 then
            Citizen.Wait(1000)
        else
            local closestNoteDistance = 900.0
            local closestNoteId = 0
            local plyLoc = GetEntityCoords(PlayerPedId())
            for i = 1, #TestLocalTable do
                local distance = GetDistanceBetweenCoords(plyLoc["x"], plyLoc["y"], plyLoc["z"], TestLocalTable[i]["x"],TestLocalTable[i]["y"],TestLocalTable[i]["z"], true)
                if distance < 10.0 then
                    Citizen.InvokeNative(0x2A32FAA57B937173,-1795314153, TestLocalTable[i]["x"],TestLocalTable[i]["y"],TestLocalTable[i]["z"]-0.8, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 0.2, 0.2, 255, 255, 150, 75, 0, 2, 0, 0, 0, false)   
                 --   DrawMarker(27, TestLocalTable[i]["x"],TestLocalTable[i]["y"],TestLocalTable[i]["z"]-0.8, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 2.0, 255, 255,150, 75, 0, 0, 2, 0, 0, 0, 0)
                end

                if distance < closestNoteDistance then
                  closestNoteDistance = distance
                  closestNoteId = i
                end
            end

            if closestNoteDistance > 100.0 then
                Citizen.Wait(math.ceil(closestNoteDistance*10))
            end

            if TestLocalTable[closestNoteId] ~= nil then
            local distance = GetDistanceBetweenCoords(plyLoc, TestLocalTable[closestNoteId]["x"],TestLocalTable[closestNoteId]["y"],TestLocalTable[closestNoteId]["z"], true)
            if distance < 5.0 then
                Citizen.InvokeNative(0x2A32FAA57B937173,-1795314153, TestLocalTable[closestNoteId]["x"],TestLocalTable[closestNoteId]["y"],TestLocalTable[closestNoteId]["z"]-0.8, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 0.2, 0.2, 255, 255, 150, 75, 0, 2, 0, 0, 0, false)   
              --  DrawMarker(27, TestLocalTable[closestNoteId]["x"],TestLocalTable[closestNoteId]["y"],TestLocalTable[closestNoteId]["z"]-0.8, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 2.0, 255, 255, 155, 75, 0, 0, 2, 0, 0, 0, 0)
                DrawText3Ds(TestLocalTable[closestNoteId]["x"],TestLocalTable[closestNoteId]["y"],TestLocalTable[closestNoteId]["z"]-0.4, "~g~E~s~ para ler,~g~G~s~ para destruir")

                if IsControlJustReleased(0, 0xCEFD9220) then
                    openGuiRead(TestLocalTable[closestNoteId]["text"])
                    editingNotpadId = closestNoteId
                end
                if IsControlJustReleased(0, 0x760A9C6F) then
                  TriggerServerEvent("FRP:NOTEPAD:destroyNote",closestNoteId)
                  table.remove(TestLocalTable,closestNoteId)
                end

            end
          else
            if TestLocalTable[closestNoteId] ~= nil then
              table.remove(TestLocalTable,closestNoteId)
            end
          end 

        end
    end 
end)