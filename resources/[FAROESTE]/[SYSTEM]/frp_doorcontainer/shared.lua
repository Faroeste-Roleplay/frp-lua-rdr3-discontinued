local SERVER = IsDuplicityVersion()
local CLIENT = not SERVER

-- doorHash { isOpen | doorPair | doorMinGroup }
local doorStates = {
    -- MANSÃO
    -- [1595076728] = {isOpen = false, pair =1439227364},
    -- [1439227364] = {isOpen = false, pair =1595076728},
    -- [530930529] = {isOpen = false, pair =1299101427},
    -- [1299101427] = {isOpen = false, pair =530930529},
    -- [764233269] = {isOpen = false},
    -- [2504431014] = {isOpen = false},
    -- HOUSE:1
    [1282705079] = {isOpen = false},
    [1511858696] = {isOpen = false},
    -- HOUSE:2
    [3929468747] = {isOpen = false},
    -- HOUSE:3
    [2847752952] = {isOpen = false},
    [1963415953] = {isOpen = false},
    -- HOUSE:4
    [52014802] = {isOpen = false},
    -- HOUSE:5
    [3268076220] = {isOpen = false},
    -- HOUSE:6
    [1434140379] = {isOpen = false},
    -- HOUSE:7
    [1934463007] = {isOpen = false},
    -----------------------------------
    -- OFFICER/JAIL
    [1207903970] = {isOpen = false},
    [902070893] = {isOpen = false},
    [831345624] = {isOpen = false},
    [2677989449] = {isOpen = false},
    [2984805596] = {isOpen = false},
    [1711767580] = {isOpen = false},
    [1995743734] = {isOpen = false},
    [2515591150] = {isOpen = false},
    [3365520707] = {isOpen = false},
    [2167775834] = {isOpen = false},
    [2514996158] = {isOpen = false},
    [2810801921] = {isOpen = false},
    [3410720590] = {isOpen = false, pair = 3821185084},
    [3821185084] = {isOpen = false, pair = 3410720590},
    [1878514758] = {isOpen = false},
    [1147152658] = {isOpen = false},
    [1514359658] = {isOpen = false},
    [1821044729] = {isOpen = false},
    [1508776842] = {isOpen = false},
    [295355979] = {isOpen = false},
    [193903155] = {isOpen = false},
    [395506985] = {isOpen = false},
    [1988748538] = {isOpen = false},
    [1657401918] = {isOpen = false},
    [1502928852] = {isOpen = false},
    [2212368673] = {isOpen = false},
    [1614494720] = {isOpen = false},
    -----------------------------------
    -- SHERIFF
    [349074475] = {isOpen = false},
    -- BANKS DOORS
    [3317756151] = {isOpen = true, pair = 3088209306},
    [3088209306] = {isOpen = true, pair = 3317756151},
    [2158285782] = {isOpen = true, pair = 1733501235},
    [1733501235] = {isOpen = true, pair = 2158285782},
    [2089945615] = {isOpen = true, pair = 2817024187},
    [2817024187] = {isOpen = true, pair = 2089945615},
    [3886827663] = {isOpen = true, pair = 2642457609},
    [1751238140] = {isOpen = true},
    [531022111] = {isOpen = true},
    [2058564250] = {isOpen = true},
    [1634115439] = {isOpen = true, pair = 3445627749},
    [3445627749] = {isOpen = true, pair = 1634115439},
    -- DP SAINT DENIS
    [417663242] = {isOpen = true, pair = 1611175760},
    [1611175760] = {isOpen = true, pair = 417663242},
    [3124713594] = {isOpen = false, pair = 1879655431},
    [1879655431] = {isOpen = false, pair = 3124713594},
    [3601535313] = {isOpen = false, pair = 3430284519},
    [3430284519] = {isOpen = false, pair = 3601535313},
    [1674105116] = {isOpen = false, pair = 1979938193},
    [1979938193] = {isOpen = false, pair = 1674105116},
    [1694749582] = {isOpen = false, pair = 1992193795},
    [1992193795] = {isOpen = false, pair = 1694749582},
    [2503834054] = {isOpen = false, pair = 305296302},
    [305296302] = {isOpen = false, pair = 2503834054},
    [603068205] = {isOpen = false, pair = 1020479727},
    [1020479727] = {isOpen = false, pair = 603068205},
    -- GUNSMITH VALENTINE
    [2042647667] = {isOpen = true},
    [475159788] = {isOpen = true},
    -- MEDIC VALENTINE
    [3439738919] = {isOpen = true},
    [-302968547] = {isOpen = true},
    -- STABLE VALENTINE
    [1132010214] = {isOpen = true, pair = 1876749464},
    [1331491364] = {isOpen = true, pair = 1876749464},
    [3804893186] = {isOpen = true}, -- store cloth saint denis
    [586229709] = {isOpen = true}, -- Doctor's office at Saint Dennis
    [1104407261] = {isOpen = true} -- Doctor's office at Saint Dennis
    -- [1276527334] = {isOpen = true} -- Doctor's office at Saint Dennis -- Not useable
}

