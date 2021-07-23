local pigeons = {}

local prompt
local prompt_name = CreateVarString(10, "LITERAL_STRING", "Pombo Correio")



RegisterNetEvent("FRP:PEAGLE:GetCoords")
AddEventHandler(
    "FRP:PEAGLE:GetCoords",
    function(tplayer,Mensagem)

    local ped = PlayerPedId()
    local Coords = GetEntityCoords(ped)

    TriggerServerEvent("FRP:PEAGLE:ReceiveCoords", Coords, tplayer, Mensagem)
end)


back = true
Notified = false
dst = nil
local pigeon = nil
message = nil
local blip

RegisterNetEvent('FRP:PEAGLE:ReceiveMenssage')
AddEventHandler('FRP:PEAGLE:ReceiveMenssage', function(PlayerCoords, text)
        pigeon = CreatePed("A_C_Pigeon", PlayerCoords, 92.0, true, true, true, true)
        Citizen.InvokeNative(0x283978A15512B2FE, pigeon, true)
        message = text
        ClearPedTasks(pigeon)
        ClearPedSecondaryTask(pigeon)
        ClearPedTasksImmediately(pigeon)
        SetPedFleeAttributes(pigeon, 0, 0)
        TaskWanderStandard(pigeon, 1, 0)
        TaskSetBlockingOfNonTemporaryEvents(pigeon, 1)
        SetEntityAsMissionEntity(pigeon)        
        Wait(2000)        
        local playc = GetEntityCoords(PlayerPedId())
        TaskFlyToCoord(pigeon, 0, playc.x, playc.y, playc.z+30, 1, 0)
        Citizen.InvokeNative(0xA5C38736C426FCB8, pigeon, true)

        local blipname = "Pombo Correio"
        local bliphash = 587827268
        blip = Citizen.InvokeNative(0x23f74c2fda6e7c61, bliphash, pigeon) -- BLIPADDFORENTITY
        SetBlipScale(blip, 0.5)

        while true do
            Citizen.Wait(1)
                local player = PlayerPedId()
                local coords = GetEntityCoords(player)
                local ec = GetEntityCoords(pigeon)
                local myV = vector3(coords.x, coords.y, coords.z)
                dst = #(vector3(ec.x, ec.y, ec.z) - myV)
                local ed = coords.x, coords.y, coords.z
                local playc = GetEntityCoords(PlayerPedId())

                if back then
                    TaskFlyToCoord(pigeon, 0, playc.x, playc.y, playc.z+30, 1, 0)
                end                
              
                if dst < 25 then  
                    if not Notified then
                        TriggerEvent('FRP:NOTIFY:Simple', 'Você recebeu um pombo correio, espere até o pombo se aproximar de ti.', 5000)
                        Notified = true 
                        back = false                   
                    end
                    -- local IsPedAir = IsEntityInAir(pigeon, 1)
              
                    -- if IsControlJustPressed(0, 0xE8342FF2) then -- Hold ALT
                    --     print('pressed')
                    --    -- TaskWhistleAnim(PlayerPedId(), -433953410, 1971704925)                        
                    --     back = false
                    --     Wait(15000)
                    --     TaskFlyToCoord(pigeon, 0, playc.x, playc.y, playc.z, 1, 0)                          
                    -- end
                end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(8000)
            local IsPedAir = IsEntityInAir(pigeon, 1)
            local playc = GetEntityCoords(PlayerPedId())
            if pigeon ~= nil then
                if not IsPedAir and Notified and dst > 4 then
                    TaskFlyToCoord(pigeon, 0, playc.x, playc.y, playc.z, 1, 0)
                 --   TaskGoToEntity(pigeon, PlayerPedId(), -1, 2.5, 2, 0, 0)    
                end
            end
        end
    end
)       


Citizen.CreateThread(
    function()
        InitiatePrompts()
        while true do
            Citizen.Wait(0)        
            if Notified and dst < 4 then
                PromptSetActiveGroupThisFrame(prompt_group, prompt_name)
                HandlePrompts()
            end 
        end
    end
)

       

function openGuiRead(text)
    local veh = GetVehiclePedIsUsing(PlayerPedId())
    if GetPedInVehicleSeat(veh, -1) ~= PlayerPedId() then
            SetPlayerControl(PlayerId(), 0, 0)
            isUiOpen = true
            Citizen.Trace("OPENING")
            SendNUIMessage({
                action = 'openNotepadRead',
                TextRead = text,
            })
            SetNuiFocus(true, true)

    end  
end


function HandlePrompts()
    if PromptHasHoldModeCompleted(prompt) then
        PromptSetEnabled(prompt, false)
        Citizen.CreateThread(
            function()
                Citizen.Wait(1000)
                PromptSetEnabled(prompt, true)
            end
        )                     
        if dst < 3.5 then
            local carriable = Citizen.InvokeNative(0xF0B4F759F35CC7F5, pigeon, Citizen.InvokeNative(0x34F008A7E48C496B, pigeon, 2), 0, 0, 512)
            TaskPickupCarriableEntity(PlayerPedId(), carriable)  
            openGuiRead(message)
            TriggerServerEvent("FRP:PEAGLE:AddPombo")
            Wait(2500)
            DeleteEntity(pigeon)
            --RemoveBlip(blip)     
        end
    end
end



function InitiatePrompts()
    prompt_group = GetRandomIntInRange(0, 0xffffff)
    prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, 0xE8342FF2)
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Pegar Mensagem"))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, true)
    -- Citizen.InvokeNative(0xAE84C5EE2C384FB3, prompt, position)
    -- Citizen.InvokeNative(0x0C718001B77CA468, prompt, 3.0)
    PromptSetGroup(prompt, prompt_group)
    PromptRegisterEnd(prompt)
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if GetCurrentResourceName() == resourceName then
            -- for _, prompt in pairs(prompts) do
            PromptDelete(prompt)
        -- end
        end
    end
)