-- FRP:TOAST:New -> "speech", "Simular a fala de um personagem"
-- FRP:TOAST:New -> "dev", "Mensagem com intuito de ser para Devs"
-- FRP:TOAST:New -> "alert", "Você é viado"
-- FRP:TOAST:New -> "alert", "Você é viado"
-- FRP:TOAST:New -> "success", "Você é viado"
-- FRP:TOAST:New -> "error", "Você é viado"
-- FRP:TOAST:New -> "gold", 10
-- FRP:TOAST:New -> "gold", -10
-- FRP:TOAST:New -> "dollar", 10
-- FRP:TOAST:New -> "dollar", -10
-- FRP:TOAST:New -> "item", "Pistola Vulcan", 10
-- FRP:TOAST:New -> "item", "Pistola Vulcan", -10
-- FRP:TOAST:New -> "longer_alert", "Toast que demora mais tempo para sumir, funciona para todos",

RegisterNetEvent("FRP:TOAST:New")
AddEventHandler(
    "FRP:TOAST:New",
    function(type, text, quantity)
        if type == "item" then
            if ItemList[text] then
                if text == "money" or text == "gold" then
                    quantity = quantity / 100
                    if text == "money" then
                        type = "dollar"
                    elseif text == "gold" then
                        type = "gold"
                    end
                else
                    text = ItemList[text].name
                end
            end
        end

        -- if tonumber(text) then
        --     quantity = text
        --     text = nil
        -- end

        if type == "xp" then
            quantity = text
            text = nil
        end

        SendNUIMessage(
            {
                type = type,
                text = text,
                quantity = quantity
            }
        )
    end
)