-- TALVEZ MUDAR O SISTEMA PARA O CLIENT SÓ PEDIR O SYNC
-- DE x PORTA QUANDO ELE ESTIVER PROXIMO DA PORTA!

Citizen.CreateThread(
    function()
        if SERVER then
            local Tunnel = module("_core", "lib/Tunnel")
            local Proxy = module("_core", "lib/Proxy")

            API = Proxy.getInterface("API")
            cAPI = Tunnel.getInterface("API")

            function setControllableDoorsForGroup(group, doorHashArray)
                for _, doorHash in pairs(doorHashArray) do
                    if doorStates[doorHash] then
                        doorStates[doorHash].permGroup = group
                    end
                end
            end

            -- setControllableDoorsForGroup(
            --     "house:1",
            --     {
            --         1595076728,
            --         1439227364,
            --         530930529,
            --         1299101427,
            --         764233269,
            --         2504431014
            --     }
            -- )

            setControllableDoorsForGroup(
                "house:1",
                {
                    1282705079,
                    1511858696
                }
            )

            setControllableDoorsForGroup(
                "house:2",
                {
                    3929468747
                }
            )

            setControllableDoorsForGroup(
                "house:3",
                {
                    2847752952,
                    1963415953
                }
            )

            setControllableDoorsForGroup(
                "house:4",
                {
                    52014802
                }
            )

            setControllableDoorsForGroup(
                "house:5",
                {
                    3268076220
                }
            )

            setControllableDoorsForGroup(
                "house:6",
                {
                    1434140379
                }
            )

            setControllableDoorsForGroup(
                "house:7",
                {
                    1934463007
                }
            )

            -- setControllableDoorsForGroup(
            --     "house:4",
            --     {
            --         1377231573
            --     }
            -- )

            setControllableDoorsForGroup(
                "trooper",
                {
                    1207903970,
                    902070893,
                    831345624,
                    2677989449,
                    2984805596,
                    1711767580,
                    1995743734,
                    2515591150,
                    3365520707,
                    2167775834,
                    2514996158,
                    2810801921,
                    3410720590,
                    3821185084,
                    1878514758,
                    1147152658,
                    1514359658,
                    1821044729,
                    1508776842,
                    295355979,
                    193903155,
                    395506985,
                    1988748538,
                    1657401918,
                    1502928852,
                    2212368673,
                    1614494720,
                    417663242,
                    1611175760,
                    3124713594,
                    1879655431,
                    3601535313,
                    3430284519,
                    1674105116,
                    1979938193,
                    1694749582,
                    1992193795,
                    2503834054,
                    305296302,
                    603068205,
                    1020479727,
                    349074475,
                    1751238140
                }
            )

            -- setControllableDoorsForGroup(
            --     "sheriff",
            --     {
            --         349074475,
            --         1751238140
            --     }
            -- )

            RegisterNetEvent("FRP:DOORSTATECONTAINER:TryToToggleDoorState")
            AddEventHandler(
                "FRP:DOORSTATECONTAINER:TryToToggleDoorState",
                function(doorHash)
                    local _source = source
                    local User = API.getUserFromSource(_source)

                    if not doorStates[doorHash] then
                        User:notify("error", "ERROR PORTA REGISTRADA???")
                        return
                    end

                    local doorGroup = "admin"

                    if doorStates[doorHash].permGroup ~= nil then
                        doorGroup = doorStates[doorHash].permGroup
                    end

                    local Character = User:getCharacter()
                    if Character == nil or not Character:hasGroupOrInheritance(doorGroup) then
                        User:notify("error", "Você não pode abrir esta porta")
                        return
                    end

                    local newDoorState = not doorStates[doorHash].isOpen
                    doorStates[doorHash].isOpen = newDoorState

                    if doorStates[doorHash].pair ~= nil then
                        local doorPair = doorStates[doorHash].pair
                        print("Porta " .. doorHash .. " com par, porém o par não foi definido ...")
                        if doorStates[doorPair] and doorStates[doorPair].isOpen then
                            doorStates[doorPair].isOpen = newDoorState
                        end
                    end

                    TriggerClientEvent("FRP:DOORSTATECONTAINER:SetDoorState", -1, doorHash, newDoorState)
                end
            )

            AddEventHandler(
                "API:playerSpawned",
                function(source, user_id, isFirstSpawn)
                    if isFirstSpawn then
                        local _temp = deepcopy(doorStates)
                        for _, v in pairs(_temp) do
                            v.permGroup = nil
                            v.pair = nil
                        end

                        TriggerClientEvent("FRP:DOORSTATECONTAINER:SetMultipleDoorsState", source, _temp)
                    end
                end
            )

            Citizen.CreateThread(
                function()
                    Citizen.Wait(2000)

                    local _temp = deepcopy(doorStates)
                    for _, v in pairs(_temp) do
                        v.permGroup = nil
                        v.pair = nil
                    end

                    TriggerClientEvent("FRP:DOORSTATECONTAINER:SetMultipleDoorsState", -1, _temp)
                end
            )
        elseif CLIENT then
            RegisterNetEvent("FRP:DOORSTATECONTAINER:SetDoorState")
            AddEventHandler(
                "FRP:DOORSTATECONTAINER:SetDoorState",
                function(doorHash, doorState)
                    doorStates[doorHash].isOpen = doorState

                    RegisterDoorSomething(doorHash)
                    DoorSystemSetDoorState(doorHash, doorState == true and 0 or 1)

                    if doorStates[doorHash].pair ~= nil then
                        local doorPair = doorStates[doorHash].pair

                        if doorStates[doorPair] then
                            doorStates[doorPair].isOpen = doorState
                        end

                        RegisterDoorSomething(doorPair)
                        DoorSystemSetDoorState(doorPair, doorState == true and 0 or 1)
                    end
                end
            )

            RegisterNetEvent("FRP:DOORSTATECONTAINER:SetMultipleDoorsState")
            AddEventHandler(
                "FRP:DOORSTATECONTAINER:SetMultipleDoorsState",
                function(_doorStates)
                    for doorHash, d in pairs(_doorStates) do
                        doorStates[doorHash].isOpen = d.isOpen
                    end
                end
            )

            local closestDoorHash
            local closestDoor_displayasclosed = false

            Citizen.CreateThread(
                function()
                    while true do
                        local ped = PlayerPedId()
                        local pCoords = GetEntityCoords(ped)

                        local dist
                        for doorHash, values in pairs(doorStates) do
                            local doorEntity = GetDoorEntity(doorHash)

                            if DoesEntityExist(doorEntity) then
                                local doorIsOpen = values.isOpen

                                if not doorIsOpen then
                                    local doorPermGroup = values.permGroup

                                    if doorPermGroup then
                                        if not cAPI.hasGroupOrInheritance(doorPermGroup) then
                                            closestDoor_displayasclosed = true
                                        else
                                            closestDoor_displayasclosed = true
                                        end
                                    end
                                else
                                    closestDoor_displayasclosed = false
                                end

                                RegisterDoorSomething(doorHash)
                                DoorSystemSetDoorState(doorHash, doorIsOpen == true and 0 or 1)

                                local _dist = #(pCoords - GetEntityCoords(doorEntity))

                                if _dist <= 50 and (dist == nil or _dist < dist) then
                                    dist = _dist
                                    closestDoorHash = doorHash
                                end
                            end
                        end

                        if dist == nil then
                            closestDoorHash = nil
                        end

                        Citizen.Wait(1000)
                    end
                end
            )

            local prompt_group_open
            local prompt_open

            local prompt_group_close
            local prompt_close

            -- local prompt_group_name = CreateVarString(10, "LITERAL_STRING", "Porta")

            Citizen.CreateThread(
                function()
                    initPrompts()

                    while true do
                        Citizen.Wait(0)

                        if closestDoorHash ~= nil then
                            local doorEntity = GetDoorEntity(closestDoorHash)

                            local ped = PlayerPedId()
                            local pCoords = GetEntityCoords(ped)

                            local dist = #(pCoords - GetEntityCoords(doorEntity))

                            if dist <= 1.7 then
                                local playingUnlockAnimation = IsEntityPlayingAnim(ped, "script_common@jail_cell@unlock@key", "action", 3)

                                -- drawHandle(doorEntity)

                                local hourCloseAt, hourOpenAt = doorStates[closestDoorHash].closeAt, doorStates[closestDoorHash].openAt

                                local isOpen = doorStates[closestDoorHash].isOpen

                                if hourCloseAt and hourOpenAt then
                                    local hour = GetClockHours()

                                    if hour >= hourCloseAt and house < hourOpenAt then
                                        if isOpen then
                                            TriggerClientEvent("FRP:DOORSTATECONTAINER:SetDoorState", closestDoorHash, false)
                                        end
                                    else
                                        if not isOpen then
                                            TriggerClientEvent("FRP:DOORSTATECONTAINER:SetDoorState", closestDoorHash, true)
                                        end
                                    end
                                end

                                if HasEntityClearLosToEntityInFront(ped, doorEntity, 0) and not playingUnlockAnimation then
                                    if isOpen == true then
                                        PromptSetActiveGroupThisFrame(prompt_group_close, CreateVarString(10, "LITERAL_STRING", "Porta"))

                                        if PromptHasHoldModeCompleted(prompt_close) then
                                            PromptSetEnabled(prompt_close, false)
                                            Citizen.CreateThread(
                                                function()
                                                    Citizen.Wait(250)
                                                    PromptSetEnabled(prompt_close, true)
                                                end
                                            )

                                            unlockAnimation()
                                            TriggerServerEvent("FRP:DOORSTATECONTAINER:TryToToggleDoorState", closestDoorHash)
                                        end
                                    else
                                        if closestDoor_displayasclosed == false then
                                            PromptSetActiveGroupThisFrame(prompt_group_open, CreateVarString(10, "LITERAL_STRING", "Porta"))

                                            if PromptHasHoldModeCompleted(prompt_open) then
                                                PromptSetEnabled(prompt_open, false)
                                                Citizen.CreateThread(
                                                    function()
                                                        Citizen.Wait(250)
                                                        PromptSetEnabled(prompt_open, true)
                                                    end
                                                )

                                                unlockAnimation()
                                                TriggerServerEvent("FRP:DOORSTATECONTAINER:TryToToggleDoorState", closestDoorHash)
                                            end
                                        else
                                            if hourOpenAt then
                                                PromptSetActiveGroupThisFrame(prompt_group_open, CreateVarString(10, "LITERAL_STRING", "Fechado, Abre às " .. hourOpenAt))
                                            else
                                                PromptSetActiveGroupThisFrame(prompt_group_open, CreateVarString(10, "LITERAL_STRING", "Fechado"))
                                            end

                                            DisableControlAction(0, 0xDFF812F9, true) -- Abrir/Fechar
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            )

            function initPrompts()
                prompt_group_open = GetRandomIntInRange(0, 0xffffff)

                prompt_open = PromptRegisterBegin()
                PromptSetControlAction(prompt_open, 0xDFF812F9)
                PromptSetText(prompt_open, CreateVarString(10, "LITERAL_STRING", "Abrir"))
                PromptSetEnabled(prompt_open, true)
                PromptSetVisible(prompt_open, true)
                PromptSetHoldMode(prompt_open, true)
                PromptSetGroup(prompt_open, prompt_group_open)
                PromptRegisterEnd(prompt_open)

                prompt_group_close = GetRandomIntInRange(0, 0xffffff)

                prompt_close = PromptRegisterBegin()
                PromptSetControlAction(prompt_close, 0xDFF812F9)
                PromptSetText(prompt_close, CreateVarString(10, "LITERAL_STRING", "Fechar"))
                PromptSetEnabled(prompt_close, true)
                PromptSetVisible(prompt_close, true)
                PromptSetHoldMode(prompt_close, true)
                PromptSetGroup(prompt_close, prompt_group_close)
                PromptRegisterEnd(prompt_close)
            end

            function unlockAnimation()
                local dict = "script_common@jail_cell@unlock@key"
                if not HasAnimDictLoaded(dict) then
                    RequestAnimDict(dict)
                    while not HasAnimDictLoaded(dict) do
                        Citizen.Wait(10)
                    end
                end

                local ped = PlayerPedId()

                local prop = CreateObject("P_KEY02X", GetEntityCoords(ped) + vec3(0, 0, 0.2), true, true, true)
                local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_Finger12")

                TaskPlayAnim(ped, "script_common@jail_cell@unlock@key", "action", 8.0, -8.0, 2500, 31, 0, true, 0, false, 0, false)
                Wait(750)
                AttachEntityToEntity(prop, ped, boneIndex, 0.02, 0.0120, -0.00850, 0.024, -160.0, 200.0, true, true, false, true, 1, true)

                while IsEntityPlayingAnim(ped, "script_common@jail_cell@unlock@key", "action", 3) do
                    Wait(100)
                end

                DeleteObject(prop)
            end

            function GetDoorEntity(doorHash)
                return Citizen.InvokeNative(0xF7424890E4A094C0, doorHash)
            end

            function RegisterDoorSomething(doorHash)
                Citizen.InvokeNative(0xD99229FE93B46286, doorHash, 1, 1, 0, 0, 0, 0)
            end

            -- function drawHandle(entity)
            --     local offset = GetOffsetFromEntityInWorldCoords(entity, 1.05, 0.0, 1.0)
            --     Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,GetEntityCoords(entity), offset, 255, 0, 0, 255)
            --     Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,GetEntityCoords(PlayerPedId()), offset, 255, 0, 0, 255)
            -- end

            function GetRegisteredDoorHashInRadius(radius, requiredState)
                local playerPed = PlayerPedId()
                local playerPosition = GetEntityCoords(playerPed)

                local closestDistance

                local closestDoorHash

                for doorHash, d in pairs(doorStates) do
                    local doorEntity = GetDoorEntity(doorHash)

                    if DoesEntityExist(doorEntity) then
                        local doorPosition = GetEntityCoords(doorEntity)

                        local distance = #(playerPosition - doorPosition)

                        if distance <= radius then
                            if requiredState == -1 or DoorSystemGetDoorState(doorHash) == requiredState then
                                if not closestDistance or distance < closestDistance then
                                    closestDistance = distance

                                    closestDoorHash = doorHash
                                end
                            end
                        end
                    end
                end

                return closestDoorHash
            end

            AddEventHandler(
                "onResourceStop",
                function(resourceName)
                    if GetCurrentResourceName() == resourceName then
                        PromptDelete(prompt_open)
                        PromptDelete(prompt_close)
                    end
                end
            )
        end
    end
)
