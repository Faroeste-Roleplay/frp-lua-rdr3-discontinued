local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

pitch = 0
tempObj = nil
TentsSpawned = {}
Tents = {}
myIdentifier = nil
position = {}

RegisterNetEvent('FRP:TENTS:usedItem')
AddEventHandler('FRP:TENTS:usedItem', function(model)   
    local coords  = GetEntityCoords(PlayerPedId())
    local forward = GetEntityForwardVector(PlayerPedId())
    local x, y, z = table.unpack(coords + forward * 1.6)

    if GetCurrentTownName() ~= false then
        TriggerEvent('FRP:NOTIFY:Simple', "Você não pode montar acampamento próximo a uma cidade.", 5000)
        return
    end

    if not HasModelLoaded(model) then
        RequestModel(model)
    end
    while not HasModelLoaded(model) do
        Citizen.Wait(1)
    end
    tempObj = CreateObject(model, x, y, z-1, true, true, false)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if tempObj ~= nil then
            local coords  = GetEntityCoords(PlayerPedId())

            local forward = GetEntityForwardVector(PlayerPedId())

            

            local x, y, z = table.unpack(coords + forward * 1.6)

            local retval, groundZ, normal = GetGroundZAndNormalFor_3dCoord(x,y,z)

            z = groundZ

            SetEntityAlpha(tempObj, 127)
            SetEntityCollision(tempObj, false, false)
            SetEntityCoords(tempObj, x,y,z)           

            local gmRotation = GetGameplayCamRot(2)

         --   if IsControlJustPressed(2, 0x62800C92) then -- SCROLL UP

                SetEntityRotation(tempObj, vector3(gmRotation.x, GetEntityRotation(tempObj).yz))
         --   end

            if IsControlJustPressed(2, 0x62800C92) then -- SCROLL UP
                SetEntityHeading(tempObj, GetEntityHeading(tempObj) + 10)
                
            end

            if IsControlJustPressed(2, 0x8BDE7443) then -- SCROLL DOWN
                SetEntityHeading(tempObj, GetEntityHeading(tempObj) - 10)
               
            end

            if Citizen.InvokeNative(0x50F940259D3841E6, 1, 0x07CE1E61) then
                for k,v in pairs(Config.Tents) do
                    if Config.Tents[k].tentModel == GetEntityModel(tempObj) then

                        local pPos = GetEntityCoords(tempObj)
                        local pRot = GetEntityRotation(tempObj)
                        local pHea = GetEntityHeading(tempObj)  

                        TriggerServerEvent('FRP:TENTS:createdTent', Config.Tents[k].itemId, Config.Tents[k].tentModel, pPos, pRot, pHea)
                        DeleteObject(tempObj)
                        tempObj = nil                                 
                        exports['frp_progbar']:Progress({
                            name = "creating_tents",
                            duration = Config.Tents[k].tentSpawnTime,
                            label = Config.Tents[k].tentLabel,
                            useWhileDead = false,
                            canCancel = false,
                            controlDisables = {
                                disableMovement = true,
                                disableCarMovement = false,
                                disableMouse = false,
                                disableCombat = true,
                            },
                            animation = {
                                animDict = nil,
                                anim = nil,
                                flags = 49,
                            },
                            prop = {
                                model = nil,
                            }
                        }, function(status)
                            if not status then
                                TriggerServerEvent('FRP:TENTS:spawnTents')
                            end
                        end)
                    end
                end
            elseif Citizen.InvokeNative(0x50F940259D3841E6, 1, 0xF84FA74F) then
                DeleteObject(tempObj)
                tempObj = nil
            end
        end
    end
end)

Citizen.CreateThread(function()    
    TriggerServerEvent('FRP:TENTS:spawnTents')
end)


