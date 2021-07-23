local locationsToFeed = {
    vec3(-745.990, -1363.049, 43.234)
}

local carryingAndCanFeed = false

local closestFeedingIndex
local closestFeedingPosition

-- WORLD_HUMAN_FEED_CHICKEN
-- WORLD_HUMAN_FEED_CHICKENS_FEMALE_A
-- WORLD_HUMAN_FEED_CHICKENS_MALE_A

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            local ped = PlayerPedId()
            if Citizen.InvokeNative(0x2D0571BB55879DA2, ped) == GetHashKey("WORLD_HUMAN_FEEDBAG_PICKUP") then

                local pPosition = GetEntityCoords(ped)

                local cIndex
                local cDist

                for _, location in pairs(locationsToFeed) do
                    -- if
                    local dist = #(pPosition - location)
                    if dist <= 10.0 then
                        if cDist == nil or dist < cDist then
                            cIndex = _
                            cDist = dist
                        end
                    end
                end

                closestFeedingIndex = cIndex

                if closestFeedingIndex ~= nil then

                    closestFeedingPosition = locationsToFeed[closestFeedingIndex]

                    HandleFeedChickens()
                else
                    closestFeedingPosition = nil
                end
            else
                closestFeedingPosition = nil
            end

        end
    end
)

function HandleFeedChickens()

    local ped = PlayerPedId()
    while closestFeedingPosition ~= nil do
        Citizen.Wait(0)

        local pPosition = GetEntityCoords(ped)

        local dist = #(pPosition - closestFeedingPosition)

        if dist <= 1.5 then
            if PromptFeed() then
                PromptDelete(prompt)
                prompt = nil

                TaskStartScenarioInPlace(ped, GetHashKey("WORLD_HUMAN_FEED_CHICKEN"), 0, true, 0, -1.0, false)
            end
        end
    end
end

local prompt

function PromptFeed()
    if prompt == nil then
        prompt = NewPrompt()
        -- 0xE8342FF2
        PromptSetControlAction(prompt, 0x7F8D09B8)
        PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Alimentar Galinhas"))
        PromptSetStandardMode(prompt, true)
        PromptSetEnabled(prompt, 1)
        PromptSetVisible(prompt, 1)
        PromptSetHoldMode(prompt, 1)
        -- N_0x0c718001b77ca468(prompt, 3.0)
        -- PromptSetGroup(prompt, prompt_group)
        PromptRegisterEnd(prompt)
    end

    return PromptIsJustPressed(prompt)
end
