RegisterCommand('jornal',function()
   
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("WORLD_HUMAN_LEAN_BARREL"), 100000,true,false, false, false)


SendNUIMessage(
        {
            action = 'show'
        }
    )
    SetNuiFocus(true, true)

end)

RegisterNUICallback('close', function()   
    local ped = PlayerPedId()
    ClearPedTasks(ped)
    SetNuiFocus(false, false)

end)