RegisterNetEvent('FRP:TENTS:spawnCliTents')
AddEventHandler('FRP:TENTS:spawnCliTents', function(tents, identifier)
    myIdentifier = identifier

    print(myIdentifier)

    for k,v in pairs(tents) do
        if TentsSpawned[k] == nil then
            position[k] = json.decode(tents[k].position)
            TentsSpawned[k] = CreateObject(tents[k].model, position[k].x, position[k].y, position[k].z, true, true, false)
            Tents[k] = tents[k]
            SetEntityCoords(TentsSpawned[k], position[k].x,position[k].y, position[k].z)
            SetEntityHeading(TentsSpawned[k], position[k].h)
            SetEntityRotation(TentsSpawned[k], position[k].rotx, position[k].roty, position[k].rotz)
        end
    end
end)

appear = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(2, 0x3C3DD371) then -- Hold PGDOWN
            appear = not appear
        end
        for k,v in pairs(TentsSpawned) do
            local pos = GetEntityCoords(TentsSpawned[k])
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), pos.x, pos.y, pos.z, true) <= 2.0 then    
                if Tents[k].charid == myIdentifier then
                    for x,a in pairs(Config.Tents) do
                        if appear and Config.Tents[x].tentModel == GetEntityModel(TentsSpawned[k]) then
                            DrawText3D(pos.x, pos.y, pos.z, "Sua "..Config.Tents[x].tentText)
                        end
                        if IsControlJustPressed(2, 0x4AF4D473) and appear then -- Hold DEL
                            print('dell1')
                            if Config.Tents[x].tentModel == GetEntityModel(TentsSpawned[k]) then
                            print('dell2')
                                TriggerServerEvent('FRP:TENTS:removeTents', Tents[k].id, Config.Tents[x].itemId)
                                DeleteObject(TentsSpawned[k])
                            end
                        end
                    end
                end
            end
        end
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
    local factor = (string.len(text)) / 150
    DrawSprite("menu_textures", "translate_bg_1a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 5, 5, 5, 190, 0)
end

function GetCurrentTownName()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords, 1)
    if town_hash == GetHashKey("Annesburg") then
        return "Annesburg"
    elseif town_hash == GetHashKey("Armadillo") then
        return "Armadillo"
    elseif town_hash == GetHashKey("Blackwater") then
        return "Blackwater"
    elseif town_hash == GetHashKey("BeechersHope") then
        return "BeechersHope"
    elseif town_hash == GetHashKey("Braithwaite") then
        return "Braithwaite"
    elseif town_hash == GetHashKey("Butcher") then
        return "Butcher"
    elseif town_hash == GetHashKey("Caliga") then
        return "Caliga"
    elseif town_hash == GetHashKey("cornwall") then
        return "Cornwall"
    elseif town_hash == GetHashKey("Emerald") then
        return "Emerald"
    elseif town_hash == GetHashKey("lagras") then
        return "lagras"
    elseif town_hash == GetHashKey("Manzanita") then
        return "Manzanita"
    elseif town_hash == GetHashKey("Rhodes") then
        return "Rhodes"
    elseif town_hash == GetHashKey("Siska") then
        return "Siska"
    elseif town_hash == GetHashKey("StDenis") then
        return "Saint Denis"
    elseif town_hash == GetHashKey("Strawberry") then
        return "Strawberry"
    elseif town_hash == GetHashKey("Tumbleweed") then
        return "Tumbleweed"
    elseif town_hash == GetHashKey("valentine") then
        return "Valentine"
    elseif town_hash == GetHashKey("VANHORN") then
        return "Vanhorn"
    elseif town_hash == GetHashKey("Wallace") then
        return "Wallace"
    elseif town_hash == GetHashKey("wapiti") then
        return "Wapiti"
    elseif town_hash == GetHashKey("AguasdulcesFarm") then
        return "Aguasdulces Farm"
    elseif town_hash == GetHashKey("AguasdulcesRuins") then
        return "Aguasdulces Ruins"
    elseif town_hash == GetHashKey("AguasdulcesVilla") then
        return "Aguasdulces Villa"
    elseif town_hash == GetHashKey("Manicato") then
        return "Manicato"
    elseif town_hash == false then
        return false
    end
end