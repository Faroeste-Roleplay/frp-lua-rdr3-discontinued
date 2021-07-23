Citizen.CreateThread(
    function()
        while true do 
            Citizen.Wait(1)            
            local Coords = GetEntityCoords(PlayerPedId(), true, true)
            if #(vec3(Coords - vector3(2692.821,-1507.797,42.689))) <= 2.5 then
                DrawText("Aperte ALT para ir para Guarma", 0.925, 0.96, 0.4, 0.4, false, 255, 255, 255, 145, 1, 7)
                if IsControlJustPressed(0, 0xE8342FF2) then
                    SetGuarma()
                end
            end

            if #(vec3(Coords - vector3(1270.919,-6854.643,43.324))) <= 2.5 then
                DrawText("Aperte ALT para ir para Saint Dennis", 0.925, 0.96, 0.4, 0.4, false, 255, 255, 255, 145, 1, 7)
                if IsControlJustPressed(0, 0xE8342FF2) then
                    SetSaintDennis()
                end
            end

        end
    end
)

function SetGuarma()
    DoScreenFadeOut(500)
    Wait(2000)
    SetEntityCoords(PlayerPedId(), 1270.919,-6854.643,43.324, 0,0,0, 0)
    Wait(5000)
    DoScreenFadeIn(500)
end

function SetSaintDennis()    
    DoScreenFadeOut(500)
    Wait(2000)
    SetEntityCoords(PlayerPedId(), 2692.821,-1507.797,42.689, 0,0,0, 0)
    Wait(5000)
    DoScreenFadeIn(500)
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



